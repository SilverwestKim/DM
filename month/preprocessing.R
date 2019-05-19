rm(list=ls())
if(!require(readxl)) install.packages("readxl"); library(readxl)
if(!require(xlsx)) install.packages("xlsx"); library(xlsx)
getwd()
setwd("C:/Users/eunse/Desktop/DM/month"); dir()
chul = read_excel('chul.xlsx'); View(chul); chul = chul[,-2]
colnames(chul) = c('month','chul_num')
chul$month = as.factor(chul$month)
str(chul); 
dim(chul) # 456 x 2

chiup = read_excel('chiup.xlsx'); View(chiup)

#merge
chiup[1,] #1998.01
i = which(chul$month == '1998. 01')
i #205
chul.2 = chul[205:dim(chul)[1],]
View(chul.2)
chul = chul.2 
dim(chul); dim(chiup) #252 x 2 ; # 254 x 11 ; chiup 2019 .01, 2019 .02 제거

chiup = chiup[-c(253,254),]
dim(chul); dim(chiup) #252 row ( 1998. 01 ~ 2018. 12)

chiup$chul = chul$chul_num
write.csv(chiup,'월전처리_취업율.csv')
################경제활동인구 추가하면 14col(7종류 * 남여) 더 늘고 row는 1999. 06부터 있으므로 남녀 합해도 괜찮ㄱ
################17 col 줄어서 235 row ?? 어떻게 할지 얘기 해보기;

##1999.06부터 잘라보기
which(chiup$연령계층별=='1999. 06') #18
chiup2 = chiup[18:252,]
dim(chiup2) # 235 x 12

gj = read_excel('gj_ingu.xlsx'); View(gj)
dim(gj)[1]/7; #1999. 06 - 2019. 02; 19년 1월2월제거
gj = gj[1:1645,] # 235 mon
idx = seq(1,1645,7)
chiup2$M15_Up_Ingu = gj[idx,1]
chiup2$F15_Up_Ingu = gj[idx,2]
chiup2$Mgj_Ingu = gj[idx+1,1]
chiup2$Fgj_Ingu = gj[idx+1,2]
chiup2$M_non_gj_Ingu = gj[idx+2,1]
chiup2$F_non_gj_Ingu = gj[idx+2,2]
chiup2$M_gj_chamga = gj[idx+3,1]
chiup2$F_gj_chamga = gj[idx+3,2]
chiup2$M_silup_rate = gj[idx+4,1]
chiup2$F_silup_rate = gj[idx+4,2]
chiup2$M_goyong_rate = gj[idx+5,1]
chiup2$F_goyong_rate = gj[idx+5,2]
chiup2$M_goyong_rate_15_64 = gj[idx+6,1]
chiup2$F_goyong_rate_15_64 = gj[idx+6,2]

str(chiup2); dim(chiup2) # 235 x 26
View(chiup2)

for (i in 14:dim(chiup2)[2]){
  chiup2[,i]=unlist(chiup2[,i])
}
str(chiup2)

write.csv(chiup2, '월전처리_취업율_경제활동인구.csv',row.names=FALSE)