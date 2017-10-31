#MIT License, Copyright (c) 2017 Ge (Jeff) Pu

climate <- read.csv("project1_climate.csv")
genesseallm <- read.csv("project1_genesseall.csv")

genesseall<-genesseallm[1:24,]


tf<-function(nn){
movsum<-function(x){
  filter(x,rep(1,nn),sides=1)
}

test<-data.frame(climate[,1],
            as.numeric(movsum(climate[,2])))


test2<-data.frame(genesseall,
                  test[match(genesseall[,1],climate[,1]),2])

test2[is.na(test2)]<-0

test3<-cor(test2,method="spearman")
#test3<-rcorr(as.matrix(test2), type="spearman")$P[2,3]

#print(test2)
print(test3[2,3])
}

tf2<-function(nn){
  movsum<-function(x){
    filter(x,rep(1,nn),sides=1)
  }
  
  test<-data.frame(climate[,1],
                   as.numeric(movsum(climate[,2])))
  
  
  test2<-data.frame(genesseall,
                    test[match(genesseall[,1],climate[,1]),2])
  
  test2[is.na(test2)]<-0
  
  #test3<-cor(test2,method="spearman")
  test3<-rcorr(as.matrix(test2), type="spearman")$P[2,3]
  
  #print(test2)
  print(test3)
}

###############

par(mfrow=c(2,1))

genesseall<-genesseallm[1:24,]

plot(mapply(tf,2:365),main='Precipitation Cumulation Period vs. Correlation Result with Peak Flow',
     ylab='Corellation Result',
     xlab='Precipitation Cumulation Period (days)')

genesseall<-genesseallm[28:90,]

points(mapply(tf,2:365),col='red')
legend('topright',c('before_dam','after_dam'),
       pch=1,
       col=c('black','red'))
#################
genesseall<-genesseallm[1:24,]
plot(mapply(tf2,2:365),main='P values',
     ylab='P values',
     xlab='Precipitation Cumulation Period (days)',
     ylim=c(0,0.1))

genesseall<-genesseallm[28:90,]

points(mapply(tf2,2:365),col='red')
#abline(h=0.1)
legend('topright',c('before_dam','after_dam'),
       pch=1,
       col=c('black','red'))
polygon(c(-100,400,400,-100),c(0.05,0.05,0,0), col=rgb(0.22, 0.22, 0.22,0.5))


###################
#Flow Changes in boxplot
before<-genesseallm[1:24,][,2]
after<-genesseallm[28:90,][,2]
boxplot(before,after,xaxt = "n",ylab="peakflow (cfs)")
axis(1,at=1:2,labels=c('before dam construction','after dam construction'))

#Flow Changes in annova
Data <- data.frame(
  Y=c(before,after),
  Site =factor(rep(c("before", "after"), times=c(length(before), length(after))))
)

fit<-aov(Y~Site,data=Data)
summary(fit)
TukeyHSD(fit)
