#!/usr/bin/env -S Rscript --vanilla
# If you want to run this script from cli then chmod +x it!

Sys.time() ## Tremendous help in .Rout files!

library(stringi)
library(RSQLite)
library(data.table)
library(fastmatch); match <- fastmatch::fmatch # faster match!
library(collapse)
library("duckdb")

library(terra) ## library(rgdal)
library(sp)
library(sf)
library(raster)

library(ggplot2)
## library(tidyverse)

## library(randomForest)
## library(glmnet)
## library(xgboost)
## library(e1071)
## library(gbm)
## library(nnet)
## library(caret)

library(rbenchmark)

DT <- with(list(cols=sprintf("col%02d",seq_len(15))),as.data.table(sapply(cols,\(n){sample(seq_len(100),15,replace=T)})))
str(DT)
