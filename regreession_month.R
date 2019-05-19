rm(list=ls())
getwd()
setwd("C:/Users/eunse/Desktop/DM/month")
dir()

data = read.csv("newdata.csv")
str(data)
dim(data) # 230 x 39
View(data)

#기타 물가지수는 알아보기 힘드므로 제거
data = data[,-8]
data$대학교납입금 =data$전문대학납입금 + data$국공립대학교납입금 + data$사립대학교납입금

data$청소년학원비 = data$초등학생학원비 + data$고등학생학원비

data$예체능학원비 = data$음악학원비 +data$미술학원비 +data$운동학원비 + data$전산학원비

data$대학원납입금 = data$국공립대학원납입금 + data$사립대학원납입금

data = data[,-c(11,12,13,14,15,18,19,20,21,22,23)]
write.csv(data,"jake.csv",row.names=FALSE)

dim(data)
str(data)
#install.packages("corrplot")
library(corrplot)

corr = cor(data[,-1])
par(mfrow=c(1,1))
corrplot(corr,method = "circle",tl.pos = "n")
corrplot.mixed(corr,"square",tl.pos = "n")
sum(is.na(data))


##분석의 시작은 그림!!!
par(mfrow=c(2,2))

for (i in 2:5){
  plot(data[,i],ylab = colnames(data)[i])

}

for (i in 6:9){
  plot(data[,i],ylab = colnames(data)[i])
  
}

for (i in 10:13){
  plot(data[,i],ylab = colnames(data)[i])
  
}

for (i in 14:17){
  plot(data[,i],ylab = colnames(data)[i])
  
}

for (i in 18:21){
  plot(data[,i],ylab = colnames(data)[i])
  
}

for (i in 22:25){
  plot(data[,i],ylab = colnames(data)[i])
  
}

for (i in 26:29){
  plot(data[,i],ylab = colnames(data)[i])
  
}

for (i in 30:33){
  plot(data[,i],ylab = colnames(data)[i])
  
}
#종속변수(chul : 출산율)와 독립변수 간의 상관관계 알아보기

par(mfrow=c(2,3))
plot(data$농축수산물,data$chul)
plot(data$공업제품,data$chul)
plot(data$섬유제품,data$chul)
plot(data$내구재,data$chul)
plot(data$출판물,data$chul)
plot(data$석유류,data$chul)

plot(data$집세,data$chul)
plot(data$유치원납입금,data$chul)
plot(data$고등학교납입금,data$chul)
plot(data$보육시설이용료,data$chul)
plot(data$독서실비,data$chul)
plot(data$가정학습지,data$chul)

plot(data$외국어학원비,data$chul)
plot(data$운동강습료,data$chul)
plot(data$혼인율,data$chul)
plot(data$X20대취업율,data$chul)
plot(data$X30대취업율,data$chul)
plot(data$X40대취업율,data$chul)

plot(data$대학교납입금,data$chul)
plot(data$예체능학원비,data$chul)
plot(data$대학원납입금,data$chul)

plot(data$M15_Up_Ingu,data$chul,xlab = "남성15세이상인구")
plot(data$F15_Up_Ingu,data$chul,xlab = "여성15세이상인구")
plot(data$Mgj_Ingu,data$chul,xlab = "남성경제인구")
plot(data$Fgj_Ingu,data$chul, xlab = "여성경제인구")
plot(data$M_silup_rate,data$chul, xlab="남성실업율")
plot(data$F_silup_rate,data$chul, xlab = "여성실업율")


model.full = lm(chul~ . , data= data[,-1])
summary(model.full)
par(mfrow=c(2,2))
plot(model.full)

model.con <- lm(chul ~ 1, data[,-1])
model.both <- step(model.full, 
                   list(lower=model.con, upper=model.full),
                   direction = "both")
summary(model.both)
plot(model.both)

library(car)
vif(model.both)

#15세이상인구에서 다중공선성이 크게 나타나므로 변수를 제거하고
#모델 적합을 해 본다

nd = data[,-c(22,23)]

#변수 제거한 데이터 다시 모델 적ㅎ
n.model.full = lm(chul~ . , data= nd[,-1])
par(mfrow=c(2,2))
plot(n.model.full)

n.model.con <- lm(chul ~ 1, nd[,-1])
n.model.both <- step(n.model.full, 
                   list(lower=n.model.con, upper=n.model.full),
                   direction = "both")
summary(n.model.both)
plot(n.model.both)
vif(n.model.both)

#새로운 모델에서 p-value가 가장 큰 독서실비를 제거하고 모델 적합하기
nnd = nd[,-12]

n2.model.full = lm(chul~ . , data= nnd[,-1])
par(mfrow=c(2,2))
plot(n2.model.full)


n2.model.con <- lm(chul ~ 1, nnd[,-1])
n2.model.both <- step(n2.model.full, 
                     list(lower=n2.model.con, upper=n2.model.full),
                     direction = "both")

summary(n2.model.both)
vif(n2.model.both)

outlierTest(model.both)
