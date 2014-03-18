rm -r *.temp

for i in *.sdf

do
#######################
mkdir $i.temp
cp hide/CA_PestMergeUnique.sdf .
babel $i CA_PestMergeUnique.sdf -O $i.merge.sdf

rm CA_PestMergeUnique.sdf

mv $i.merge.sdf $i.temp/


cp *.R $i.temp/

#cp $i $i.temp/
#merge here

cd $i.temp

#R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R

cd ..
#######################
done

