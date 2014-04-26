graph<-read.table("Ready")
Index<-unique(graph[1])
write.table(Index, file="IndexList.txt", quote=T)


pdf(file="Test.pdf")
IndexList<-read.table("IndexList.txt")
IndexList<-c(IndexList[1])
##########
GetThoHistogram<-function(d){
##
Piece<-subset(graph, unique(graph[1])==IndexList[d])
colnames(Piece)<-c("compound", "lbs", "year")
##
#plot(as.numeric(Piece$year), as.numeric(Piece$lbs), type="h")
hist(as.numeric(Piece$year), freq=T, probability=Piece$lbs, xlab="year", ylab="lbs", xlim=c(0,30), main="Test")
##
}
##########
d<-1:length(IndexList)
lapply(d, GetThoHistogram)

dev.off()
