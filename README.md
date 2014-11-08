CA_Pesticides_1991_2011
=======================


The California Department of Pesticide Regulation provides detailed reports of pesticides sold in California from 1991 to 2012:

http://www.cdpr.ca.gov/docs/mill/nopdsold.htm

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
