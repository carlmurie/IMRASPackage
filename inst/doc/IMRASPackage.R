## ----echo=TRUE, message=FALSE, warning=TRUE, cache=FALSE-----------------
library(RNASeqPipelineR)
library(data.table)
library(Biobase)
library(kableExtra)
##library(magrittr)

RUN_KALLISTO <- FALSE

## create or load project
PREFIX<-"/shared/silo_researcher/Gottardo_R/cmurie_working/IMRAS2"
##createProject(project_name = "IMRAS2_RNASeq" ,path = PREFIX, load_from_immport = FALSE)
loadProject(project_dir=PREFIX, name="IMRAS2_RNASeq")

## build kallisto index if necessary
utils_dir <- "/shared/silo_researcher/Gottardo_R/10_ref_files/Reference_Genome/Homo_sapiens/Ensembl/kallisto/"
setGenomeReference(utils_dir, "GRCH38_R91.idx")

if(RUN_KALLISTO) {
    kallistoAlign(kallisto_threads=3, paired=TRUE, mail="cmurie@fredhutch.org",
                  minutes_requested=1, slurm=TRUE, slurm_partition=NULL,
                  force=TRUE,
                  paired_pattern=c("_1.fastq", "_2.fastq"))

    kallistoAssembleOutput(paired=TRUE)

    runFastQC(ncores=8) 
    kallistoAssembleQC(paired=TRUE, doAnnotation=TRUE) 
} ## if RUN_KALLISTO

## remove fastq file with no phenotype data
outDir <- RNASeqPipelineR:::getDir("OUTPUT")
pheno <- fread(paste0(outDir, "/kallisto_Pheno.csv"), sep=",", header=TRUE, data.table=FALSE)
counts <- fread(paste0(outDir, "/kallisto_counts.csv"), sep=",", header=TRUE,
                data.table=FALSE)
tpm <- fread(paste0(outDir, "/kallisto_tpms.csv"), sep=",", header=TRUE, data.table=FALSE)
diff <- setdiff(colnames(counts)[-1], pheno$Sample)

## remove samples that are lacking phenotype information
##counts[,diff] <- NULL
##tpm[,diff] <- NULL

## format for ExpressionSet
rownames(pheno) <- pheno$Sample
pheno$X <- NULL
rownames(counts) <- counts$hgnc_symbol
counts$hgnc_symbol=NULL
rownames(tpm) <- tpm$hgnc_symbol
tpm$hgnc_symbol=NULL

## create and save read values and pheno information as ExpressionSet Rds objects
IMRAS_counts_Eset <- ExpressionSet(assayData=as.matrix(counts),
                             phenoData=AnnotatedDataFrame(pheno))
IMRAS_tpm_Eset <- ExpressionSet(assayData=as.matrix(tpm),
                             phenoData=AnnotatedDataFrame(pheno))


## ----echo=FALSE, results="asis"------------------------------------------
mat <- cbind(c("CL100037161_L02_23", "CL100037161_L02_24", "CL100037161_L02_25", "CL100037161_L02_26"), c("IMRAS002.26", "IMRAS002.13", "IMRAS005.04", "IMRAS049.34"))
colnames(mat) <- c("BGI", "Hiseq2000")
kable(mat, align=rep("c", ncol(mat))) %>%
    kable_styling(bootstrap_options = c("striped", "hover", "condensed"), 
                  full_width=FALSE, position="left")

## ----echo=FALSE, results="asis"------------------------------------------
cat(pheno$Sample, sep="  \n")

## ----echo=FALSE----------------------------------------------------------
sessionInfo()

