##  mapping ##
bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 human.hg19.chrall.fa human_blastocyst_1.fq | samtools view -Shb - > human_blastocyst_1.bam
bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 human.hg19.chrall.fa human_blastocyst_2.fq | samtools view -Shb - > human_blastocyst_2.bam
##  raw contact matrix ##
hicBuildMatrix --samFiles human_blastocyst_1.bam human_blastocyst_2.bam --binSize 10000 --restrictionSequence GATC --outBam human_blastocyst_hicexplorer.bam --outFileName human_blastocyst_hicexplorer_10kb.h5 --QCfolder human_blastocyst_hicexplorer_10kb_QC --inputBufferSize 5000000
## generate low resolution matrix ##
hicMergeMatrixBins --matrix human_blastocyst_hicexplorer_10kb.h5 --numBins 4 --outFileName human_blastocyst_hicexplorer.40kb.h5 ## 40Kb resolution
hicMergeMatrixBins --matrix human_blastocyst_hicexplorer_10kb.h5 --numBins 10 --outFileName human_blastocyst_hicexplorer.100kb.h5 ## 100Kb resolution
hicMergeMatrixBins --matrix human_blastocyst_hicexplorer_10kb.h5 --numBins 20 --outFileName human_blastocyst_hicexplorer.200kb.h5 ## 200Kb resolution
## matrix normalization ##
hicCorrectMatrix diagnostic_plot --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 -m human_blastocyst_hicexplorer.40kb.h5 -o human_blastocyst_hicexplorer.40kb.png
hicCorrectMatrix correct --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 --filterThreshold -3 3 --perchr -m human_blastocyst_hicexplorer.40kb.h5 --sequencedCountCutoff 0.2 --iterNum 1500 -o human_blastocyst_hicexplorer.40kb.Corrected.h5 ## choose filterThreshold according to diagnostic_plot
## TAD and TAD boundaires ##
hicFindTADs -m human_blastocyst_hicexplorer.40kb.Corrected.h5 --minDepth 300000 --maxDepth 3000000 --step 300000 --minBoundaryDistance 400000 --correctForMultipleTesting fdr --delta 0.01 --outPrefix human_blastocyst_hicexplorer.40kb.Corrected --numberOfProcessors 3


