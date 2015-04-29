CA_Pesticides_1991_2011
=======================


The California Department of Pesticide Regulation provides detailed reports of pesticides sold in California from 1991 to 2012:

http://www.cdpr.ca.gov/docs/mill/nopdsold.htm

Quoting the site

"FDA is making available a Glossary of alternative names for pesticides and related chemicals in Adobe Portable Document Format (PDF) format. The Glossary contains entries for 1045 chemicals. Most of the chemicals included in this glossary are pesticides used during the production of foods or animal feeds. The main part of the Glossary contains additional information about each chemical, including molecular formula and references to sections of Code of Federal Regulations Title 40 that list tolerances on foods and feeds. The Glossary also includes an index which directs the user to the main entry name for each alternative name."

The data was provided in PDF format, and required manipulation to import into R for further analysis. Plain text was extracted from PDF files by 

```
pdftotext pdsd*.pdf -layout

```

The plain text was cleaned interactively using sed on the unix command line. These commands were included in the R script inside a system("") call. See CleanViaSed.R

```
# Delete unwanted characters  
sed 's/ - //g'

# remove lines with n numeric or chemical data for example:
sed '/SOLD|Active/d' 

# Remove tabs
sed 's/^[ \t]*//;s/[ \t]*$//'

# Remove unwanted decimal place
sed s/\\.[^\\.]*$/0/

```

The cleaned text was then loaded into R using standard methods 

```
data<-read.table(file="cleaneddata.txt", fill=T, header=F)

```

This data was used to create a dataframe to graph pesticide sold per year in value of tons from 1991-2011. 

```
plot(rownames(graph), graph$pesticides_used, type='h', main=paste("Pesticides used in CA", gsub(".txt.done", "", files[a]), ""), xlab="compound", ylab="pesticides applied (lb)")
```

Chemical Space Analysis
=======================

Chemical names were used to lookup corresponding molecular chemical structures. These chemical structures were then used to perform a chemical space analysis of compounds sold per year. 

Chemical similarity calculations were conducted using an atom-pair method where each connected atom-pair in a molecule is compared to the data set. The comparisons were accomplished using functions provided by the R library ChemmineR (http://www.bioconductor.org/packages/release/bioc/html/ChemmineR.html) and resulted in a Tanimoto similarity score used to group the dataset.

The chemical names were uploaded as a plain text list to the following free service http://www.chemicalize.org
to derive the standard input format for molecular calculations. The structure data files (SDF) (https://en.wikipedia.org/wiki/Chemical_table_file#SDF) were used as input into ChemmineR. The files were pre-processed to remove atom-pair matrices with improper connection matrices, and the following was performed:

```
library(ChemmineR)
sdfset<-read.SDFset(file[a])
apsset<-sdf2ap(sdfset)
naebors<-10
nnm <- nearestNeighbors(fpset,numNbrs=naebors)
```

The nearest neighbor matrix (nnm) was used to create adjacency tables based on Tanimoto score. The nearest neighbor tables as html may viewed here: http://andrewdefries.github.io/

The similarity relationships were further examined using cluster analysis provided in ChemmineR and atom-pair fingerprinting using fmcsR (http://www.bioconductor.org/packages/release/bioc/html/fmcsR.html).


![Chemical cluster summary] (https://github.com/andrewdefries/CA_Pesticides_1991_2011/blob/master/ChemSpaceThat/MergeSDF/ClidNeighbors.png "Chemical cluster summary")

The image above is a quick way to look summerize cluster groups (here called CLIDs on the y-axis) at multiple Tanimoto similarity coefficients cutoffs from 50-80% atom-pair similarity. Similar compounds can be found on in a line parallel to the x-axis. The x-axis represents the original unsorted compound index number. Note as the Tanimoto coefficient increases to 0.8 or 80% similarity cuffoff the CLID members decrease. Since the 80% similarity CLID contains so few compounds we can easily visualize a cladogram showing relative distances on a phylogenetic tree and also print the compounds to a small table for visual inspection.


fmcsR_CA_PesticidesMerge_Unique.R
```
library(ChemmineR)

sdfset<-read.SDFset("CA_PesticidesMerge_Unique.sdf")

apset<-sdf2ap(sdfset)

cid(sdfset)<-sdfid(sdfset)

# cluster with multiple cutoffs
cluster<-cmp.cluster(apset, cutoff=c(0.5,0.6,0.7,0.8))

png(file="ClidNeighbors.png")

# setup 2x2 plot
par(mfrow = c(2,2))

# use compound index to reverse lookup compounds from graph
plot.default(x=rownames(cluster), y=cluster$CLID_0.5, ylim=c(0,160))
plot.default(x=rownames(cluster), y=cluster$CLID_0.6, ylim=c(0,160))
plot.default(x=rownames(cluster), y=cluster$CLID_0.7, ylim=c(0,160))
plot.default(x=rownames(cluster), y=cluster$CLID_0.8, ylim=c(0,160))
dev.off()
```



