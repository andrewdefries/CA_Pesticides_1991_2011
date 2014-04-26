
R CMD BATCH CleanViaSed.R  

R CMD BATCH PesticideDataFrame.R

pico Ready
sed 's/\""/\"0"/g' Ready > LoadMe

mv LoadMe Ready

R CMD BATCH HistogramSpit.R

#R CMD BATCH GroupedBarPlot.R
