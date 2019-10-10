## calculate TADsignal from normalized matrix ##

for chr in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22
do
less ./example\ data/Human.blastocyst.$chr.40k.txt|awk -v bin=$bin '{header=(NR-1)*bin;print header"\t"$0}' -|perl ./scripts/matrixFormat.pl - $chr 40000 hg19 hg19.genome.size |perl ./scripts/TADsignal_from_matrix.pl - 40000 2000000 hg19.genome.size |awk '{print "chr"$0}'  > Human.blastocyst.$chr.TADsignal.txt
cat Human.blastocyst.$chr.TADsignal.txt >> Human.blastocyst.TADsignal.txt
done
rm Human.blastocyst.chr*.TADsignal.*

## calculate TADsignal variance ##
./scripts/TAD_signal_variance.r   ## hardcoding for inputfile 
