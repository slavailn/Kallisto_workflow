## Creating transcript index

### Obtain a collection of transcripts
We can either download an existing collection of transcripts or create one based on the genome fasta file and an annptation file in gtf or gff format.
---------
1. Downloading an existing collection.
   *Ensembl*
    Navigate to Ensembl FTP
    Select your species → release-XXX/fasta/<species>/cdna/
    Download:
   <species>.<assembly>.cdna.all.fa.gz
---------
   *NCBI RefSeq*
   Look for .rna.fna.gz files on the RefSeq FTP site if you need RefSeq-matching transcripts.
---------
   *GENCODE (more curated for human/mouse)*
   Visit: https://www.gencodegenes.org/
   Choose your organism/version → Download the “Transcript sequences (FASTA)”
   File: gencode.vXX.transcripts.fa.gz
---------
2. Generate Transcriptome FASTA Yourself (Custom annotation/genome)
---------
```
   # Install gffread
   mamba install -c bioconda gffread

   # Generate transcript sequences
   gffread annotation.gtf \
             -g genome.fa \
             -w transcripts.fa
```
---------
3. Create kallisto index
   ```
   # *.idx - index
   # transcripts.fa - fasta file with transcripts (created or downloaded from some repository)
   kallisto index -i transcriptome.idx transcripts.fa
   ```
 
