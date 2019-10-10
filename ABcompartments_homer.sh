for sm in  blastocyst
do
species=human
genome=hg19
res=100k
superes=400k
resk=100000
superesk=400000
RE=GATC

makeTagDirectory ${sm}_un -format HiCsummary ./example\ data/homer.$sm.test.summary.txt
cp -pr ${sm}_un ${sm}_pro
makeTagDirectory ${sm}_pro -update -genome /home/chenxp/anaconda2/homer/data/genomes/$genome/ -removePEbg -restrictionSite $RE -both -removeSelfLigation

runHiCpca.pl $sm.$res.$superesCompartment.Homer ${sm}_pro -res $resk -superRes $superesk -genome $genome -pc 3 

rm -r ${sm}_un
done

