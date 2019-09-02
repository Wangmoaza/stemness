#!/bin/bash
FILE_PATH="/home/omics/DATA1/haeun/stemness/data/TCGA-TARGET-GTEx/GTEx-mutli-tissue"
export FILE_PATH

parallel --env FILE_PATH --eta -j 22 --load 80% --noswap '/home/omics/DATA1/haeun/tools/MetaTissueMM \
--expr $FILE_PATH/02_MetaTissue_input/output_gene_chr{}.txt \
--geno $FILE_PATH/02_MetaTissue_input/output_snp_chr{}.txt \
--matrix $FILE_PATH/02_MetaTissue_input/matrix_chr{}.txt \
--output $FILE_PATH/03_MetaTissue_output/GTEx_TOIL_white_MetaTissue_chr{} \
--cov $FILE_PATH/02_MetaTissue_input/output_cov_chr{}.txt \
--metatissue_bin_path /home/omics/DATA1/haeun/tools/Meta-Tissue.v.0.5/Metasoft \
--savebeta \
--heuristic \
-- n_digits 5 \
--full_metasoft_output' ::: {1..22}

