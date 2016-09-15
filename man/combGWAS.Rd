\name{combGWAS}
\Rdversion{2.0}
\alias{combGWAS}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Combining Univariate Association Test Results of Multiple Phenotypes for Detecting Pleiotropy
}
\description{
combGWAS() can be used to detect pleiotropy by combining univariate association test results of multiple phenotypes in genome-wide association studies (or studies of a large number of SNPs). In this function, we have several combination approaches including the O'Brien's method that is weighted sum of the Z or beta statistic (direction sensitive) and other methods that are weighted sum of the squared Z statistics (direction insensitive).
}
\usage{
combGWAS(project = "mv", traitlist, traitfile, comb_method = c("z"), 
betasign = rep(1, length(traitlist)), snpid, beta = NULL, SE = NULL, 
Z = NULL, coded_all, AF_coded_all, n_total = NULL, pvalue = NULL, 
Z_sample_weighted = FALSE)
}
\arguments{
  \item{project}{
a character string for project name, for labeling output file.
}
  \item{traitlist}{
a vector of character strings of the phenotype names for naming the output file. 
}
  \item{traitfile}{
a vector of character strings containing the univariate association results file names corresponding to the order in \code{traitlist} for reading in for analysis. Each univariate result file should contain the header corresponding to following fields: \code{snpid}, \code{beta}, \code{SE}, \code{coded_all}, \code{AF_coded_all}, \code{n_total}, \code{pvalue}. These fields can be labeled in any name in the header. You are asked to give the names of these fields as arguments for this function. 
}
  \item{comb_method}{
a vector of character strings  indicating the method to be used in combing univariate association results file. It can be any subset of c("z", "beta", "chisq" and "sumsq"). The details of the combination methods are given in Details. 
}
  \item{betasign}{
a numeric vector for changing the signs (1 or -1) of the univariate beta (or Z) statistics. It should be of the same length and correspond to the order in \code{traitfile} (or \code{traitlist}).
}
  \item{snpid}{
the name of the genetic marker in the header of input association results files. 
}
  \item{beta}{
the name of the beta estimate (if have) in the header of input association results files. 
}
  \item{SE}{
the name of the standard error of the beta estimate (if have) in the header of input association results files. 
}
  \item{Z}{
the name of the Z statistic (if have) in the header of input association results files. 
}
  \item{coded_all}{
the name of coded allele in the header of input association results files.
}
  \item{AF_coded_all}{
the name of the allele frequency of the coded allele in the header of input association results file.
}
  \item{n_total}{
the sample size with phenotype and genotype for the genetic marker in the header of input association results file. 
}
  \item{pvalue}{
the name of the p-value of the beta estimate (if have) in the header of input association results file. 
}
  \item{Z_sample_weighted}{
a logical value. True if the results of Z method are combined by sample size weighted. False if the results are combined equally weighted.
}
}
\details{
The orders of traits in \code{traitlist} and \code{traitfile} should be the same. 
\cr
\cr
Currently, 4 combination methods ("z", "beta", "chisq" and "sumsq") can be implemented by the package. The default is to implement equally weighted "z" method only, but you can ask for the 4 methods simultaneously. 
\cr
\cr
\code{betasign} should be a vector of 1 or -1 with the number of traits as the length. 1 means the beta of corresponding trait remains and -1 means the beta sign will be reversed. It only affects "z" and "beta" methods. 
\cr
\cr
\code{snpid}, \code{coded_all} and \code{AF_coded_all} must be assigned explicitly and the corresponding columns must appear in the input datasets. 
\cr
\cr
At least one of \code{beta(SE)} and \code{Z} should be assigned. In particular, if "beta" method is implemented, \code{beta} and \code{SE} must be assigned. 
\cr
\cr
\code{n_total} and/or \code{pvalue} can be missing in the input datasets. In particular, if "z" method is set to be sample size weighted, \code{n_total} must be assigned.
}
\value{
No value is returned. Instead, results are written to \code{outfile} (named as "project_traits_method.csv") in the current working directory. In the \code{outfile}, there are some new variables (listed below) created by the package along with the existing variables in the original datasets. 
\item{zi}{Z statistic for the ith phenotype in traitlist. They will appear in "z", "chisq" and "sumsq" methods.}
\item{pi}{p-value for the ith phenotype in traitlist.}
\item{beta}{combined statistic of "beta" methods.}
\item{SE}{standard error of the combined statistic of "beta" methods.}
\item{Z.comb}{Z statistic (Z.comb=beta/SE) of "beta" and "z" methods.}
\item{betai}{beta statistic for the ith phenotype in traitlist. They will appear in output for "beta" method.}
\item{chisq.comb}{combined and test statistic of "chisq" and "sumsq" methods.}
\item{pval}{p-value of the combined statistic.}
\item{meanN}{the mean sample size with phenotype and genotype for the genetic marker. N/A if \code{n_total} is not specified.}
\item{minN}{the minimum sample size with phenotype and genotype for the genetic marker. N/A if \code{n_total} is not specified.}
\item{maxN}{the maximum sample size with phenotype and genotype for the genetic marker. N/A if \code{n_total} is not specified.}
\item{remark1}{The sign of beta will be flipped if coded alleles different between two datasets.}
\item{remark2}{If the minimum eigen value of the covariance matrix is less than 0.01, we consider it as nearly singular and the analyses will stop.}
\item{remark3}{The alleles are supposed called on positive strand. If not, the user should convert
the coded allele to that on a positive strand in the result file.}
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
CUMP: an R package for analyzing multivariate phenotypes in genetic association studies 
}
\author{
Shuo Li <skyli@bu.edu>, Xuan Liu <liuxuan@bu.edu> and Qiong Yang <qyang@bu.edu> 
}
\examples{
##The following are two fake examples. Do NOT run. 
##Please refer to example.pdf for details.
##no change of beta signs before combining
##combGWAS(project="mv",traitlist=c("phen1","phne2"),
## traitfile=c("Phen1GWAS.csv", "Phen2GWAS.csv"), comb_method=c("z","chisq"), 
## betasign=c(1,1), snpid="SNPID", beta="beta", SE="SE", 
## coded_all="coded_all"", AF_coded_all=" AF_coded_all ", pvalue="pval") 

##change of  beta signs before combining: the beta sign for the 2nd phenotype reversed
##combGWAS(project="mv",traitlist=c("phen1","phne2"),
## traitfile=c("Phen1GWAS.csv", "Phen2GWAS.csv"), comb_method=c("z","chisq"),
## betasign=c(1,-1), snpid="SNPID", beta="beta", SE="SE", 
## coded_all="coded_all ", AF_coded_all=" AF_coded_all ", pvalue="pval") 
}