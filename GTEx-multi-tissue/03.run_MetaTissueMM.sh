#!/bin/bash
./home/omics/DATA1/haeun/tools/Meta-Tissue.v.0.5/MetaTissueMM \
--expr [gene expression file]         : File specified with -p option in Step 2 \
--geno [genotype file]                : File specified with -q option in Step 2 \
--matrix [tissue sharing matrix file] : File specified with -r option in Step 2 \
--output [output prefix]              : Prefix for output files (more info below) \
--metatissue_bin_path [Metasoft dir]  : Path to Metasoft folder (more info below) \
--cov [covariate file] \
--metatissue_bin_path /home/omics/DATA1/haeun/tools/Meta-Tissue.v.0.5 \
--savebeta \
--heuristic \
--full_metasoft_output /home/omics/DATA1/haeun/stemness/data/TCGA-TARGET-GTEx/GTEx-mutli-tissue/03_MetaTissue_output/TOIL_GTEx.MetaTissue 
