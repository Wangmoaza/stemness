setwd('~/2TB_disk/cancer-stem')
library(edgeR)
library(RUVSeq)
library(stringr)
library(tidyr)
# import data
hk_genes <- read.table('data/housekeeping/housekeeping_genes.txt', sep='\t')[1]
hk_genes <- unlist(hk_genes)
sample_info <- read.delim('data/TOIL/sample_info.txt', header=TRUE, row.names = 1)
bodysite = 'Breast'
expr <- read.delim(str_interp('data/TOIL/TOIL_RSEM_Hugo_${bodysite}_count_int.txt'), row.names = 1, header=TRUE, check.names = FALSE)
expr <- expr %>% drop_na()


for (vec in list(c("Normal", "PNT"), c("PNT", "Tumor"), c("Normal", "Tumor"))){
  type_A <- vec[1]
  type_B <- vec[2]

  # filter out non-expressed genes (> 10 reads in >=2 samples)
  filter <- apply(expr, 1, function(x) length(x[x>10])>=2)
  filtered <- expr[filter,]
  
  # leave only query tissue_status samples, match order of the samples
  condition <- (sample_info[, 'body_site'] == bodysite) & ((sample_info[, 'tissue_status'] == type_A) | (sample_info[, 'tissue_status'] == type_B))
  x <- droplevels(as.factor(sample_info[condition, 'tissue_status']))
  filtered <- filtered[, rownames(sample_info[condition, ])]
  
  ###############################
  # RUVSeq : Remove Unwanted Variation
  ###############################
  hk_genes2 <- intersect(as.character(rownames(filtered)), as.character(hk_genes))
  genes <- setdiff(as.character(rownames(filtered)), hk_genes2)
  set <- newSeqExpressionSet(as.matrix(filtered),
                             phenoData = data.frame(x, row.names = colnames(filtered)))
  
  # normalize the data using upper-quartile (UQ) normalization
  #set_uq <- betweenLaneNormalization(set, which="upper")
  
  set1 <- RUVg(set, hk_genes2, k=10)
  
  ###############################
  # edgeR: DEG analysis
  ###############################
  design <- model.matrix(~x + W_1 + W_2 + W_3 + W_4 + W_5 + W_6 + W_7 + W_8 + W_9 + W_10, data=pData(set1))
  y <- DGEList(counts=counts(set1), group=x)
  y <- calcNormFactors(y, method="upperquartile")
  y <- estimateGLMCommonDisp(y, design)
  y <- estimateGLMTagwiseDisp(y, design)
  fit <- glmQLFit(y, design)
  qlf <- glmQLFTest(fit, coef=2)
  
  print(summary(decideTests(qlf)))
  pdf(str_interp("Analysis/DEG/${bodysite}.${type_A}_${type_B}.plotMD.pdf"))
  plotMD(qlf)
  dev.off()
  tab <- topTags(qlf, n=30000, adjust.method = 'bonferroni', p.value = 0.05)
  write.table(tab, str_interp("Analysis/DEG/${bodysite}.${type_A}_${type_B}.DEG_list.txt"), sep="\t", quote = F)
}

