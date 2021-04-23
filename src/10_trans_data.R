
library(excel.link)

mem = xl.read.file("D:/workspace/010_crawler_naverCafe2/data/members_mate.xlsx")

write.csv(mem, "D:/workspace/010_crawler_naverCafe2/data/members_mate.csv", row.names = F)




## 1
total_deposit = 2599610.087073
total_loan = 117650
my_deposit = 2300.799074
my_loan = 0

my_deposit_profit = 8.603069
my_interest_profit = 0.045587

allocation_rate = 0.0883

total_set = total_deposit - total_loan
total_ratio = my_deposit / total_set


my_deposit_profit / total_ratio


#my_deposit_profit / (my_deposit / total_deposit)






## 2
total_deposit = 2622886.274422
total_loan = 117651
my_deposit = 2300.799074
my_loan = 1

my_deposit_profit = 8.544611
my_interest_profit = 0.04523

allocation_rate = 0.0877

total_set = total_deposit - total_loan
total_ratio = my_deposit / total_set

my_deposit_profit / total_ratio

#my_deposit_profit / (my_deposit / total_deposit)


(100 * my_deposit_profit) / allocation_rate



## 3
total_deposit = 2624584.395381
total_loan = 117651
my_deposit = 2300.799074
my_loan = 1

my_deposit_profit = 8.534868
my_interest_profit = 0.04521

allocation_rate = 0.0876

total_set = total_deposit - total_loan
total_ratio = my_deposit / total_set

my_deposit_profit / total_ratio


#my_deposit_profit / (my_deposit / total_deposit)



(100 * my_deposit_profit) / allocation_rate


((370000-9743) * (11000/93739525))




370000 * ( (11000+2300.799074) / (93739525+2633355.355904) )

42.2748 + 8.505639 + 0.047587



