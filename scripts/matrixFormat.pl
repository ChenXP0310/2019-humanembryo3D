#!/usr/bin/perl

######################
##### 2016/11/07 #####
######################

use strict; 
use warnings;


my ($matrix, $chr, $resolution, $genome, $genome_size_file) = @ARGV;
    if ((not defined $matrix) ||
	(not defined $chr) ||
	(not defined $resolution) ||
	(not defined $genome) ||
	(not defined $genome_size_file)) {
	die ("Usage: ./matrixFormat.pl <matrix> <chr> <resolution> <genome_version> <genome size file>\n");
     }

open(IN,"$genome_size_file") or die "$!";
my $fai;
while(<IN>){
	chomp;
	my @line=split;
	if($line[0] eq $chr){$fai=$line[1];}else{next;}
}
	

my $nine=$resolution;
open(IN,"$matrix") or die "$!";
my $i=1;
my @header;
my @matrix;
while(<IN>){
	chomp;
	my @line=split;
	my $start=shift(@line);	
	my $out=join("\t",@line);push(@matrix,"$out");
	my $end=$start+$nine;
	my $h_out;
	if($i==1){$h_out="$chr\t0\t$resolution";push(@header,"$h_out");}else{if($end>$fai){$h_out="$chr\t$start\t$fai";push(@header,"$h_out");}else{$h_out="$chr\t$start\t$end";push(@header,"$h_out");}}
	$i++;
	
}
close IN;
my $header=join("\t",@header);
for my $j (0..$#header){
	print "$header[$j]\t$matrix[$j]\n";
}
