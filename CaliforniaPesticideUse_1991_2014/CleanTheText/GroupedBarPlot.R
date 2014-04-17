# Grouped Bar Plot

graph<-read.table("LoadMe", fill=T, rownames=NULL, colnames=c())

PlotVector<-graph[unique(graph[,2])]
##############################
GroupBarPlot<-function(t){
#
png_name<-paste(PlotVector[t], ".png", sep="")
png(png_name)
#
#counts<-table(graph$compound==PlotVector[t], graph$year)
barplot(PlotVector[t], graph$year, graph$lbs
#
barplot(counts, main=PlotVector[t], xlab="year", ylab="x1000 lb")
##############################
}
t<-1:length(PlotVector)
lapply(t, GroupBarPlot)


counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
  xlab="Number of Gears", col=c("darkblue","red"),
 	 legend = rownames(counts), beside=TRUE)
