#/bin/bash
DATA_PATH="/home/omics/DATA1/haeun/stemness/data/TCGA-TARGET-GTEx/GTEx-mutli-tissue"
export DATA_PATH

parallel --env DATA_PATH --eta -j 24 --load 80% --noswap \
'java -jar /home/omics/DATA1/haeun/tools/Meta-Tissue.v.0.5/MetaTissueInputGenerator.jar \
-i $DATA_PATH/01_ori_input/tissue_info.txt \
-l $DATA_PATH/01_ori_input/gene_list.txt \
-m $DATA_PATH/01_ori_input/probe_info.txt \
-a $DATA_PATH/01_ori_input/geno_chr{}.eigenstrat \
-b $DATA_PATH/01_ori_input/ind_chr{}.txt \
-c $DATA_PATH/01_ori_input/snp_chr{}.txt \
-d $DATA_PATH/01_ori_input/cov.txt \
-p $DATA_PATH/02_MetaTissue_input/output_gene_chr{}.txt \
-q $DATA_PATH/02_MetaTissue_input/output_snp_chr{}.txt \
-r $DATA_PATH/02_MetaTissue_input/matrix_chr{}.txt \
-s $DATA_PATH/02_MetaTissue_input/output_cov_chr{}.txt' ::: {1..22}
