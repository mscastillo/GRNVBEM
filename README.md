AR1MA1 - VBEM method for reverse engineering GRNs from pseudo-time series data
====

This repository includes the scripts to perform Gene Regulatory Network (GRN) inference from pseudo-time series data using a *first-order autoregressive moving average* (AR1MA1) model within a variational Bayesian Expectation-Maximization (VBEM) framework.


# Quick guide

1. Download/clone the repository.
1. Set up your input data as in [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/mESC.csv), with genes as rows and samples (pseudo-temporally sorted) as columns. The table sould be in Comma Separated Values (CSV) format, with a header (sample IDs) and column names (gene IDs).
1. Open the main script (`INFERENCE.m`) and run it ( <kbd>F5</kbd> ) in Matlab.
1. Use the dialog box to pick up the input file.
1. Inference progress is shown in the command window.
1. The results will be saved in Simple Interaction File (SIF) format with suffix *__AR1MA1_GRN_inference.txt*. The output file includes a header and the next columns: (*i*) Parent node, (*ii*) interaction type ("-|" inhibition and "->" a activation), (*iii*) child node, (*iv*) the interaction weight, (*v*) the posterior probability and (*vi*) a score computed as the product of the posterior probability by the weight (normalized to the maximum). 


# Implementation

The method is implemented in MATLAB, version 8.6 (R2015b). For previous/posterior versions some of the commands might be updated.


# The inference method

The AR1MA1-VBEM method is explained in detail in 4th chapter of my PhD dissertation:

> *Bayesian methods for inferring GRNs and protein profiles from gene expression microarrays data*, 2012, ISBN: [978-84-9028-501-5](http://cul.worldcat.org/oclc/870124049)

An early VBEM approach, based on a *first-order autoregressive* (AR1) model, was published in:

> *A Survey of Statistical Models for Reverse Engineering Gene Regulatory Networks*, 2009, DOI: [10.1109/MSP.2008.930647](http://dx.doi.org/10.1109%2FMSP.2008.930647)


# Example: mESC

A mouse Embryo Stem Cells (mESC) dataset is provided [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/embryo.csv). This data was originally published in:

> *Resolution of cell fate decisions revealed by single-cell gene expression analysis from zygote to blastocyst*, 2010, Developmental Cell, PubMed: [20412781](http://www.ncbi.nlm.nih.gov/pubmed/20412781)

#### Data processing

The data were downloaded from source, processed to select cells within the oocyte-to-epiblast stages and computationally sorted according to a pseudo-time index.

#### Results

The results are provided [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/mESC__AR1MA1_GRN_inference.txt) in SIF format as described above. A representation of the results as network can be found [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/GRN.pdf). The network was drawn with Cytoscape using [this](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/GRN_style.xml) style.
