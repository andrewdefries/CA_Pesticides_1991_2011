#mkdir OutCaseFormat
#mv pdsd2005.txt pdsd2006.txt pdsd2007.txt pdsd2008.txt pdsd2010.txt OutCaseFormat/
###########
system("for i in *.txt 
do
##########
########################################clean out the crap
sed '/Page/d' $i | sed '/STATE/d' | sed '/SOLD/d' | sed '/Active/d' | sed '/Total/d' | sed '/Registrants/d' | sed '/Number/d' | sed '/Chemicals/d' | sed 's/^    *$//g' | sed 's/ - //g' | sed '/^ *$/d' | sed 's/^[ \t]*//;s/[ \t]*$//' | sed 's/ *$//' > $i.Cleaner 
########################################
#######################################get just the names
cut -c 1-74 $i.Cleaner > $i.NamesToClean 
sed 's/^/\"/' $i.NamesToClean | sed 's/[ \t]*$//' | sed 's/$/\"/' > Names
mv Names $i.NamesToClean
#######################################
cut -c 79-200 $i.Cleaner > $i.NumbersToClean
###For testing
#echo $i > index
#cat index > $i.Out
paste $i.NamesToClean $i.NumbersToClean > $i.Out
sed '$d' $i.Out | sed '$d' > $i.done
#sed -e '/./!d' $i.Out | sed '$d' | sed '$d' > $i.done
#######Fix output manually for line wrap problem
#pico $i.Out
#######
done")
###########

files<-list.files(pattern=".done", recursive=F)

Load<-function(a){
#################
graph<-read.table(files[a], fill=TRUE, header=F, dec=".", as.is=T)
colnames(graph)<-c("compound", "registrants", "pesticides_used")
pdf(gsub(".txt.done", ".pdf", files[a]))
plot(rownames(graph), graph$pesticides_used, type='h', main=paste("Pesticides used in CA", gsub(".txt.done", "", files[a]), ""), xlab="compound", ylab="pesticides applied (lb)")
dev.off()
#################
}
a<-1:length(files)
lapply(a, Load)
