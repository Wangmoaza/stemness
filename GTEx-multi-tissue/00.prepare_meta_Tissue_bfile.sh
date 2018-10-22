#!/bin/bash

cd ~/DATA1/haeun/stemness/data/TCGA-TARGET-GTEx/GTEx-mutli-tissue/01_ori_input
cut -f1 tissue_info.txt | tail -n +2 | awk '{print $1 "\t" $1'} > ../indiv_list3.txt
/home/omics/DATA1/haeun/tools/plink_1.09/plink --bfile ../MAF0.01_white_GTEx_genotype2 --keep ../indiv_list3.txt --make-bed --out MAF0.01_white_GTEx_genotype_MetaTissue
awk '{$6=1; print;}' MAF0.01_white_GTEx_genotype_MetaTissue.fam > out
mv out MAF0.01_white_GTEx_genotype_MetaTissue.fam
rm out
