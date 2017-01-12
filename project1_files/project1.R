
climate <- read.csv("project1_climate.csv")
genesseallm <- read.csv("project1_genesseall.csv")

genesseall<-genesseallm[1:24,]


tf<-function(nn){
movsum<-function(x){
  filter(x,rep(1,nn),sides=1)
}

test<-data.frame(climate[,1],
            as.numeric(movsum(climate[,2])),
            climate[,3],
            as.numeric(movsum(climate[,4])),
            climate[,5:6])

colnames(test)<-colnames(climate)


test2<-data.frame(genesseall,
                  test[match(genesseall[,1],climate[,1]),2:6])
test2[is.na(test2)]<-0

test3<-cor(test2,method="spearman")

print(test3[2,3])
}


plot(mapply(tf,2:365),main='Precipitation Cumulation Period vs. Correlation Result with Peak Flow',
     ylab='Corellation Result Between Cumulative Precipitation and Peak Flow',
     xlab='Precipitation Cumulation Period (days)')

genesseall<-genesseallm[28:90,]

points(mapply(tf,2:365),col='red')
legend('topright',c('before_dam','after_dam'),
       pch=1,
       col=c('black','red'))
