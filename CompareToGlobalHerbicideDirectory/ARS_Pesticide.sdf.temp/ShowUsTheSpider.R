library(ChemmineR)

sdfset<-read.SDFset("all.sdf")
cid(sdfset)<-datablocktag(sdfset,tag="DRUGBANK_ID")

sdfset_approved<-read.SDFset("approved.sdf")
cid(sdfset_approved)<-datablocktag(sdfset_approved,tag="DRUGBANK_ID")

sdfset_small_molecule<-read.SDFset("small_molecule.sdf")
cid(sdfset_small_molecule)<-datablocktag(sdfset_small_molecule,tag="DRUGBANK_ID")

sdfset_experimental<-read.SDFset("experimental.sdf")
cid(sdfset_experimental)<-datablocktag(sdfset_experimental,tag="DRUGBANK_ID")

sdfset_nutraceutical<-read.SDFset("nutraceutical.sdf")
cid(sdfset_nutraceutical)<-datablocktag(sdfset_nutraceutical,tag="DRUGBANK_ID")

sdfset_illicit<-read.SDFset("illicit.sdf")
cid(sdfset_illicit)<-datablocktag(sdfset_illicit,tag="DRUGBANK_ID")

sdfset_withdrawn<-read.SDFset("withdrawn.sdf")
cid(sdfset_withdrawn)<-datablocktag(sdfset_withdrawn,tag="DRUGBANK_ID")


####

cid(sdfset)<-datablocktag(sdfset,tag="DRUGBANK_ID")

valid <- validSDF(sdfset)

sdfset <- sdfset[valid]

apset<-sdf2ap(sdfset)

sdfset<-sdfset[!sapply(as(apset, "list"), length)==1]

#apset<-sdf2ap(sdfset)
####
load("DrugBank_Vs_Clickable_coord.rda")
#cluster apset
###clusters <- cmp.cluster(apset, cutoff = c(0.7))
#embed clusters in a 3-dimensional space based on apset

###coord <- cluster.visualize(apset, clusters, size.cutoff=1, dimensions=3,
###quiet=TRUE)
###


##################################################################################################################
library(rgl)
##################################################################################################################



#########
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_vs_Clickable_all.png")
rgl.close()
#
load("DrugBank_Vs_Clickable_coord.rda")
###
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
coord<-coord[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_approved, tag="DRUGBANK_ID"),1:3]
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="blue", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_Vs_Clickable_approved.png")
rgl.close()
#
load("DrugBank_Vs_Clickable_coord.rda")
###
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
coord<-coord[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_small_molecule, tag="DRUGBANK_ID"),1:3]
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="orange", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_vs_Clickable_small_molecule.png")
rgl.close()
#
load("DrugBank_Vs_Clickable_coord.rda")
##
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
coord<-coord[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_illicit, tag="DRUGBANK_ID"),1:3]
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_vs_Clickable_illicit.png")
rgl.close()
#
load("DrugBank_Vs_Clickable_coord.rda")
##
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
coord<-coord[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_withdrawn, tag="DRUGBANK_ID"),1:3]
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="brown", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_Vs_Clickable_withdrawn.png")
rgl.close()
##
load("DrugBank_Vs_Clickable_coord.rda")
#
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
coord<-coord[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_nutraceutical, tag="DRUGBANK_ID"),1:3]
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="green", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_Vs_Clickable_nutraceutical.png")
rgl.close()
#
load("DrugBank_Vs_Clickable_coord.rda")
##
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
coord<-coord[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_experimental, tag="DRUGBANK_ID"),1:3]
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="purple", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_Vs_Clickable_experimental.png")
rgl.close()
############
############
load("DrugBank_Vs_Clickable_coord.rda")
##
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
#

sdfset_super_latca<-read.SDFset("SuperLATCA.sdf")
sdfset_super_latca<-sdfset_super_latca[3637:6399]
#
Actives<-read.table("Actives")
#
coord_alpha<-coord[gsub("_", "", rownames(coord))%in%Actives[,1],1:3]
spheres3d(coord_alpha[,1], coord_alpha[,2], coord_alpha[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
#
coord_beta<-coord[rownames(coord)%in%datablocktag(sdfset_super_latca, tag="LATID"),1:3]
spheres3d(coord_beta[,1], coord_beta[,2], coord_beta[,3], radius=0.005, color="cyan", alpha=1, shininess=20); aspect3d(1, 1, 1)


axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot("Drugbank_vs_Clickable_Clickable_alone.png")
rgl.close()

