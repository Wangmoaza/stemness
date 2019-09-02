#!/bin/bash

PARFILE="/home/omics/DATA1/haeun/stemness/src/GTEx-multi-tissue/par.PED.EIGENSTRAT"

parallel --eta -j 8 --load 80% --noswap '/home/omics/miniconda2/bin/convertf -p /home/omics/DATA1/haeun/stemness/src/GTEx-multi-tissue/par.PED.EIGENSTRAT_chr{}' ::: {1..22}
