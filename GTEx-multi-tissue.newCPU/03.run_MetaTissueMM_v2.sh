#!/bin/bash
#FILE_PATH="/home/omics/DATA_CPU/haeun/stemness/data/TCGA-TARGET-GTEx/GTEx-mutli-tissue"
FILE_PATH="/home/omics/DATA_CPU/haeun/stemness"
export FILE_PATH

parallel --env FILE_PATH --eta -j 20 --load 80% --xapply --noswap '/home/omics/haeun/program/MetaTissueMM \
--expr $FILE_PATH/02_MetaTissue_input/output_gene.txt \
--geno $FILE_PATH/02_MetaTissue_input/output_snp.txt \
--matrix $FILE_PATH/02_MetaTissue_input/matrix.txt \
--output $FILE_PATH/03_MetaTissue_output/GTEx_TOIL_white_MetaTissue \
--cov $FILE_PATH/02_MetaTissue_input/output_cov.txt \
--metatissue_bin_path /home/omics/haeun/program/Meta-Tissue.v.0.5/Metasoft \
--n_digits 5 \
--start_snp_index {1} \
--end_snp_index {2}' ::: {0..7980000..10000} ::: {10000..7990000..10000}

/home/omics/haeun/program/MetaTissueMM \
--expr $FILE_PATH/02_MetaTissue_input/output_gene.txt \
--geno $FILE_PATH/02_MetaTissue_input/output_snp.txt \
--matrix $FILE_PATH/02_MetaTissue_input/matrix.txt \
--output $FILE_PATH/03_MetaTissue_output/GTEx_TOIL_white_MetaTissue \
--cov $FILE_PATH/02_MetaTissue_input/output_cov.txt \
--metatissue_bin_path /home/omics/haeun/program/Meta-Tissue.v.0.5/Metasoft \
--n_digits 5 \
--start_snp_index 7990000 \
--end_snp_index 7991910

