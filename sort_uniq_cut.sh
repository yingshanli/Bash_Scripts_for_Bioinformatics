#!/bin/sh


Number each line in file.txt:

cat -n file.txt
Count the number of unique lines in file.txt

cat file.txt | sort -u | wc -l
Find lines shared by 2 files (assumes lines within file1 and file2 are unique; pipe to wd -l to count the number of lines shared):

sort file1 file2 | uniq -d

# Safer
sort -u file1 > a
sort -u file2 > b
sort a b | uniq -d

# Use comm
comm -12 file1 file2
Sort numerically (with logs) (g) by column (k) 9:

sort -gk9 file.txt
Find the most common strings in column 2:

cut -f2 file.txt | sort | uniq -c | sort -k1nr | head
Pick 10 random lines from a file:

shuf file.txt | head -n 10
Print all possible 3mer DNA sequence combinations:

echo {A,C,T,G}{A,C,T,G}{A,C,T,G}
Untangle an interleaved paired-end FASTQ file. If a FASTQ file has paired-end reads intermingled, and you want to separate them into separate /1 and /2 files, and assuming the /1 reads precede the /2 reads:

cat interleaved.fq |paste - - - - - - - - | tee >(cut -f 1-4 | tr "\t" "\n" > deinterleaved_1.fq) | cut -f 5-8 | tr "\t" "\n" > deinterleaved_2.fq
Take a fasta file with a bunch of short scaffolds, e.g., labeled >Scaffold12345, remove them, and write a new fasta without them:

samtools faidx genome.fa && grep -v Scaffold genome.fa.fai | cut -f1 | xargs -n1 samtools faidx genome.fa > genome.noscaffolds.fa
Display hidden control characters:

python -c "f = open('file.txt', 'r'); f.seek(0); file = f.readlines(); print file" 