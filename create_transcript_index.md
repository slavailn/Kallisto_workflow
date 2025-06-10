# 📦 Creating a Transcript Index for Kallisto

## 🔹 Step 1: Obtain a Collection of Transcripts

You can either:

- **Download** an existing transcript FASTA file (recommended for common organisms), or  
- **Generate** a transcriptome FASTA yourself from a genome + GTF/GFF annotation.

---

### ✅ Option 1: Download Pre-Built Transcript FASTA

#### 🔸 Ensembl
- Go to the [Ensembl FTP site](https://ftp.ensembl.org/pub/)
- Navigate to:  
  `release-XXX/fasta/<species>/cdna/`
- Download the file:  
  ```
  <species>.<assembly>.cdna.all.fa.gz
  ```

#### 🔸 NCBI RefSeq
- Visit the [RefSeq FTP site](https://ftp.ncbi.nlm.nih.gov/)
- Look for:
  ```
  *.rna.fna.gz
  ```
- These files contain transcript sequences aligned with RefSeq gene annotations.

#### 🔸 GENCODE (Best for Human/Mouse)
- Visit: [https://www.gencodegenes.org/](https://www.gencodegenes.org/)
- Choose your species and release version.
- Download:  
  **Transcript sequences (FASTA)**  
  ```
  gencode.vXX.transcripts.fa.gz
  ```

---

### ✅ Option 2: Generate Transcriptome FASTA Yourself

This is useful for custom genomes or organisms without pre-built resources.

```bash
# Step 1: Install gffread (via mamba or conda)
mamba install -c bioconda gffread

# Step 2: Generate transcript FASTA from genome + annotation
gffread annotation.gtf \
        -g genome.fa \
        -w transcripts.fa
```

---

## 🔹 Step 2: Create Kallisto Index

Once you have the transcript FASTA (either downloaded or generated):

```bash
# *.idx       → output index file
# transcripts.fa → transcript FASTA file
kallisto index -i transcriptome.idx transcripts.fa
```

---

## 🧪 Example: GENCODE Mouse Transcriptome Index

```bash
# Download transcript FASTA from GENCODE FTP
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/latest_release/gencode.vM37.transcripts.fa.gz

# Build kallisto index
kallisto index -i gencode.vM37.idx gencode.vM37.transcripts.fa
```
