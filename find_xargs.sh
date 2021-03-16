#!/bin/sh

# Download GNU parallel at https://www.gnu.org/software/parallel/.
#
# Search for .bam files anywhere in the current directory recursively:
find . -name "*.bam"



# Delete all .bam files (Irreversible: use with caution! Confirm list BEFORE deleting):
find . -name "*.bam" | xargs rm



# Rename all .txt files to .bak (backup *.txt before doing something else to them, for example):
find . -name "*.txt" | sed "s/\.txt$//" | xargs -i echo mv {}.txt {}.bak | sh



# Chastity filter raw Illumina data (grep reads containing :N:, append (-A) the three lines after the match containing the sequence and quality info, and write a new filtered fastq file):
find *fq | parallel "cat {} | grep -A 3 '^@.*[^:]*:N:[^:]*:' | grep -v '^\-\-$' > {}.filt.fq"



# Run FASTQC in parallel 12 jobs at a time:
find *.fq | parallel -j 12 "fastqc {} --outdir ."



# Index your bam files in parallel, but only echo the commands (--dry-run) rather than actually running them:
find *.bam | parallel --dry-run 'samtools index {}'