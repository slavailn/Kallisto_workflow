# 🧬 Creating a Gene Model for RSeQC

Many **RSeQC** tools require a **gene model file in BED12 format** (not GTF or GFF). This is used by tools like `infer_experiment.py`, `geneBody_coverage.py`, and `read_distribution.py`.

---

## ✅ How to Create a Gene Model BED File

### 🔹 Option 1: Convert GTF to BED Using BEDOPS or UCSC Tools

```bash
# Convert GTF to BED12
gtf2bed < annotation.gtf > gene_model.bed
```

### 🔹 Option 2: Use gffread + awk (Bioconda Tools)

```bash
# Step 1: Extract exons from GTF
gffread annotation.gtf -T -o- | awk '$3=="exon"' > exons.gtf

# Step 2: Convert to BED format
awk 'BEGIN{OFS="\t"} $3=="exon" {
  split($9,a,";");
  gene_id=a[1]; gsub("gene_id ","",gene_id); gsub("\"","",gene_id);
  print $1,$4-1,$5,gene_id,0,$7
}' exons.gtf > gene_model.bed
```

> ⚠️ Note: Some RSeQC tools expect BED12 format with exon block sizes and starts. Simple 6-column BED may not work for all functions.

---

## 📦 Option 3: Download Prebuilt BED Files (Human/Mouse)

For human or mouse genomes, RSeQC provides prebuilt BED files:

📁 [RSeQC BED files on SourceForge](https://sourceforge.net/projects/rseqc/files/BED/)

### Example (Human hg38, RefSeq):

```bash
wget https://sourceforge.net/projects/rseqc/files/BED/Human_Homo_sapiens/hg38_RefSeq.bed.gz
gunzip hg38_RefSeq.bed.gz
```

---

## 📐 Required Format (BED12)

Make sure your `gene_model.bed` file has **12 columns**:

```
chr1    11873   14409   NR_046018   0   +   11873   11873   0   3   354,109,1189,   0,744,1347
```

> Column 10–12 describe **exon block sizes and starts**—required for splicing-aware RSeQC tools.

---

## 🧪 Example Usage

```bash
infer_experiment.py -r gene_model.bed -i sample.bam
```

---
