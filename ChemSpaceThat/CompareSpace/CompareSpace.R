##################
library(ChemmineR)
library(rgl)
##################
files<-list.files(pattern=".sdf", recursive=F)
##################
sdfset<-read.SDFset(files[1])
cid(sdfset)<-substring(sdfid(sdfset), 1,24)
##################
apset<-sdf2ap(sdfset)
##################
clusters<-cmp.cluster(apset,cutoff=c(0.7))
##################
coord<-cluster.visualize(apset,clusters, size.cutoff=1, dimensions=3, quiet=T)
##################
save(coord, file="CA_Pesticide_coord.rda", compress=T)
#colorz<-rainbow(length(files)-1)
colorz<-c("red", "black", "green", "yellow", "blue", "orange", "pink", "purple", "brown", "grey", "cyan", "magenta", "black", "brown", "red", "yellow", "blue", "green", "orange", "pink")
##################
ShowMeTheSpace<-function(a){
########################################
load("CA_Pesticide_coord.rda")
##################
pngname<-paste(files[a],".png",sep="")
##################
sdfset<-read.SDFset(files[a])
coord<-coord[rownames(coord)%in%sdfid(sdfset),]
##################
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color=colorz[a], alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(pngname)
rgl.close()
########################################
}
#################
a<-2:length(files)
lapply(a, ShowMeTheSpace)
