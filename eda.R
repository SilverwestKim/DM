rm(list=ls())
getwd()
library(readxl)
setwd('C:/Users/eunse/Desktop/DM/month')
dir()

chiup= read.csv("월전처리_취업율.csv")
gingu = read.csv("월전처리_취업율_경제활동인구.csv")
colnames(gingu)[1]="월별"

View(chiup)
                  
str(chiup)
str(gingu)

par(mfrow=c(1,1))
plot(chul~월별,data=gingu,ylab = "월별 출산율")
par(mfrow=c(2,2))
plot(M15_Up_Ingu~월별,data=gingu,ylab="15세이상인구(남)")
plot(F15_Up_Ingu~월별,data=gingu,ylab="15세이상인구(여)")
plot(Mgj_Ingu~월별,data=gingu,ylab="경제활동인구(남)")
plot(Fgj_Ingu~월별,data=gingu,ylab="경제활동인구(여)")

plot(M_non_gj_Ingu~월별,data=gingu,ylab="비경제활동인구(남)")
plot(F_non_gj_Ingu~월별,data=gingu,ylab="비경제활동인구(여)")
plot(M_gj_chamga~월별,data=gingu,ylab="경제활동참가율(남)")
plot(F_gj_chamga~월별,data=gingu,ylab="경제활동참가율(여)")

plot(M_silup_rate~월별,data=gingu,ylab="실업율(남)")
plot(F_silup_rate~월별,data=gingu,ylab="실업율(여)")
plot(M_goyong_rate~월별,data=gingu,ylab="고용율(남)")
plot(F_goyong_rate~월별,data=gingu,ylab="고용율(여)")

plot(chul~M_silup_rate,data=gingu,xlab = '여성실업율',ylab='출산율')
plot(chul~F_silup_rate,data=gingu,xlab = '남성실업율',ylab='출산율')
plot(chul~M_goyong_rate,data=gingu,xlab = '여성고용율',ylab='출산율')
plot(chul~F_goyong_rate,data=gingu,xlab = '남성고용율',ylab='출산율')

plot(chul~M_non_gj_Ingu,data=gingu,xlab="비경제활동인구(남)",ylab='출산율')
plot(chul~F_non_gj_Ingu,data=gingu,xlab="비경제활동인구(여)",ylab='출산율')
plot(chul~M_gj_chamga,data=gingu,xlab="경제활동참가율(남)",ylab='출산율')
plot(chul~F_gj_chamga,data=gingu,xlab="경제활동참가율(여)",ylab='출산율')
