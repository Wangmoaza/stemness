#
/bin/bash
PROG_PATH=/home/omics/DATA1/haeun/tools/Meta-Tissue.v.0.5
DATA_PATH=/home/omics/DATA1/haeun/stemness/data/TCGA-TARGET-GTEx/GTEx-mutli-tissue

java -jar $PROG_PATH/01_ori_input/MetaTissueInputGenerator \
-i $DATA_PATH/01_ori_input/tissue_info.txt \
-l $DATA_PATH/01_ori_input/gene_list.txt \
-m $DATA_PATH/01_ori_input/probe_info.txt \
-a $DATA_PATH/01_ori_input/geno.eigenstrat \
-b $DATA_PATH/01_ori_input/ind.txt \
-c $DATA_PATH/01_ori_input/snp.txt \
-d $DATA_PATH/01_ori_input/cov.txt \
-p $DATA_PATH/02_MetaTissue_input/output_gene.txt \
-q $DATA_PATH/02_MetaTissue_input/output_snp.txt \
-r $DATA_PATH/02_MetaTissue_input/matrix.txt \
-s $DATA_PATH/02_MetaTissue_input/output_cov.txt \
-v
