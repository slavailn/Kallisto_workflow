# 📄 The `run_info.json` File

The output of `kallisto quant` includes a `run_info.json` file that provides summary statistics and metadata about the run.

---

## 🧾 Example Output

```json
{
  "n_targets": 278369,
  "n_bootstraps": 100,
  "n_processed": 30457819,
  "n_pseudoaligned": 24430820,
  "n_unique": 9405348,
  "p_pseudoaligned": 80.2,
  "p_unique": 30.9,
  "kallisto_version": "0.51.1",
  "index_version": 13,
  "k-mer length": 31,
  "start_time": "Wed Jun 11 11:20:50 2025",
  "call": "kallisto quant -b 100 --rf-stranded -i ../gencode_M37_transcripts/gencode.vM37.idx -o kallisto_out/M60 -t 8 --plaintext ./NS.X0177.002.NEBNext_dual_i7_D5---NEBNext_dual_i5_D5.M60_R1.fastq.gz ./NS.X0177.002.NEBNext_dual_i7_D5---NEBNext_dual_i5_D5.M60_R2.fastq.gz"
}
```

---

## 📘 Interpretation of Fields

| Field              | Meaning |
|-------------------|---------|
| `n_targets`        | Number of transcript targets in the index. Each corresponds to a unique transcript (e.g., from a FASTA file like `gencode.vM37.transcripts.fa`). |
| `n_bootstraps`     | Number of bootstrap replicates requested for quantification uncertainty (via `-b N`). |
| `n_processed`      | Total number of fragments (read pairs or single-end reads) processed by Kallisto. |
| `n_pseudoaligned`  | Number of fragments that were successfully pseudoaligned to at least one transcript. |
| `n_unique`         | Number of fragments pseudoaligned to **only one transcript**. |
| `p_pseudoaligned`  | Percentage of fragments that were pseudoaligned: `(n_pseudoaligned / n_processed) * 100`. |
| `p_unique`         | Percentage of fragments that were uniquely pseudoaligned: `(n_unique / n_processed) * 100`. |
| `kallisto_version` | Version of Kallisto used. |
| `index_version`    | Internal version of the index file format. |
| `k-mer length`     | Length of k-mers used to build the index (commonly 31). |
| `start_time`       | Time the run began. Useful for record-keeping and troubleshooting. |
| `call`             | Full command-line call used to run `kallisto quant`. Helps document parameters and file inputs. |
