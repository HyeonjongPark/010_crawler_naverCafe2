library(dplyr)
library(DT)
library(lubridate)
library(digest)
library(data.table)
Lotto_fraud_code = function() {
  
  set.seed(as.integer(paste0(year(Sys.Date()),week(Sys.Date()))))
  
  row1 = sample(1:45,6, replace = FALSE)
  row2 = sample(1:45,6, replace = FALSE)
  row3 = sample(1:45,6, replace = FALSE)
  row4 = sample(1:45,6, replace = FALSE)
  row5 = sample(1:45,6, replace = FALSE)
  
  lotto = rbind(row1,row2,row3,row4,row5)
  lotto_dt = datatable(lotto,extensions = c('Buttons'), options = list(
    deferRender = TRUE,
    dom = 'Bfrtip',
    buttons = c('copy', 'excel')
  ))
  
  return(lotto)
}


real = as.data.frame(matrix(c(1,16,20,35,39,43),1,6))
rownames(real) = "row"

bonus = 17


Lotto_jackpot_code = function() {
  seed_number = as.integer(paste0(year(Sys.Date()),week(Sys.Date())))
  #set.seed(seed_number)
  lotto_number = sample(1:45,7) %>% sort()
  lotto_number = list(real = lotto_number[1:6], bonus = lotto_number[7])
  
  return(lotto_number)
}

Lotto_simulation = function(lotto_df) {
  
  lotto_inspec = data.frame(V1=c(),V2=c(),V3=c(),V4=c(),V5=c(),V6=c(),true_count=c())
  
  for(i in 1:nrow(lotto_df)) {
    lotto_inspec = rbind(lotto_inspec, as.data.frame(t(lotto_df[i,] %in% Lotto_jackpot_code()$real)))
    
  }
  lotto_inspec$true_count = NA
  for(j in 1:nrow(lotto_df)) {
    lotto_inspec$true_count[j] = sum(as.vector(t(lotto_inspec[j,1:6])))
  }
  
  lotto_rank = NA
  for(k in 1:nrow(lotto_df)) {
    if(lotto_inspec$true_count[k] == 6) {
      lotto_inspec$lotto_rank[k] = "1등"
    }
    else if(lotto_inspec$true_count[k] == 5 & sum(lotto_df[k,] %in% Lotto_jackpot_code()$bonus)) {
      lotto_inspec$lotto_rank[k] = "2등"
    }
    else if(lotto_inspec$true_count[k] == 5) {
      lotto_inspec$lotto_rank[k] = "3등"
    }
    else if(lotto_inspec$true_count[k] == 4) {
      lotto_inspec$lotto_rank[k] = "4등"
    }
    else if(lotto_inspec$true_count[k] == 3) {
      lotto_inspec$lotto_rank[k] = "5등"
    }
    else {
      lotto_inspec$lotto_rank[k] = "꽝"
    }
  }
  
  lotto_inspec2 = cbind(lotto_df[,1:6], lotto_inspec[,7:8])
  
  return(lotto_inspec2)
  
}








count_rank1 = 0
count_rank2 = 0
count_rank3 = 0
count_rank4 = 0
count_rank5 = 0
count_nope = 0




buy_count = 1000


for(i in 1:buy_count) {
  df = data.frame()
  for(k in 1:5) {
    df = rbind(df, sample(1:45,6, replace = FALSE) %>% sort() %>% t() %>% as.data.frame())
  }
  
  #bundle = Lotto_simulation(df[(seq(5,nrow(df), 5)[1]-4):(seq(5,nrow(df), 5)[1]),])
  bundle = Lotto_simulation(df)
  bundle
  for(j in 1:5) {
    if(bundle$lotto_rank[j] == "1등") {
      count_rank1 = count_rank1 + 1
    }
    else if(bundle$lotto_rank[j] == "2등") {
      count_rank2 = count_rank2 + 1
    }
    else if(bundle$lotto_rank[j] == "3등") {
      count_rank3 = count_rank3 + 1
    }
    else if(bundle$lotto_rank[j] == "4등") {
      count_rank4 = count_rank4 + 1
    }
    else if(bundle$lotto_rank[j] == "5등") {
      count_rank5 = count_rank5 + 1
    }
    else if(bundle$lotto_rank[j] == "꽝") {
      count_nope = count_nope + 1
    }
    
  }
  
  count_df = data.frame(구매횟수 = i,
                        당첨1등 = count_rank1,
                        당첨2등 = count_rank2,
                        당첨3등 = count_rank3,
                        당첨4등 = count_rank4,
                        당첨5등 = count_rank5,
                        꽝 = count_nope) %>% t()
  colnames(count_df) = "index"
  print(count_df)
}









testRec = list(source1 = data.frame(rec1 = c(1,2,3),
                                rec2 = c(3,4,5)),
               source2 = data.frame(rec1 = c(1,2,4,5),
                                rec2 = c(1,3,2,1),
                                rec3 = c(6,5,3,2)))






memory.size (max = F)

gc()
a<-c(1:10000000)
b<-c(1:20000000)
c<-c(1:20000000)
memory.size() 








