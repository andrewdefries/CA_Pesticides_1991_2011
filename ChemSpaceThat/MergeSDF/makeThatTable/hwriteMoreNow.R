##################
system("rm *.sdf")
system("rm *.smi")
system("rm *.png")
#system("unzip YAWYE_clean.sdf.gz")
system("cp /home/andrewdefries/Desktop/ForTyroneHayes/CaliforniaPesticideUse_1991_2014/ChemSpaceThat/MergeSDF/CA_PesticidesMerge_Unique.sdf .")
#################
library(ChemmineR)
#################
##data(sdfsample)
##cid(sdfsample)<-sdfid(sdfsample)
##sdfset<-sdfsample
files<-list.files(pattern=".sdf", recursive=F)
t<-1
sdfset<-read.SDFset(files[t])
###############
#cid(sdfset)<-sdfid(sdfset)
#write.SDF(sdfset,file="load_me.sdf", sig=T)
###############
################
smiset<-sdf2smiles(sdfset) #(sdfset[1:2])
################
WriteSdfOut<-function(a){
write.SDF(sdfset[[a]], file=paste(cid(sdfset[a]), ".sdf", sep=""), sig=T, cid=T)
}
a<-1:length(smiset) #change to 2 for testing
lapply(a,WriteSdfOut)
################
WriteSmiOut<-function(a){
cid(smiset)<-cid(sdfset[a])
write.SMI(smi=smiset[[a]], file=paste(cid(sdfset[a]), ".smi", sep=""), cid=T)
}
a<-1:length(smiset) #change to 2 for testing
lapply(a,WriteSmiOut)
###############
system("for i in *.smi
do babel $i -O $i.png 
done")
###############
#source("hwriteMoreTable.R") #works
source("hwriteMore.R") #fixed
###############
#system("firefox test.html")
###############
#to do
#add smiles field
#add links to wikipedia page from chembrain repo
#fix ChemmineR problem to export cid of smiset
#use trimNeihbors of nnm to print each clid with min members in rgl space
#highlight compounds in cluster and print cid in webGL out
