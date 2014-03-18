library(ChemmineR)

files<-list.files(pattern=".sdf", recursive=F)

FixIDs<-function(z){
######
sdfset<-read.SDFset(files[z])
cid(sdfset)<-datablocktag(sdfset, tag="Click_ID")
#cid(sdfset)<-datablocktag(sdfset, tag="DRUGBANK_ID")
write.SDF(sdfset, file=files[z], sig=T, cid=T)
######
}
z<-1:length(files)
lapply(z, FixIDs)
