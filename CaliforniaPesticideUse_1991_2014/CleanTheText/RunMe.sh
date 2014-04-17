
R CMD BATCH CleanViaSed.R  

R CMD BATCH PesticideDataFrame.R

pico Ready
sed 's/\""/\"0"/g' Ready > LoadMe


#R CMD BATCH GroupedBarPlot.R
