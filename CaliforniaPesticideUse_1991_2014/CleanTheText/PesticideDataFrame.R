system("rm *.done.Year")
##
system("./PasteYear.sh")
#system("for i in *.done 
#do
####
#echo $i | sed 's/pdsd//g' | sed 's/.txt.done//g' > Year
#
#TheYear=`cat Year`
#
#sed "s|$| ${TheYear}|" $i > $i.Year
####
#done")
###########
system("cat *.done.Year > MergePesticides")
##########
#replace above with gsub to get year from file name and use s.t. rep(name, n-times) and then 
##########
###########
files<-list.files(pattern="MergePesticides", recursive=F)
#################
graph<-read.table(files[1], fill=TRUE, header=F)
##########
#rownames(graph)<-graph[,1]
colnames(graph)<-c("compound", "registrants", "pesticides_used", "year")
########
#graphdf<-data.frame(graph, factor=graph$compound) ##[1,])
#write.table(graphdf, file="OutNSorted.table")
#graphdf<-data.frame(graph)
######
almost<-data.frame(graph$compound[sort.list(graph$compound)],graph$pesticides_used[sort.list(graph$compound)], graph$year[sort.list(graph$compound)])
write.table(almost, file="OutNSorted.table")
######
#pdf(gsub(".txt.done", ".pdf", files[a]))
######
system("sed '2d' OutNSorted.table > Ready")

graph<-read.table("Ready")
colnames(graph)<-c("compound", "registrants", "pesticides_used", "year")



