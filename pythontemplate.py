# vim:fileencoding=utf-8:expandtab:tabstop=8:shiftwidth=2:softtabstop=2:textwidth=160:noautoindent:nocindent:nosmartindent
##
## Author: Vijay Lulla
## Date:
##
## NOTE: To enable running assert statements ensure that PYTHONOPTIMIZE is not set.
##       It is best to start the script like so:
##
##       ~ $ PYTHONOPTIMIZE=0 python3 -i <your-script.py>
##
##       Especially, check out the function test_sum()!! And, check out the log that is generated!

import re, os, sys, sqlite3, datetime, logging, typing, functools, pathlib, inspect
import numpy as np, pandas as pd ## , xarray as xr, zarr
import dask.dataframe as dd, dask.array as da, dask.bag as db ## for distributed computing!
import matplotlib.pyplot as plt
import hypothesis as hy, hypothesis.strategies as st
## import geopandas as gp, hypothesis as hp

T = typing.TypeVar("T")
P = typing.ParamSpec("P")

logging.basicConfig(filename=f"log-{str(datetime.datetime.now().date())}.log", level=logging.DEBUG, encoding="utf-8", format="{asctime} - {levelname} - {message!r}", style="{",  datefmt="%Y.%m.%dT%H:%M:%S%z")

def log(func: typing.Callable[P,T]) -> typing.Callable[P,T]:
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


@log
def f1(**kwargs: typing.Dict[typing.Any,typing.Any]) -> typing.Any:
  print("key\tvalue")
  print("---\t-----")
  for k,v in kwargs.items():
    print(f"{k}",f"{v}",sep="\t")

Num = typing.TypeVar('Num', int, float, complex)
@log
def sum(a:Num, b:Num) -> Num: return a+b

@log
def prod(a:Num, b:Num) -> Num: return a*b

@log
@hy.settings(max_examples=500, verbosity=hy.Verbosity.verbose)
@hy.given(a=st.one_of(st.integers(), st.floats()), b=st.one_of(st.integers(), st.floats()))
def test_sum(a: int|float, b:int|float) -> None:
  """ This ought to fail for quite a few cases!!!

      Included here just to demonstrate how to use hypothesis for PBT.
  """
  assert a + b == sum(a,b)
  assert sum(a,b) >= a
  assert sum(a,b) >= b

@log
def main():
  logging.info("In main")
  print("hello world!")
  f1(fname="vijay",lname="lulla",addr="mythical city",salary=5.2)
  f1(x=[1,2,3,4,5],y=[1,2,3,4,5])
  million, scaler = 1_000_000, 0.89
  print(f"${million:_d} US = \u20ac{million*scaler:4_.2f}")
  print(f"sum(2, 18.25) is {sum(2,18.5)} and prod(2, 18.5) is {prod(2,18.5)}")

if __name__ == "__main__":
  main()

