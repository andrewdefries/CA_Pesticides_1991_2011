###########
library(tm)
###########


###########
system("for i in *.pdf 
do
pdftotext $i -layout
done")
###########
