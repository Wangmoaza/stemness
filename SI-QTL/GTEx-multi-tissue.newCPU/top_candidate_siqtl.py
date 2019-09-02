import numpy as np
import pandas as pd
from statsmodels.stats import multitest

path = "~/DATA_CPU/haeun/stemness/05_Merged_output/"
siqtl = pd.read_csv(path + 'GTEx_TOIL_white_MetaTissue.mRNAsi.SI-QTL.txt', sep='\t', header=0, index_col=0)

siqtl.columns = list(siqtl.columns[1:]) + ['Delete']
siqtl = siqtl.iloc[:, :-1]

siqtl = siqtl.dropna()
siqtl = siqtl.astype('float64')
siqtl = siqtl[siqtl['PVALUE_RE2'] > 0]
rejected, qvals, _1, _2 = multitest.multipletests(siqtl['PVALUE_RE2'].values, alpha=0.2, method='fdr_bh')
rejected_idx = siqtl.index[np.nonzero(rejected)[0]]

tbt = pd.read_csv(path + 'GTEx_TOIL_white_MetaTissue.tbt.ps.mRNAsi.txt', sep=' ', header=None, index_col=0)
tbt = tbt.dropna()
tbt = tbt.astype('float64')
# remove tissue-by-tissue p-value = 1
tbt = np.abs(tbt - 1)
tbt_flag = tbt.agg(np.any, axis=1)
idx = tbt_flag[tbt_flag==True].index

siqtl = siqtl.loc[np.intersect1d(idx, rejected_idx), :]
siqtl.sort_values('PVALUE_RE2', ascending=True)
pd.Series(siqtl.index).to_csv('~/DATA_CPU/haeun/stemness/PMPlot/SI-QTL.FDR_0.2.tbt_1_removed.rsid.txt', header=False, index=False)
