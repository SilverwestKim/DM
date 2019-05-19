rm(list=ls())
if(!require(readxl)) install.packages("readxl"); library(readxl)
getwd()
setwd("C:/Users/eunse/Desktop/DM/year")
y = read_excel("y.xlsx"); sil = read_excel("silup.xlsx")
year = as.factor(y[[1]])
num = y[[2]]
Y = data.frame(year,num)
View(Y)

View(sil); dim(sil)
Year_pre = cbind(Y,sil[,2:5])
Year_pre[,7] = Year_pre[,3]; Year_pre = Year_pre[,-3]
colnames(Year_pre)[3:6] = c('15-29silup','30-59silup','60_silup','avg_sil')
str(Year_pre)

write.csv(Year_pre,'연도별실업율전처리.csv',row.names=FALSE)