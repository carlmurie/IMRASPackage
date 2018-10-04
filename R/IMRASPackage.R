#' IMRAS Package
#' A data package for IMRAS Package.
#' @title IMRASPackage
#' @name IMRASPackage
#' @description Raw read counts and TPM values for RNASeq IMRAS  study.
#' @details Use \code{data(package='IMRAS Package')$results[, 3]} to see a
#' list of availabledata sets in this data package and/or
#' DataPackageR::load_all _datasets() to load them. Alternatively one can use
#' \code{data(IMRAS_counts_Eset)} or \code{data(IMRAS_tpm_Eset)} to load the data.
#' @seealso
#' \link{IMRAS_counts_Eset}
#' \link{IMRAS_tpm_Eset}
NULL




#' Contains two tables: assayData which contains raw read counts where the
#' rows are genes and columns are samples and phenoData which contains
#' experimental design metadata where each row is a sample and each column
#' is a factor describing each sample. The rows of phenoData map to the
#' columns of assayData. The assayData and phenoData tables can be extracted
#' with \code{exprs(IMRAS_counts_Eset)} and \code{pData(IMRAS_counts_Eset)} respectively.
#' 
#' @name IMRAS_counts_Eset
#' @docType data
#' @title Non-normalized and unfiltered raw read counts of IMRAS  study.
#' @format a \code{ExpressionSet} containing the following fields:
#' \describe{assayData and phenoData}
#' @source The data comes from RNASeq fasta files.
#' @seealso
#' \link{IMRASPackage}
#' \link{IMRAS_tpm_Eset}
NULL



#' Contains two tables: assayData which contains tpm counts where the
#' rows are genes and columns are samples and phenoData which contains
#' experimental design metadata where each row is a sample and each column
#' is a factor describing each sample. The rows of phenoData map to the
#' columns of assayData. The assayData and phenoData tables can be extracted
#' with \code{exprs(IMRAS_tpm_Eset)} and \code{pData(IMRAS_tpm_Eset)} respectively.
#' 
#' @name IMRAS_tpm_Eset 
#' @docType data
#' @title transcripts per million (tpm) of IMRAS study
#' @format a \code{ExpressionSet} containing the following fields:
#' \describe{assayData and phenoData}
#' @source The data comes from RNASeq fasta files.
#' @seealso
#' \link{IMRASPackage}
#' \link{IMRAS_counts_Eset}
NULL
