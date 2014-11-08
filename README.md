CA_Pesticides_1991_2011
=======================


The California Department of Pesticide Regulation provides detailed reports of pesticides sold in California from 1991 to 2012:

http://www.cdpr.ca.gov/docs/mill/nopdsold.htm

The data was provided in PDF format, and required manipulation to import into R for further analysis. Plain text was extracted from PDF files by 

```
pdftotext pdsd*.pdf -layout

```

The plain text was cleaned using sed the unix command line tool in several ways

```
# Delete unwanted characters and lines 
sed 's/foo/bar/g'
sed 's/foo/bar/d'

# Remove unwanted decimal place
#

```

The cleaned text was then loaded into R using standard methods 

```

data<-read.table(file="cleaneddata.txt", fill=T)


```

This data was used to create a dataframe to graph pesticide sold per year in value of tons from 1991-2011. 

Chemical Space Analysis
=======================

Chemical names were used to lookup corresponding molecular chemical structures. These chemical structures were then used to perform a chemical space analysis of compounds sold per year. 

Chemical similarity calculations were conducted using an atom-pair method where each connected atom-pair in a molecule is compared to the data set. The comparisons were accomplished using functions provided by the R library ChemmineR (http://www.bioconductor.org/packages/release/bioc/html/ChemmineR.html) and resulted in a Tanimoto similarity score used to group the dataset.



The nearest neighbor tables may be viewed here: http://andrewdefries.github.io/
