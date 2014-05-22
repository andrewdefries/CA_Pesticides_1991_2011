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
Piece<-subset(graph, graph$compound%in%IndexList[d])

colnames(Piece)<-c("compound", "lbs", "year")

timeline<-as.vector(Piece$year)
#true value 
#dumping<-as.numeric(Piece$lbs)*1000

dumping<-as.numeric(Piece$lbs)

#Do something to get rid of named entries by date and the entry "0"


##
#plot(as.numeric(Piece$year), as.numeric(Piece$lbs), type="s", main=IndexList[d], xlim=c(0,length(Piece$year)))
#plot(timeline, dumping, type="l", main=IndexList[d], xlim=c(1991,2011))

plot(timeline, dumping, type="h", main=paste(IndexList[d], "Timeline", sep=" "), xlim=c(1991,2011), xlab="year", ylab="1000 lbs")

#plot(as.vector(Piece$year), as.numeric(Piece$lbs), type="l", main=IndexList[d], xlim=c(0,length(Piece$year)))
#plot(as.numeric(Piece$year), as.numeric(Piece$lbs), type="h", main=IndexList[d], xlim=c(0,length(Piece$year)))
##hist(as.numeric(Piece$year), freq=T, probability=Piece$lbs, xlab="year", ylab="lbs", xlim=c(0,ceiling(year)), main=IndexList[d])
##
}
##########
d<-1:length(IndexList)
lapply(d, GetThoHistogram)

dev.off()
