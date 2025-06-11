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

# 🧬 Interpreting `infer_experiment.py` Results for Paired-End RNA-Seq

When you run **`infer_experiment.py`** from **RSeQC** on a **paired-end RNA-seq** experiment, it outputs a breakdown of how reads align relative to gene models. This helps you determine **library strandedness**.

---

## 🔍 Sample Output

```text
This is PairEnd Data
Fraction of reads explained by "1++,1--,2+-,2-+": 0.0151
Fraction of reads explained by "1+-,1-+,2++,2--": 0.9753
Fraction of reads explained by others: 0.0096
```

---

## ✅ Key Concepts

RSeQC infers how the **strand of your reads** relates to the **strand of annotated transcripts** in your BED file.

### 🔸 Pattern Groups

| Group                          | Library Type                      | Interpretation                                      |
|-------------------------------|-----------------------------------|-----------------------------------------------------|
| `1++,1--,2+-,2-+`              | **FR** (non-stranded or forward)  | Read1 same strand as gene, Read2 opposite           |
| `1+-,1-+,2++,2--`              | **RF** (reverse stranded)         | Read1 opposite strand as gene, Read2 same strand    |

> - Numbers (1, 2) refer to **read mates** (R1 or R2).  
> - `+/-` refers to strand orientation relative to transcript in BED.

---

## 📘 How to Interpret the Output

### ✅ Reverse-Stranded Libraries (Most Common)

```text
Fraction explained by "1+-,1-+,2++,2--": ~0.95+
```

🟢 This indicates a **reverse-stranded (RF)** library. Use:

```bash
--rna-strandness RF
```

---

### ✅ Forward-Stranded Libraries

```text
Fraction explained by "1++,1--,2+-,2-+": ~0.95+
```

🟢 This indicates a **forward-stranded (FR)** library. Use:

```bash
--rna-strandness FR
```

---

### ✅ Unstranded Libraries

```text
Both fractions close to 0.5 or neither dominates
```

🟡 This suggests an **unstranded** library. Use:

```bash
--rna-strandness unstranded
```

or omit strand-specific options.

---

## 🚨 Caveats

- Use a **BED12** file with accurate strand info.
- Ambiguously mapped reads may affect the outcome.
- Best results come from **uniquely mapped, properly paired reads**.

---




