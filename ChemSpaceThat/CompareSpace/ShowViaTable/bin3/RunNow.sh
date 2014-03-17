for i in *.sdf

do

mkdir $i.runtime
cp *.R $i.runtime/
cp $i $i.runtime/
cd $i.runtime

R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R

cd .. 

done
