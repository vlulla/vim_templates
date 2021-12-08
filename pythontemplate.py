##
##
## Author: Vijay Lulla
## Date:
##
import re,os,sys,sqlite3,datetime,logging
import numpy as np, pandas as pd
import matplotlib.pyplot as plt
# import hypothesis as hy, hypothesis.strategies as st
## import geopandas as gp, hypothesis as hp

logging.basicConfig(filename=f"log-{str(datetime.datetime.now().date())}.log", level=logging.INFO, encoding="utf-8", filemode="w", format="{asctime} - {levelname} - {message!r}", style="{",  datefmt="%Y.%m.%dT%H:%M:%S%z")

def f1(**kwargs):
  print("key\tvalue")
  print("---\t-----")
  for k,v in kwargs.items():
    print(f"{k}\t{v}")

def main():
    logging.info("In main")
    print("hello world!")
    f1(fname="vijay",lname="lulla",addr="mythical city",salary=5.2)
    f1(x=[1,2,3,4,5],y=[1,2,3,4,5])
    million, scaler = 1_000_000, 0.89
    print(f"${million:_d} US = \u20ac{million*scaler:4_.2f}")

if __name__ == "__main__":
    main()

