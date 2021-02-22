source("./src/01_libraries.R")

## function

cafe_write_func = function(data, start_date, end_date) {
  
  # cafeWritten = readxl::read_excel("D:/workspace/python_workspace/01_cafeCrawler/naverCafeWrite_A.xlsx")
  
  data$date[str_length(data$date) == 5] = paste0(gsub("-",".",end_date),".")
  data$date = ymd(data$date)
  
  data$writer = gsub("'","",data$writer)
  data$writer = gsub("\\[","",data$writer)
  data$writer = gsub("\\]","",data$writer)
  
  # data$writer = gsub("<\\['\\]>","",data$writer)
  
  
  tid = data %>% group_by(writer,date) %>% summarise(n = n()) %>% 
    filter(date >= start_date) %>% as.data.frame()
  
  #tid = as.data.frame(tid)
  
  
  
  
  for(i in 1:length(writers)) {
    if(tid %>% filter(writer == writers[i], date == start_date) %>% nrow() != 1) {
      tid = rbind(tid, data.frame(writer = writers[i], 
                                  date = start_date,
                                  n = NA))
      
    }
    
    if(tid %>% filter(writer == writers[i], date == end_date) %>% nrow() != 1) {
      tid = rbind(tid, data.frame(writer = writers[i], 
                                  date = end_date,
                                  n = NA))
      
    }
    
    
  }
  tid = tid %>% arrange(writer, date)
  tid[is.na(tid)] = 0
  
  
  tid2 = tid %>%
    pad(group = 'writer', interval = 'day') %>%   # Explicitly fill by 1 min
    fill_by_value(n)
  
  
  tid3 = tid2 %>% transform(logical_write = ifelse(n > 0, 1, 0))
  colnames(tid3)[3] = "n_write"
  
  return(tid3)
  
}
cafe_viwer_func = function(data, start_date, end_date) {
  
  data$date[str_length(data$date) == 5] = paste0(gsub("-",".",end_date),".")
  data$date = ymd(data$date)
  
  data$writer = gsub("'","",data$writer)
  data$writer = gsub("\\[","",data$writer)
  data$writer = gsub("\\]","",data$writer)
  # data$writer = gsub("\\[.*?\\]","",data$writer)
  
  data$viewCount = gsub(",", "", data$viewCount)
  data$viewCount = as.integer(data$viewCount)
  
  tid = data %>% group_by(writer) %>% summarise(ViewCount_total = sum(viewCount)) %>%
    arrange(desc(ViewCount_total)) %>% as.data.frame()
  
  return(tid)
  
}
cafe_like_func = function(data, start_date, end_date) {
  
  data$date[str_length(data$date) == 5] = paste0(gsub("-",".",end_date),".")
  data$date = ymd(data$date)
  
  data$writer = gsub("'","",data$writer)
  data$writer = gsub("\\[","",data$writer)
  data$writer = gsub("\\]","",data$writer)
  # data$writer = gsub("\\[.*?\\]","",data$writer)
  
  data$like = gsub(",", "", data$like)
  data$like = as.integer(data$like)
  
  tid = data %>% group_by(writer) %>% summarise(like_total = sum(like)) %>%
    arrange(desc(like_total)) %>% as.data.frame()
  
  return(tid)
  
}
cafe_reply_func = function(data, start_date, end_date) { 
  
  # cafeRepl = readxl::read_excel("D:/workspace/python_workspace/01_cafeCrawler/naverCafeReply_A.xlsx")
  
  data$date[str_length(data$date) == 5] = paste0(gsub("-",".",end_date),".")
  data$date = ymd(data$date)
  
  
  data$writer = gsub("'","",data$writer)
  data$writer = gsub("\\[","",data$writer)
  data$writer = gsub("\\]","",data$writer)
  
  #data$writer = gsub("<\\['\\]>","",data$writer)
  
  
  tid_Repl = data %>% group_by(writer,date) %>% summarise(n = n()) %>% 
    filter(date >= start_date) %>% as.data.frame()
  
  
  
  
  
  for(i in 1:length(writers)) {
    if(tid_Repl %>% filter(writer == writers[i], date == start_date) %>% nrow() != 1) {
      tid_Repl = rbind(tid_Repl, data.frame(writer = writers[i], 
                                            date = start_date,
                                            n = NA))
      
    }
    
    if(tid_Repl %>% filter(writer == writers[i], date == end_date) %>% nrow() != 1) {
      tid_Repl = rbind(tid_Repl, data.frame(writer = writers[i], 
                                            date = end_date,
                                            n = NA))
      
    }
    
    
  }
  tid_Repl = tid_Repl %>% arrange(writer, date)
  tid_Repl[is.na(tid_Repl)] = 0
  
  
  
  tid_Repl2 = tid_Repl %>%
    pad(group = 'writer', interval = 'day') %>%   # Explicitly fill by 1 min
    fill_by_value(n)
  
  
  
  tid_Repl3 = tid_Repl2 %>% transform(logical_reply = ifelse(n >= 5, 1, 0))
  colnames(tid_Repl3)[3] = "n_reply"
  
  
  return(tid_Repl3)
}



### data load

start_d = "2021-02-01"
end_d = "2021-02-20"

writers_df = read.csv("./data/members.csv", encoding = "cp949")
#writers_df = read.csv("./data/members_mate.csv", encoding = "cp949")

writers = as.character(writers_df$habit_mate)

cafeWritten = readxl::read_excel("./data//naverCafeWrite_A.xlsx")
cafeRepl = readxl::read_excel("./data/naverCafeReply_A.xlsx")

flag_tid = cafe_write_func(cafeWritten, start_d, end_d)











