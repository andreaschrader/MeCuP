This directory contains the three MeCuP script files. 
- For standard purpose, use the **MeCup.R** script along with the csv template, your annotation file and if you like, with your list of identifiers to limit plotting.  
- There is one version (**MeCuP_publication_resolution.R**) with hard encodes suggestions for high resolution plots available. Please note, that this requires adapting the script yourself for your project like providing your assay name etc. You can also use the MeCuP.R script and pass the settings for higher resolutin via the csv template.  
- **MeCuP__functions.R** holds all required functions for the MeCuP scripts.

  ** To be functional, the MeCuP Script needs to be executed in an ARC-like structure with input files located as instructed as provided with this repository.**
  To change it into a full ARC, please visit [DataPLANT](https://www.nfdi4plants.org/) to learn more about ARCs. 

When runnign the MeCuP.R script the rstudioapi will ask you to select one of the following options:
> All arguments are either **hard encoded in this script (3) (only for development)**
> or read from a custom file like **MeCuP_Arguments_INPUT.csv (2)**.
> If the **DEFAULT** values are used, the arguments are read from the **template file in the ressources directory at the root of the ARC / MeCuP directory structure (1)**.
