# 🎯 Mapping Reads Using Kallisto

Once the transcript index is prepared (`*.idx` file), you can map reads with **Kallisto**.

---

## 1️⃣ Map Single-End Reads

```bash
kallisto quant \
  --plaintext \             # (Optional) Output plain-text (needed if Kallisto lacks HDF5 support)
  -t 10 \                   # Use 10 threads
  -i transcriptome.idx \    # Kallisto index file
  -o output_directory \     # Output directory
  --single \                # Flag for single-end reads
  -l 200 \                  # Estimated average fragment length
  -s 20 \                   # Estimated standard deviation of fragment length
  -b 100 \                  # (Optional) Number of bootstrap samples
  sample.fastq
```

> **📌 Fragment Length and Standard Deviation (`-l`, `-s`)**
>
> These are estimates of your true fragment length distribution:
> - Check your sequencing facility's report for exact numbers.
> - If unknown, start with typical defaults: `-l 200 -s 20`.
> - You can refine these later based on alignment statistics or Bioanalyzer results.

### 🔗 References for Estimating Fragment Length:

- [Biostars: How to set fragment size for SE RNA-seq](https://www.biostars.org/p/253943/)
- [Biostars: Fragment size question 1](https://www.biostars.org/p/9543067/)
- [Biostars: Fragment size question 2](https://www.biostars.org/p/9544735/)
- [Relevant Paper](https://arxiv.org/abs/1104.3889)

---

## 2️⃣ Map Paired-End Reads

```bash
kallisto quant \
  -b 100 \                  # Number of bootstrap samples
  --plaintext \            # (Optional) Output plain-text
  -t 8 \                   # Use 8 threads
  --rf-stranded \          # Strand-specific library (first read reverse)
  -i transcriptome.idx \   # Transcriptome index
  -o output_dir \          # Output directory
  R1.fastq R2.fastq         # Paired-end FASTQ files
```

---

## 🧪 Example: Paired-End Read Mapping

```bash
kallisto quant -b 100 --plaintext -t 8 --rf-stranded \
  -i gencode_M37_transcripts/gencode.vM37.idx \
  -o test_output_paired \
  test_H4.M56_R1.fastq test_H4.M56_R2.fastq
```
