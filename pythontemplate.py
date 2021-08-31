##
##
## Author: Vijay Lulla
## Date:
##
import re,os,sys,sqlite3,datetime
import numpy as np, pandas as pd
import matplotlib.pyplot as plt
# import hypothesis as hy, hypothesis.strategies as st

## import geopandas as gp, hypothesis as hp

## import arcpy as ap

def f1(**kwargs):
  print("key\tvalue")
  print("---\t-----")
  for k,v in kwargs.items():
    print(f"{k}\t{v}")

def main():
    print("hello world!")
    f1(fname="vijay",lname="lulla",addr="mythical city",salary=5.2)
    f1(x=[1,2,3,4,5],y=[1,2,3,4,5])


if __name__ == "__main__":
    main()

