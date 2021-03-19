source("./src/02_dataload.R")


tid3 = cafe_write_func(cafeWritten, start_d, end_d)
tid_Repl3 = cafe_reply_func(cafeRepl, start_d, end_d)

total = merge(tid3, tid_Repl3)






total$n_write = NULL
total$n_reply = NULL

total_write = total[,-4]
total_reply = total[,-3]

total_write_t = spread(data = total_write, key = "date", value = "logical_write")
total_reply_t = spread(data = total_reply, key = "date", value = "logical_reply")


flag_df = data.frame(writer = writers)

total_write_t = left_join(flag_df, total_write_t)
total_reply_t = left_join(flag_df, total_reply_t)

colnames(total_write_t)[2:ncol(total_write_t)] = paste0(colnames(total_write_t)[2:ncol(total_write_t)],"_write")
colnames(total_reply_t)[2:ncol(total_reply_t)] = paste0(colnames(total_reply_t)[2:ncol(total_reply_t)],"_reply")


all_frame = left_join(total_write_t, total_reply_t)
all_frame %>% head


ord_a = seq(2,ncol(total_write_t),1)
ord_b = seq(ncol(all_frame) - ncol(total_reply_t) + 2, ncol(all_frame), 1)

ord = c()
for(i in 1:length(ord_a)) {
  ord = c(ord, ord_a[i])
  ord = c(ord, ord_b[i])
}


all_frame = all_frame[,c(1,ord)]
all_frame = left_join(flag_df, all_frame)




all_frame = left_join(all_frame,writers_df, by = c("writer" = "habit_mate"))

all_frame = all_frame[,c(1,ncol(all_frame),2:(ncol(all_frame) -1) )]

write.csv(all_frame, "./out/all_frame.csv", row.names = F)









