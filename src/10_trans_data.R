
library(excel.link)

mem = xl.read.file("D:/workspace/010_crawler_naverCafe2/data/members_mate.xlsx")

write.csv(mem, "D:/workspace/010_crawler_naverCafe2/data/members_mate.csv", row.names = F)
