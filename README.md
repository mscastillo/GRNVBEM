AR1MA1 - VBEM method for reverse engineering GRNs from pseudo-time series data
====


This repository includes the scripts to perform Gene Regulatory Network (GRN) inference from time series or pseudo-time series data using a *first-order autoregressive moving average* (AR1MA1) model within a variational Bayesian Expectation-Maximization (VBEM) framework.


# Quick guide


1. Download/clone this repository.
1. Set up your input data as [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/mESC.csv), with genes as rows and samples (pseudo-temporally sorted) as columns. The table sould be in Comma Separated Values (CSV) format, with a header (sample IDs) and column names (gene or proteins IDs).
1. Open the main script (`INFERENCE.m`) in Matlab and run it ( <kbd>F5</kbd> ).
1. Use the dialog box to pick up the input CSV file.
1. The command window will show the inference progress.
1. The results will be saved in a text file using Simple Interaction File (SIF) extended format, with same filename and suffix *__AR1MA1_GRN_inference.txt*. The output file includes a header and the next columns: (*i*) Parent node, (*ii*) interaction type ("-|" for inhibition and "->" for activation), (*iii*) child node, (*iv*) the interaction weight, (*v*) the posterior probability and (*vi*) a score computed as the product of the posterior probability and the weight (normalized to the maximum value). 


# Implementation


The method is implemented in MATLAB, version 8.6 (R2015b). For previous/posterior versions some of the commands might be updated.


# The inference method


The AR1MA1-VBEM method is explained in detail in the 4th chapter of my PhD thesis:

> *Bayesian methods for the inference of GRNs and protein profiles from gene expression microarrays data*, 2012, ISBN: [978-84-9028-501-5](http://cul.worldcat.org/oclc/870124049)

An early VBEM approach, based on a *first-order autoregressive* (AR1) model, was published in:

> *A Survey of Statistical Models for Reverse Engineering Gene Regulatory Networks*, 2009, DOI: [10.1109/MSP.2008.930647](http://dx.doi.org/10.1109%2FMSP.2008.930647)


# Example: mESC


We analysed single-cell qPCR expression data of 46 genes and 280 samples from mouse zygote to blastocyst as presented in:

> *Resolution of cell fate decisions revealed by single-cell gene expression analysis from zygote to blastocyst*, 2010, Developmental Cell, PubMed: [20412781](http://www.ncbi.nlm.nih.gov/pubmed/20412781)

#### Data processing

Data were downloaded from source, processed to select cells within the oocyte-to-epiblast stages and pseudo-temporal sorted according to the hierarchical optimal-leaf ordering algorithm. The data, already processed and with the required input format, can be found [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/mESC.csv).

#### Results

The results are provided [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/mESC__AR1MA1_GRN_inference.txt) in SIF format as described above. A representation of these results as network can be found [here](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/GRN.pdf). This network was drawn using Cytoscape and [this](https://github.com/mscastillo/GRNVBEM/blob/master/mESC/GRN_style.xml) visual style.
