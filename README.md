# MeCuP

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

## 👋 This is MeCuP

MeCuP = **Me**lting **Cu**rve **P**rofile tool for thermal protein profiling - a tool supporting screening and identifiyning candidates in thermal proteome profiling experiments.
Please visit this [Excel file](./ressources/MeCuP_Arguments_EXPLAINED.csv) as a one stop for instructions on how to use MeCuP, explanations about possible arguments to pass by filling a csv template when using MeCuP.

Please ensure when filling the csv template that there are no changes due to formatting some entries to dates!

MeCuP was developed in a way that it can sit in and is functional in an ARC (Annotated Research Context). The ARC provides a data management solution developed by DataPLANT the NFDI4Plants. For underlying schemata, metadata annotation and making use of many other features and benefits of an ARC, please visit the [DataPLANT website](https://www.nfdi4plants.org/).

## MeCuP v0.2.3
This repository contains the [MeCuP scripts](./workflows/README.md) and a minimalistic directory structure and explanations for all required files from the use of the MeCuP script. Data and an example for the use of MeCuP will be available with the associated submitted manuscript (see citation below in this README).  

It comprises the default settings with low resolution plots for MeCuP when using R with RStudio and the **option "1"** in the respective RStudio prompt. These settings are minimalistic and suggested for routine screening application.  

A higher resolution of plots can be selected for selected proteins subsequently or, if desired, directly when running MeCuP. These are selected for when using **option "2"** in the RStudio prompt. **NOTE:** this roughly doubles the required storage. Also, the time per run increases when using a higher resolution.

The **option "3"** that can be selected in the RStudio prompt is only provided for development. Here the settings have to be provided and are extracted directly from the script.

Plot settings can be customized. Please be aware that this requires some experience. It is strongly recommended to use the pre-set settings.

After screening for candidates with a MeCuP run, users can provide a list of selected proteins for which they need plots in **publication resolution** (300 ppi) e.g. for publication, presentations, reports, etc. This list has to be provided in the first column of a csv file using the protein identifiers exactly as provided in the output of the respective MeCuP screening output run directory corresponding to the first majority protein IDs. An example is provided [here](./assays/MY_ASSAY_NAME/protocols/selectedPROTEINS300ppi.csv).
  
## Ressources
tbc - Please note, MeCuP regularly produces a session file.

## Citation / Linked Manuscript

MeCup was primarily developed by

- Andrea Schrader  
  orcid: "https://orcid.org/0000-0002-3879-7057"  
  while affiliated to:  
  Universität zu Köln  
  Data Science and Management & Cluster of Excellence on Plant Sciences (CEPLAS)  
  University of Cologne, Cologne, Germany  
  
- Björn Heinemann  
  orcid: "https://orcid.org/0000-0002-3962-4174"  
  Universität zu Köln  
  Abteilung Pflanzenstoffwechselbiochemie  
  Institut für Pflanzenwissenschaften  
  Zülpicher Straße 47a  
  D-50674 Köln  

as part of the work resulting in the mansucript:   
"Thermal proteome profiling identifies mitochondrial aminotransferases involved in cysteine degradation via persulfides in plants"  

Björn Heinemann1#, Jannis Moormann1#, Shivsam Bady1#, Cecile Angermann1, Andrea Schrader2, Tatjana M. Hildebrandt1  

1Institute for Plant Sciences, Cluster of Excellence on Plant Sciences (CEPLAS), University of Cologne, Zülpicher Straße 47a, 50674 Cologne, Germany. 
2Data Science and Management, Cluster of Excellence on Plant Sciences (CEPLAS), University of Cologne  

#Shared first authors  

When you use MeCuP, please not only cite this repository but also the mansucript.  
