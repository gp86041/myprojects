
climate <- read.csv("C:/Users/jeff2/Downloads/climate.csv")
genesseall <- read.csv("C:/Users/jeff2/Downloads/genesseall.csv")

#genesseall<-genesseall[1:24,]
genesseall<-genesseall[28:90,]

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

plot(mapply(tf,2:365))
