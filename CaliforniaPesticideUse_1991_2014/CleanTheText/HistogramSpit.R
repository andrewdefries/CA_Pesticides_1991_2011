graph<-read.table("Ready")
colnames(graph)<-c("compound", "lbs", "year")
Index<-unique(graph[1])
#Year<-unique(graph[3])

#run on CMD line ls *[0-9].txt | sed 's/pdsd//g' | sed 's/.txt//g' > YearIndex
Year<-read.table("YearIndex")
year<-seq_along(Year)

write.table(Index, file="IndexList.txt", quote=T)
################

#######
pdf(file="Test2.pdf")
IndexList<-read.table("IndexList.txt")
IndexList<-do.call(paste, as.list(IndexList))
##########
GetThoHistogram<-function(d){
##
Piece<-subset(graph, unique(graph$compound)==IndexList[d])   # unique(graph[1])==IndexList[d])
#Piece<-graph[unique(graph$compound)==IndexList[d], ]
colnames(Piece)<-c("compound", "lbs", "year")
##
plot(as.numeric(Piece$year), as.numeric(Piece$lbs), type="p", main=IndexList[d])
plot(as.numeric(Piece$year), as.numeric(Piece$lbs), type="h", main=IndexList[d])
hist(as.numeric(Piece$year), freq=T, probability=Piece$lbs, xlab="year", ylab="lbs", xlim=c(0,ceiling(year)), main=IndexList[d])
##
}
##########
d<-1:length(IndexList)
lapply(d, GetThoHistogram)

dev.off()
