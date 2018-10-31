#!/bin/bash
#!/usr/bin/env python
UNIV_PATH=/home/omics/DATA_CPU/haeun/stemness
#SNP_CHUNK=6090000
RS_ID_LIST=("rs1513729" "rs9529300" "rs9529303" "rs6562518" "rs9592541")

cd /home/omics/haeun/program/ForestPMPlot/
for RS_ID in ${RS_ID_LIST[*]}
do
	python pmplot_haeun.py \
	$UNIV_PATH/05_Merged_output/GTEx_TOIL_white_MetaTissue.mm.beta.std.mRNAsi.txt \
	$UNIV_PATH/05_Merged_output/GTEx_TOIL_white_MetaTissue.mRNAsi.SI-QTL.txt \
	$UNIV_PATH/PMPlot/study_name.txt \
	$UNIV_PATH/PMPlot/study_order.txt \
	${RS_ID}:mRNAsi \
	mRNAsi \
	$UNIV_PATH/PMPlot/GTEx_TOIL_white_MetaTissue.$RS_ID.mRNAsi.pmplot.out \
	$UNIV_PATH/05_Merged_output/GTEx_TOIL_white_MetaTissue.tbt.ps.mRNAsi.txt
done
