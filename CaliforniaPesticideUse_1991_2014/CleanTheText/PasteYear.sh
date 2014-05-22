for i in *.done
do
####
echo $i | sed 's/pdsd//g' | sed 's/.txt.done//g' > Year
#
TheYear=`cat Year`
#
sed "s|$| ${TheYear}|" $i > $i.Year
####
done


#The above is crap

cat MergePesticides | sed 's/.*\(.\{4\}$\).*/\1/' | uniq > Year
