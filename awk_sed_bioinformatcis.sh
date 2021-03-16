#!/bin/sh


# Returns all lines on Chr 1 between 1MB and 2MB in file.txt. (assumes) chromosome in column 1 and position in column 3 (this same concept can be used to return only variants that above specific allele frequencies):

cat file.txt | awk '$1=="1"' | awk '$3>=1000000' | awk '$3<=2000000'



# Basic sequence statistics. Print total number of reads, total number unique reads, percentage of unique reads, most abundant sequence, its frequency, and percentage of total in file.fq:

cat myfile.fq | awk '((NR-2)%4==0){read=$1;total++;count[read]++}END{for(read in count){if(!max||count[read]>max) {max=count[read];maxRead=read};if(count[read]==1){unique++}};print total,unique,unique*100/total,maxRead,count[maxRead],count[maxRead]*100/total}'



# Convert .bam back to .fastq:

samtools view file.bam | awk 'BEGIN {FS="\t"} {print "@" $1 "\n" $10 "\n+\n" $11}' > file.fq



# Keep only top bit scores in blast hits (best bit score only):

awk '{ if(!x[$1]++) {print $0; bitscore=($14-1)} else { if($14>bitscore) print $0} }' blastout.txt



# Keep only top bit scores in blast hits (5 less than the top):

awk '{ if(!x[$1]++) {print $0; bitscore=($14-6)} else { if($14>bitscore) print $0} }' blastout.txt



# Split a multi-FASTA file into individual FASTA files:

awk '/^>/{s=++d".fa"} {print > s}' multi.fa



# Output sequence name and its length for every sequence within a fasta file:

cat file.fa | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }'



# Convert a FASTQ file to FASTA:

sed -n '1~4s/^@/>/p;2~4p' file.fq > file.fa



# Extract every 4th line starting at the second line (extract the sequence from FASTQ file):

sed -n '2~4p' file.fq



# Print everything except the first line

awk 'NR>1' input.txt



# Print rows 20-80:

awk 'NR>=20&&NR<=80' input.txt



# Calculate the sum of column 2 and 3 and put it at the end of a row:

awk '{print $0,$2+$3}' input.txt



# Calculate the mean length of reads in a fastq file:

awk 'NR%4==2{sum+=length($0)}END{print sum/(NR/4)}' input.fastq



# Convert a VCF file to a BED file

sed -e 's/chr//' file.vcf | awk '{OFS="\t"; if (!/^#/){print $1,$2-1,$2,$4"/"$5,"+"}}'



# Create a tab-delimited transcript-to-gene mapping table from a GENCODE GFF. The substr(x,s,n) returns n characters from string x starting from position s. This gets rid of the quotes and semicolon.

bioawk -c gff '$feature=="transcript" {print $group}' gencode.v28.annotation.gtf | awk -F ' ' '{print substr($4,2,length($4)-3) "\t" substr($2,2,length($2)-3)}' > txp2gene.tsv



# extract specific reads from fastq file according to reads name :

zcat a.fastq.gz | awk 'BEGIN{RS="@";FS="\n"}; $1~/readsName/{print $2; exit}'



# count missing sample in vcf file per line:

bcftools query -f '[%GT\t]\n' a.bcf |  awk '{miss=0};{for (x=1; x<=NF; x++) if ($x=="./.") {miss+=1}};{print miss}' > nmiss.count