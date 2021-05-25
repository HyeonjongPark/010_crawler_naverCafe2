
#library(rmarkdown)
library(rsconnect)
deployApp("./dash_v2.Rmd")

#deployments("./dash_v2.Rmd")




#' @echo off
#' 
#' D:
#' cd D:\workspace\python_workspace\01_cafeCrawler
#' python naverCafeWriteAll.py
#' python naverCafeReplyAll.py
#' 
#' cd D:\workspace\010_crawler_naverCafe2
#' 
#' Rscript src/03_preprocessing.R
#' Rscript dash_executor.R
#' 
#' exit
