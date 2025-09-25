# vim:fileencoding=utf-8:expandtab:tabstop=8:shiftwidth=4:softtabstop=4:textwidth=120:noautoindent:nocindent:nosmartindent
# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "duckdb", "hypothesis", "matplotlib", "numpy", "pandas", "polars", "pyarrow", "pytest", "seaborn",
# ]
# ///
##
## ~ $ PYTHONOPTIMIZE=0 python3 -i <your-script.py> ## when you are developing
## ~ $ python3 -I -E -O <your-script.py>  ## when you want to deploy...this removes the if __debug__ and assert checks!
## ~ $ python3 -I -E -OO <your-script.py> ## even more optimization... removes docstrings!
##
## OR better yet...
## ~ $ uv run <your-script.py> ## this will automatically install packages listed in the script block above. PEP-723
## TODO (vijay): Figure out how to run interactive session with uv!

import datetime
import logging
import typing
import functools
import inspect
import pytest
import statistics as stats
import time
## import numpy as np, pandas as pd, pyarrow as pa, duckdb as ddb, polars as pl
## import matplotlib.pyplot as plt,seaborn as sns
import hypothesis as hy
import hypothesis.strategies as st
## ddb.execute("SET GLOBAL pandas_analyze_sample = 100_000")

if __debug__: import pdb

T = typing.TypeVar("T")
P = typing.ParamSpec("P")

logging.basicConfig(
    filename=f"{__file__}-{str(datetime.datetime.now().date())}.log",
    level=logging.DEBUG,
    encoding="utf-8",
    format="{asctime} - {levelname} - {message!r}",
    style="{",
    datefmt="%Y.%m.%dT%H:%M:%S%z",
)


def grid(axis: typing.Literal["both", "x", "y"] = "both") -> None:
    "Show the grid...kinda like graph paper"
    import matplotlib.pyplot as plt
    plt.minorticks_on()
    plt.grid(which="major", linestyle="-", alpha=0.75, axis=axis)
    plt.grid(which="minor", linestyle=":", alpha=0.5, axis=axis)


def log(func: typing.Callable[P, T]) -> typing.Callable[P, T]:
    @functools.wraps(func)
    def wrapper(*args: P.args, **kwargs: P.kwargs) -> T:
        signature = ", ".join([f"{a!r}" for a in args] + [f"{k}={v!r}" for k,v in kwargs.items()])
        logger = logging.getLogger()
        logger.debug(f"function {func.__name__}{inspect.signature(func)} called ==> {func.__name__}({signature})")
        try:
            result = func(*args, **kwargs)
            return result
        except Exception as e:
            logger.exception(f"Exception raised in {func.__name__}. exception: {e!s}")
            raise e
    return wrapper


def timefunc(func: typing.Callable[P, T]) -> typing.Callable[P, T]:
    """
    Log how long it takes to run the function.
    >>> @timefunc
        def tst():
            time.sleep(5)
            pass
    >>> logging.getLogger("timefunc").setLevel(logging.DEBUG)
    >>> tst()
    DEBUG:timefunc:tst took: 5.005141952 seconds

    NOTE: If logging does not show up (usually the case in ipython), call `logging.basicConfig()` in the repl to initialize logging.
    """

    @functools.wraps(func)
    def wrapper(*args: P.args, **kwargs: P.kwargs) -> T:
        logger = logging.getLogger("timefunc")
        signature = ", ".join([f"{a!r}" for a in args] + [f"{k}={v!r}" for k,v in kwargs.items()])
        try:
            start_time = time.monotonic_ns()
            result = func(*args, **kwargs)
            logger.debug(
                f"{func.__name__}({signature}) took: {(time.monotonic_ns() - start_time) / 1_000_000_000} seconds"
            )  ## TODO (vijay): will this be logged if exception is raised in a long running function?
            return result
        except Exception as e:
            logger.exception(f"Exception raised in {func.__name__}({signature}). exception: {e!s}")
            raise e
    return wrapper


@log
def f1(**kwargs: typing.Any) -> None:
    print("key\tvalue")
    print("---\t-----")
    for k, v in kwargs.items():
        print(f"{k=}", f"{v=}", sep="\t")


Num = typing.TypeVar("Num", int, float, complex)


@log
def sum(a: Num, b: Num) -> Num:
    return a + b


@log
def prod(a: Num, b: Num) -> Num:
    return a * b


@log
@hy.settings(max_examples=500, verbosity=hy.Verbosity.verbose)
@hy.given(
    a=st.one_of(st.integers(), st.floats()), b=st.one_of(st.integers(), st.floats())
)
def test_sum(a: Num, b: Num) -> None:
## def test_sum[T: int | float](a: T, b: T) -> None:
    """This ought to fail for quite a few cases!!!

    Included here just to demonstrate how to use hypothesis for PBT.
    """
    assert a + b == sum(a, b)
    if isinstance(a, complex) or isinstance(b, complex): return
    assert sum(a, b) >= a
    assert sum(a, b) >= b


@log
@pytest.mark.parametrize(
    ("test_input", "expected"),
    [("3+5", 8), ("2+4", 6), pytest.param("6*9", 42, marks=pytest.mark.xfail)],
)
def test_eval(
    test_input: str, expected: Num
) -> None:  ## the args have to match args listed in the pytest.mark.parametrize tuple!
    assert eval(test_input) == expected


@log
def main() -> None:
    logging.info("In main")
    print("hello world!")
    f1(fname="vijay", lname="lulla", addr="mythical city", salary=5.2)
    f1(x=[1, 2, 3, 4, 5], y=[1, 2, 3, 4, 5])
    million, scaler = 1_000_000, 0.89
    if __debug__: pdb.set_trace()
    print(f"${million:_d} US = \u20ac{million * scaler:4_.2f}")
    print(f"{sum(2,18.5)=}\n{prod(2,18.5)=}")

    today = datetime.datetime.now()
    print(f"{today:%B %d, %Y}\n"
          f"{today=:%B %d, %Y}\n"
          f"{ today = :%B %d, %Y}" ) ## NOTE: whitespace preserved!
    print(stats.quantiles(range(1, 100), n=10))
    year, films_totals = [1971, 1975, 1979, 1982, 1983], [1, 2, 3, 4, 5]
    slope, intercept = stats.linear_regression(year, films_totals)
    print(f"{round(slope * 2019 + intercept)}")


if __name__ == "__main__":
    main()
