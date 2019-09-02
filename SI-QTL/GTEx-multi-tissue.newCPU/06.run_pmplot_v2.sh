#/bin/bash
#!/usr/bin/env python

UNIV_PATH=/home/omics/DATA_CPU/haeun/stemness

cd /home/omics/haeun/program/ForestPMPlot/
python pmplot_haeun.py \
$UNIV_PATH/05_Merged_output/GTEx_TOIL_white_MetaTissue.mm.beta.std.mRNAsi.txt \
$UNIV_PATH/05_Merged_output/GTEx_TOIL_white_MetaTissue.mRNAsi.SI-QTL.txt \
$UNIV_PATH/PMPlot/study_name.txt \
$UNIV_PATH/PMPlot/study_order.txt \
$UNIV_PATH/PMPlot/SI-QTL.top100.tbt_1_removed.rsid.txt \
mRNAsi \
$UNIV_PATH/PMPlot/SI-QTL.top100.tbt_1_removed/GTEx_TOIL_white_MetaTissue.mRNAsi \
$UNIV_PATH/05_Merged_output/GTEx_TOIL_white_MetaTissue.tbt.ps.mRNAsi.txt

