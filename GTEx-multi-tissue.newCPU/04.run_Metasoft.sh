#!/bin/bash

parallel --eta -j 20 --load 80% --noswap '/home/omics/DATA_CPU/haeun/stemness/03_MetaTissue_output/GTEx_TOIL_white_MetaTissue.SNP.{}.metasoft.sh' ::: {2400000..6000000..10000}
