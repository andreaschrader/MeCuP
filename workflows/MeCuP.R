# Support with TPP script analysis Hildebrandt lab

# 2022-11-28: started support (initially getting the TPP package from Chields at al running with the lab's data)
# 2023-11-09: started MeCuP development
# Continued development after leaving CEPLAS on 2024-03-31

# Script: Andrea Schrader
# Maintainer: Andrea Schrader
# ORCID: 0000-0002-3879-7057
# GitHub: andreaschrader

# All data used during development originates from the Hildebrandt lab at University of Cologne / CEPLAS.
# The data was provided for support with scripts for thermal proteome profiling.

## All files and directories have to be in an ARC or in an ARC-like structure
## The script is currently executed in the 'workflow' directory of the ARC / ARC-like structure.
################################################################################################################################################

################################################################################################################################################

################################################################################
##############################  Source Functions ###############################
################################################################################
source("MeCuP__functions.R")

################################################################################
######################  Packages and Working Directory #########################
################################################################################
## Check requirements, install if required and set the working directory
#### Install and Load all Required Packages
#### Setting the Path
MeCuP__getPackagesAndWd()

################################################################################
###############################  Read Arguments  ###############################
################################################################################
## The following code uses an rstudioapi function

## All arguments are either hard encoded in this script (3) (only for development)
## or read from a custom file like MeCuP_Arguments_INPUT.csv (2). 
## If the DEFAULT values are used, the arguments are read from the template file in the 
## ressources directory at the root of the ARC / MeCuP directory structure (1).
arguments_input <- MeCuP_promptArgumentsOptions(DEFAULT = 1)

## Read the default arguments from template for option 1
if (arguments_input == 1){
  argumentsDF <- MeCuP__readDefaultArguments(arguments_input)
}

################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################

## Read the arguments from a custum file for option 2
if (arguments_input == 2){
  argumentsDF <- MeCuP__readCustomArguments(arguments_input)
}

################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################

## Read the arguments from the script as an input in the following function for option 3
if (arguments_input == 3){

  # Write arguments from the script to a data.frame for documentation using MeCuP_Arguments_INPUT.csv from the resources directory.
  # See default arguments input file in the resources directory for details
  argumentsDF <- MeCuP__createArgumentsDF(TYPE = "MeCuP", # Currently only one type.
                                          ASSAY = "MY_ASSAY_NAME", # Example for an assay name
                                          name_input_file = "proteinGroups_MY_ASSAY_NAME.txt", # Example for an input file name.
                                          name_sample_list_file = "Sample_list_MY_ASSAY_NAME.csv", 
                                          repeats = 3,
                                          ANNO = "MY_ANNOTATION .txt", # Example for an annotation file filename
                                          #selectedPROTEINS = "ALL", # all proteins in the input file are used for filtering and plots
                                          #selectedPROTEINS = c("ATXGXXXX1.X"), # example for only one selected protein being used for filtering and plot
                                          #selectedPROTEINS = c("ATXGXXXX1.X", "ATXGXXXX2.X", "ATXGXXXX3.X", "ATXGXXXX4.X"), # example for multiple proteins being used for filtering and plots
                                          selectedPROTEINS = "list", # list of proteins used for filtering and plots are read from a file
                                          selectedPROTEINSfilename = "selectedPROTEINS300ppi.csv", # Example for a respective filename.
                                          #selectedPROTEINSfilename = "", # Empty string when there is no filename provided.
                                          THRESH_BSA = 0, # minimal BSA value required to include a sample in the analysis
                                          #THRESH_BSA = 200000, # Example for a higher threshold excluding an outlier (needs to be decided and justified by the user if these outliers can and should be excluded!)
                                          THRESH = 0, # minimal value in BSA-normalized samples required to include a protein in the analysis (otherwise set to NA)
                                          SPmean_filtering = TRUE,
                                          #SPmean_filtering = FALSE,
                                          #SPmean_filtering = "both", 
                                          NORM = NA, # lowest temperature used for normalization
                                          # NORM = 30, # example for a temperature
                                          SPmean_THRESH_type = "percent",
                                          #SPmean_THRESH_type = "absolute", 
                                          SPmean_THRESH = 50, # Example for percent
                                          #SPmean_THRESH = 2, # Example for absolute
                                          SPmeanNORM = "Control", # Normalization relative to control start points
                                          #SPmeanNORM = "treat", # Normalization relative to respective treatment start points per treatement (including Control)
                                          #SPmeanNORM = "both", # Normalization relative to Control and extra runs with normalization relative to treatment (see above)
                                          PLOT = "ALL_and_Tm50_NO", # Full png set and melting point shift filtered pngs
                                          #PLOT = TRUE, # Full png set
                                          #PLOT = FALSE, # No pngs
                                          #PLOT = "Tm50_NO", # Only melting point shift filtered pngs
                                          colour_values = c("#56B4E9", "#000000", "#E69F00", "#0072B2", "#F0E442", "#D55E00", "#CC79A7", "#009E73"), # colors for the melting curves in the plots
                                          #sp_mean_filter_effect = TRUE, # Output for easier analysis of filtering effect is added
                                          sp_mean_filter_effect = FALSE, 
                                          XLSX_OUTPUT_LEGEND = TRUE, # TOC and Legend sheets are added to the output xlsx file 
                                          #XLSX_OUTPUT_LEGEND = FALSE,
                                          #plotSetting = "highResolution", 
                                          plotSetting = "lowResolution",
                                          #plotSetting = "customSettings",
                                          #plotSetting = "publicationResolution",
                                          geom_POINT = 1,
                                          LOESS_LINEWIDTH = 0.75,
                                          y_ticks_SPACING = 0.25,
                                          title_SIZE = 9,
                                          title_FACE = "bold",
                                          #title_FACE = "plain", 
                                          #title_FACE = "italic", 
                                          #title_FACE = "bold.italic",
                                          title_COLOR = "blue",
                                          x_axis_TITLE_SIZE = 12, 
                                          y_axis_TITLE_SIZE = 12, 
                                          axis_TEXT_SIZE = 13, 
                                          legend_TITLE_SIZE = 11,
                                          legend_TEXT_SIZE = 10,
                                          png_UNITS = "px",
                                          #png_UNITS = "cm",
                                          #png_UNITS = "mm",
                                          #png_UNITS = "in",
                                          png_WIDTH = 960,
                                          png_HEIGHT = 960,
                                          png_RESOLUTION = 180, # unit is ppi
                                          x_axis_INTERCEPT_LINEWIDTH = 0.5,
                                          x_MeCuP_results_TEXT = 0.8, # The MeCuP-results text is the summarized result shown below the legend e.g. of melting points and the difference of melting points.
                                          y_MeCuP_results_TEXT = 0.265,
                                          MeCuP_results_TEXT_SIZE = 7,
                                          MeCuP_results_TEXT_COLOR = "blue",
                                          annotation_LINEBREAK = 55 # this is the number of letters after which a line break is introduced in the annotation used as the png titles.
                                          )
}

## Extract arguments from input files.
arguments <- MeCuP__extractArgumentsFromInput(arguments_input, argumentsDF)
  
################################################################################
#############################  Save Start Time  ################################
################################################################################

# After the manual input to determine the arguments for the script is completed:
# Save the start time to a list
used_time <- list()
used_time[[(length(used_time) + 1)]] <- Sys.time()

################################################################################
############  Use "Control", "treat" or "both" for normalization  ##############
################################################################################

## SPmeanNORM - PREP
if (arguments$SPmeanNORM == "both"){
  SPmeanLOOP <- c("Control", "treat")
}else{
  SPmeanLOOP <- c(arguments$SPmeanNORM)
}

for (SPmeanLOOP_NORM in SPmeanLOOP){
  
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  source("MeCuP__functions.R")
    
  ################################################################################
  #####################  Tests Arguments / Prepare MeCuP Run  ####################
  ################################################################################ 
  #Pattern:
  ## Parameter - TEST
  ## Parameter - PREP
  
  ## TYPE - TEST
  if (!arguments$TYPE %in% c("MeCuP")) {
    stop("You did not select one of the following types: 'MeCuP'. Please provide a TYPE.")
  }else{
    print(paste0("Script type: '", arguments$TYPE, "'"))
  }
  
  ## name_input_file - TEST
  if (file.exists(paste0("../assays/", arguments$ASSAY, "/dataset/", arguments$name_input_file))) {
    print(paste0("Input data: '", arguments$name_input_file, "'"))
  } else {
    stop(print(paste0("The input data './assays/", arguments$ASSAY, "/dataset/", arguments$name_input_file, "' does not exist.\nThe input file MUST be located in the assays directory of the ARC with this script in its sub-direcoty with the name '", arguments$ASSAY, "' and, in there, inside the sub-directory datasets.")))
  }
  
  ## name_sample_list_file - TEST
  ### Check if the sample list is there, otherwise: error.
  if (file.exists(paste0("../assays/", arguments$ASSAY, "/protocols/", arguments$name_sample_list_file))) {
    print(paste0("Sample list: '", arguments$name_sample_list_file, "'"))
  } else {
    stop(print(paste0("The sample list './assays/", arguments$ASSAY, "/protocols/", arguments$name_sample_list_file, "' does not exist.\nThe sample list MUST be located in the assays directory of the ARC with this script in its sub-direcoty with the name '", arguments$ASSAY, "' and, in there, inside the sub-directory protocols.")))
  }
  
  ### Check if the file format of the sample list is csv, otherwise error.
  if (!(substr(arguments$name_sample_list_file, nchar(arguments$name_sample_list_file) - 3, nchar(arguments$name_sample_list_file)) %in% c(".csv", ".CSV"))) {
    stop("The file format of the sample list is not csv. \nExpected: The file is a csv file and the file name ends with '.csv' or '.CSV'. \nSeparator: ',' \nDecimal: '.'")
  }else{
    message("Sample list file - expected:\nFile format: 'csv'\nSeparator: ',' or ';' \nDecimal: '.'")
  }
  
  ## ANNO - TEST
  if (file.exists(paste0("../resources/", arguments$ANNO))) {
    print(paste0("Anotation file: '", arguments$ANNO, "'"))
  } else {
    stop(print(paste0("The annotation file './resources/", arguments$ANNO, "' does not exist.\nThe annotation file MUST be located in a directory named 'resources' in the root of the ARC with this script.")))
  }
  
  ## selectedPROTEINS - TEST & PREP
  if (arguments$selectedPROTEINS == "list"){
    selectedPROTEINS_FILE <- arguments$selectedPROTEINSfilename
  } else {
    selectedPROTEINS_FILE <- ""
  }
  
  selectedPROTEINS <- arguments$selectedPROTEINS
  
  if (unique(arguments$selectedPROTEINS == "list")){
    if (!(exists("selectedPROTEINS_FILE"))) {
      stop("You selected 'lists' for selectedPROTEINS. In this case, providing the selectedPROTEINSfilename is mandatory. Please provide a 'csv' file in a 'resources' directory in the root of an ARC.")
    }else{
      if (!(file.exists(paste0("../assays/", arguments$ASSAY, "/protocols/", arguments$selectedPROTEINSfilename)))) {
        stop(paste0("The file with the filename ", arguments$selectedPROTEINSfilename, "is not located in a directory named 'protocols' in the assay directory of the ARC."))
      }else{
        if (!(grepl(".csv", arguments$selectedPROTEINSfilename))) {
          stop("The file you provided for the selectedPROTEINS list is not a csv file or does not have a '.csv' ending.\nPlease provide a file in '.csv' format (comma separated) with the protein identifiers as used in the input file in the first column without header.")
        }else{
          selectedPROTEINS <- read.csv(paste0("../assays/", arguments$ASSAY, "/protocols/", arguments$selectedPROTEINSfilename), sep=",", header = FALSE)[,1]
        }
      }
    }
  }
  
  ## NORM - PREP
  
  ## SPmean_THRESH_type & SPmean_THRESH - TEST
  ### Only check when SPmean_filtering is selected:
  if ((arguments$SPmean_filtering == TRUE) | (arguments$SPmean_filtering == "both")) {
    if (arguments$SPmean_THRESH_type == "absolute" & as.numeric(arguments$SPmean_THRESH) <= 1) {
      stop("You selected less than 2 samples being sufficient for the normalization samples. This is not supported by this script. You have to select at least 2 normalization temperature samples (SPmean_THRESH > 2 for SPmean_THRESH_type = 'absolute').")
    }
    if (arguments$SPmean_THRESH_type == "percent") {
      if ((as.numeric(arguments$SPmean_THRESH) >= 100) | (as.numeric(arguments$SPmean_THRESH) <= 0)) {
        stop("The percentage of chosen SPmean_Thresh percentage for normalization is below or equal to zero or above or equal to 100. Please adjust accordingly.")
      }
    }
  }
  
  ## More tests below as these need the sample list.
  
  ################################################################################
  ##########################  Print Selected Arguments  ##########################
  ################################################################################ 
  
  print(paste0("TYPE: ", arguments$TYPE)) 
  print(paste0("name_input_file: ", arguments$name_input_file)) 
  print(paste0("name_sample_list_file: ", arguments$name_sample_list_file)) 
  print(paste0("repeats: ", as.numeric(arguments$repeats))) 
  print(paste0("Annotation file: ", arguments$ANNO))
  print(paste0("selectedPROTEINS: ", paste(selectedPROTEINS, collapse = ', ')))
  print(paste0("THRESH_BSA: ", as.numeric(arguments$THRESH_BSA)))
  print(paste0("THRESH: ", as.numeric(arguments$THRESH)))
  print(paste0("SPmean_filtering: ", arguments$SPmean_filtering)) 
  print(paste0("NORM: '", arguments$NORM, "'", "\n", "If NORM is not NA, the datapoints at the NORM temperature are used for normalization and all results for lower temperatures are deleted."))
  print(paste0("SPmean_THRESH_type: ", arguments$SPmean_THRESH_type)) 
  print(paste0("SPmean_THRESH: ", as.numeric(arguments$SPmean_THRESH))) 
  print(paste0("SPmeanNORM: ", arguments$SPmeanNORM)) 
  print(paste0("PLOT: ", arguments$PLOT)) 
  print(paste0("colour_values: ", arguments$colour_values)) 
  print(paste0("sp_mean_filter_effect: ", arguments$sp_mean_filter_effect)) 
  print(paste0("XLSX_OUTPUT_LEGEND: ", arguments$XLSX_OUTPUT_LEGEND)) 

  ################################################################################
  #########################  Setting the input PATHs  ############################
  ################################################################################
  
  # Construct the ARC input path
  inputPATH = paste0("../assays/", arguments$ASSAY)
  
  ################################################################################
  ##########################  Reading in the input ###############################
  ################################################################################
  
  # (1) Reading in Output data from MQ processing
  print("\nReading in the input file.\n\n")
  MQin <- read.csv(paste0(inputPATH, "/dataset/", arguments$name_input_file), dec=".", sep="\t")
  
  # (2) Reading in the sample list
  print("Reading in the sample list.\n\n")
  Sam <- read.csv(paste0(inputPATH, "/protocols/", arguments$name_sample_list_file), dec=".", sep=",")
  
  if (dim(Sam)[2] == 1) {
    Sam <- read.csv(paste0(inputPATH, "/protocols/", arguments$name_sample_list_file), dec=".", sep=";")
  }
  
  if (!(class(Sam[,"Sample"])%in%c("integer", "numeric"))) {
    # As a "-" in the colnames in the input file is change to a ".", this is changed here as well for the sample list used within the script.
    Sam$Sample <- gsub("-", ".", Sam$Sample)
    # Although not allowed, the user might use empty spaces in the sample name. These are also replaced with "." when reading in the input file. Therefore, we do the same for the sample names here.
    # Please note, if the user adds an empty space at the end or begin of a sample name which was not there in the sample name as used by MaxQuant, these names will not match and cause errors of this script!
    Sam$Sample <- gsub(" ", ".", Sam$Sample)
  } 
  
  # Sort the sample list for Treatment and Temperature (alphanumerical)
  Sam <- Sam[with(Sam, order(Temperature, Treatment)), ]
  rownames(Sam) <- NULL
  
  ## SPmean_THRESH_type & SPmean_THRESH - TEST
  # Could not be done earlier as it needs the sample list
  if (is.na(arguments$NORM)){
    normTEMP <- min(Sam$Temperature)
  }else{
    normTEMP <- as.numeric(arguments$NORM)
  }
  
  if ((arguments$SPmean_filtering == TRUE) | (arguments$SPmean_filtering == "both")) {
    if ((arguments$SPmean_THRESH_type == "absolute") & (as.numeric(arguments$SPmean_THRESH) > max(as.vector((Sam[Sam$Temperature == normTEMP,] %>% count(Treatment, sort = TRUE)))[[2]]))) {
      stop("You selected more or the maximum of samples per temperature-treatment combination. You have to select less than the maximum sample number per temperature-treatment combination.")
    }
    if (arguments$SPmean_THRESH_type == "percent") {
      if (min(as.vector((Sam[Sam$Temperature == normTEMP,] %>% count(Treatment, sort = TRUE)))[[2]]) * (as.numeric(arguments$SPmean_THRESH)/100) <= 1) {
        stop("You selected less than 2 samples being sufficient for the normalization samples. This is not supported by this script. You have to select a percentage leaving at least 2 normalization temperature samples (SPmean_THRESH_type = 'percent', The minimal accepted SPmean_THRESH value depends on the minimal number of samples available for each treatment at the respective temperature.).")
      }
    }
  }
  
  # (3) Reading in the annotation file
  print("Reading in the annotation file.")
  Anno <- read.csv(paste0("../resources/", arguments$ANNO), dec=".", sep="\t")
  message("The protein identifier used in the input file has to be in the first column of the annotation file.\nThe annotation (e.g. protein name or functional characterization) has to be in the second columns.\n")
  
  # Removing duplicates if present  
  if (dim(Anno)[1] != dim(unique(Anno))[1]){
    message(paste0("The annotation file contains duplicated rows. ", dim(Anno)[1] - dim(unique(Anno))[1]," duplicated rows are removed.\n"))
    Anno <- unique(Anno)
  }
  
  if (length(Anno[,1]) != length(unique(Anno[,1]))){
    stop(paste0("There are multiple annotations per protein provided for ", length(Anno[,1]) - length(unique(Anno[,1])), " proteins in the annotation file. Either select the correct one or merge, in case all are applicable befor the script can proceed!\n"))
  }
  
  ################################################################################
  ########  Integrating the sample list with data and test requirements ##########
  ################################################################################
  
  # 1) Sample IDs
  ## 1) Extract iBAQ colnames
  ## 2) Test if the colname extraction worked properly with respect to the number of sample IDs
  ## 3) Check if all iBAQ colnames start with the provided sample names
  ## 4) Add the iBAQ names to the sample list.
  
  ## 1) Extract iBAQ colnames
  iBAQ_sample_colnames <- colnames(MQin)[grep("iBAQ", colnames(MQin))]
  iBAQ_sample_colnames <- iBAQ_sample_colnames[-grep("iBAQ.peptides", iBAQ_sample_colnames)]
  iBAQ_sample_colnames <- iBAQ_sample_colnames[grep("iBAQ.", iBAQ_sample_colnames)]
  iBAQ_sample_colnames <- as.data.frame(iBAQ_sample_colnames)
  
  ## 2) Test if the colname extraction worked properly with respect to the number of sample IDs.
  print(paste0("There are ", length(colnames(MQin)), " colnames in the MQ file"))
  print(paste0("There are ", length(iBAQ_sample_colnames[,1]) ," columns containing 'iBAQ' sample labels."))
  print(paste0("The number of iBAQ_IDs (", length(iBAQ_sample_colnames[,1]), ") should be equal to the sample number provided in the Sample_list which is: ", length(Sam[,1]), ". This is ", length(iBAQ_sample_colnames[,1])==length(Sam[,1])))
  
  # Stop the script if this did not work properly according to the test above
  if (!(length(iBAQ_sample_colnames[,1])==length(Sam[,1]))) {
    stop("Number of iBAQ_IDs is not equal to the sample number from the provided sample list. Aligning input data and sample list samples did not work. Please check labels and colnames in the provided input file.")
  }
  
  ## 3) Check if all iBAQ colnames start with the provided sample names.
  # If not, throw an error.
  iBAQ_sample_colnames_check <- gsub("iBAQ.", "", iBAQ_sample_colnames[,1])
  iBAQ_sample_colnames_check <- sort(iBAQ_sample_colnames_check)
  
  Sam_Check <- Sam$Sample
  Sam_Check <- sort(Sam_Check)
  
  if (class(Sam[,"Sample"])%in%c("integer", "numeric")) {
    for (i in c(1:length(Sam_Check))) {
      i=1
      iBAQ_sample_colnames_check_mod <- iBAQ_sample_colnames_check
      if (!(startsWith(iBAQ_sample_colnames_check[i], "0"))) {
        iBAQ_sample_colnames_check_mod[i] <- sub("^0", "", iBAQ_sample_colnames_check[i]) # remove leading zero
        if ((!(startsWith(iBAQ_sample_colnames_check[i], Sam_Check[i]))) & (!(startsWith(iBAQ_sample_colnames_check_mod[i], Sam_Check[i])))) {
          stop("The provided sample names are not identical with those used in the iBAQ colnames.")
        }
      }  
    }
  }else{
    for (i in c(1:length(Sam_Check))) {
      if (!(startsWith(iBAQ_sample_colnames_check[i], Sam_Check[i]))){
        stop("The provided sample names are not identical with those used in the iBAQ colnames.")
      }
    }
  }

  ## 4) Add the iBAQ names to the sample list.
  Sam <- Sam[with(Sam, order(Sample)), ]
  iBAQ_sample_colnames[,1] <- iBAQ_sample_colnames[with(iBAQ_sample_colnames, order(iBAQ_sample_colnames)),1]
  Sam$iBAQ_sample_colnames <- iBAQ_sample_colnames[,1]
  Sam <- Sam[with(Sam, order(Temperature, Treatment)), ]
  rownames(Sam) <- NULL

  ###################################################################
  #### Now select the columns needed for further pre-processing: ####
  ###################################################################
  
  # Select one protein identifier representing the result for one peptide/protein
  ## Protein ID: "Majority.protein.IDs"
  
  # Columns used to derive quality information required for the TPP script
  ## Quality_qssm: "Peptides"
  ## Quality_qupm: "Unique peptides"
  
  # Results - amounts of proteins detected and identified
  ## iBAQ columns: Sam$iBAQ_sample_colnames
  
  # Protein / result classes selected for removal (with a "+" in the following columns:)
  ## "Only.identified.by.site"
  ## "Reverse"
  ## "Potential.contaminant"
  
  Xtract <- c("Majority.protein.IDs",  "Peptides", "Unique.peptides", Sam$iBAQ_sample_colnames, "Only.identified.by.site", "Reverse", "Potential.contaminant")
  if ((unique(Xtract %in% colnames(MQin)) == TRUE) & length(unique(Xtract %in% colnames(MQin))) == 1) {
    MQin_Xtract <- MQin[,Xtract]
  }
  
  ###########################################################################################
  # Identify and rename BSA to protect it from removal (remove "+" from respective columns: #
  ###########################################################################################

  ### Identify the reference substance (BSA) in each table (CON_P02769) and change the identifier to "BSA"
  MQin_Xtract[] <- lapply(MQin_Xtract, function(x) gsub("CON__P02769;gi162648", "BSA", x))
  MQin_Xtract[] <- lapply(MQin_Xtract, function(x) gsub("gi162648;CON__P02769", "BSA", x))
  
  ### Remove "+" from the three columns for BSA identifying proteins that will be excluded from the analysis (reverse, contaminants and)
  MQin_Xtract[MQin_Xtract$Majority.protein.IDs == "BSA",c("Only.identified.by.site", "Reverse", "Potential.contaminant")] <- c("", "", "")
  
  ###########################################################################################
  ################### Select representative ID for each detected protein ####################
  ###########################################################################################
  
  ### Protein IDs used for the TPP script.
  
  ### There are several cases in which there are multiple protein.IDs which remain in the Majority.protein.IDs column.
  ### In other cases, there is a reduction but not always to only one Majority.protein.ID. 
  ### Therefore, another selection step for a unique ID used for subsequent steps is required.
  ### These "representing IDs" should be stored with the multiple other IDs in a First.Majority.protein.ID column.
  ### Likely, these proteins or their detected peptides are very similar or identical or the product of the open reading frame is even identical.
  ### Here, just the first AGI code encoding the proteins in this row after a first selection step by MQ is kept as the "representative ID". 
  
  ### We keep the Majority.protein.IDs column and select a representative ID for the TPP script input data.
  MQin_Xtract$First.Majority.protein.ID <- as.vector(unlist((lapply(MQin_Xtract$Majority.protein.IDs, function(x) as.vector(str_split(x, ";")[[1]][1])))))
  
  # For documentation
  input_proteins <- MQin_Xtract$First.Majority.protein.ID
  
  # If the first majority protein IDs are not unique, provide an error message.
  if (length(MQin_Xtract$First.Majority.protein.ID) != length(unique(MQin_Xtract$First.Majority.protein.ID))) {
    stop("The majority protein IDs are not unique") 
  }
  
  if ("ALL" %in% selectedPROTEINS) {
    selPROT <- input_proteins
  }else{
    selPROT <- selectedPROTEINS
  }
  
  notSelectedPROTs <- MQin_Xtract[(!(MQin_Xtract$First.Majority.protein.ID %in% selPROT)),]$First.Majority.protein.ID
  
  ##########################
  ### Add the annotation ###
  ##########################
  
  Anno_merge <- Anno
  
  # Change "NV" to "NA" (German to English abbreviation)
  Anno_merge[,2] <- unlist(lapply(Anno_merge[,2], function(x) gsub("NV", "NA", x)))
  
  # Replace empty spaces with "_"
  Anno_merge[,2] <- gsub(" ", "_", Anno_merge[,2])
  
  # After annotation_LINEBREAK (e.g. 55) characters, add a line break and, add a column with the information of lines derived for the respective plot and widen the margin respectively
  
  ## Calculate how many times the string in the annotation column can be divided e.g. by annotation_LINEBREAK (e.g. 55)
  Anno_merge$plot_title_lines <- unlist(lapply(Anno_merge[,2], function(x) nchar(x) / as.numeric(arguments$annotation_LINEBREAK)))
  
  ## For all multiples of the annotation_LINEBREAK (e.g. 55) keep the calculation result but add 1 to the floor calculation of all others
  Anno_merge[Anno_merge$plot_title_lines %% 1 != 0, ]$plot_title_lines <- unlist(lapply(Anno_merge[Anno_merge$plot_title_lines %% 1 != 0, ]$plot_title_lines, function(x) as.integer(x) + 1))
  
  ## Insert the line brake after each annotation_LINEBREAK (e.g. 55) characters as long as there are more than annotation_LINEBREAK (e.g. 55) characters remaining until the end of the last sub_string
  for (j in c(1: dim(Anno_merge)[1])) {
    
    x <- Anno_merge[j,]
    new_string = ""
    for (i in c(1:x$plot_title_lines)) {
      if (i == 1) {
        new_string <- substring(x[,2], ((i-1)*as.numeric(arguments$annotation_LINEBREAK) +1), (((i-1)+1)*as.numeric(arguments$annotation_LINEBREAK)))
      }
      if (i > 1) {
        new_string <- paste0(new_string, "\n", substring(x[,2], ((i-1)*as.numeric(arguments$annotation_LINEBREAK) +1), (((i-1)+1)*as.numeric(arguments$annotation_LINEBREAK))))
      }
    }
    x[,2] <- new_string
    Anno_merge[j,] <- x
  }
  
  # Adjust colnames to those of MQin_Xtract
  colnames(Anno_merge)[1] <- "First.Majority.protein.ID"
  
  # Give a standard colname for the annotation column to be used in this script
  colnames(Anno_merge)[2] <- "Annotation"
  
  # Only keep those annotations which are also in MQin_Xtract
  Anno_merge <- Anno_merge[Anno_merge$First.Majority.protein.ID %in% MQin_Xtract$First.Majority.protein.ID,]
  
  # Merge the annotations (Anno_merge) and MQin_Xtract
  MQin_Xtract <- merge(MQin_Xtract, Anno_merge , all=T, by="First.Majority.protein.ID")
  
  ##########################################################################################################
  ####################### Remove samples with BSA below the user selected threshold ########################
  ##########################################################################################################
  
  # First filter:
  # 1) Remove all samples without BSA
  # 2) Document which samples were excluded.

  # 1) Remove all samples with BSA <= THRESH_BSA
  delete_samples = c()
  
  # Before removing, store sample colnames and BSA raw values for a documentation plot when the resultPaths are set
  BSA_plotTable <- t(rbind(unique(c(Sam$iBAQ_sample_colnames)), MQin_Xtract[MQin_Xtract$First.Majority.protein.ID == "BSA", unique(c(Sam$iBAQ_sample_colnames))]))
  
  for (i in c(which(colnames(MQin_Xtract) %in% Sam$iBAQ_sample_colnames))) {
    if (as.numeric(MQin_Xtract[(MQin_Xtract$First.Majority.protein.ID == "BSA"),i]) <= as.numeric(arguments$THRESH_BSA)) {
      delete_samples = cbind(delete_samples, colnames(MQin_Xtract)[i])
    } 
  }
  
  # If there are samples to be deleted:
  ## Keep an MQin_Xtract version for documentation before deleting samples with BSA below the BSA threshold
  MQin_Xtract_docu <- MQin_Xtract[,c("First.Majority.protein.ID", "Majority.protein.IDs", "Annotation", as.vector(delete_samples))]
  
  # Remove samples without BSA as these can not be normalized
  MQin_Xtract <- MQin_Xtract[,!(colnames(MQin_Xtract) %in% delete_samples)]
  
  # 2) Document in which samples BSA was not detected and therefore, which were excluded.
  
  # add column to sample list no BSA yes/no
  if (length(delete_samples)!= 0) {
    
    lowBSA <- as.vector(delete_samples)
    Sam$BSA <- c(NA)
    Sam[Sam$iBAQ_sample_colnames %in% lowBSA,]$BSA <- "below threshold - excluded"
    Sam[!Sam$iBAQ_sample_colnames %in% lowBSA,]$BSA <- "yes"
    print(paste("There is/are", length(delete_samples), "sample/s in which BSA is/was not detected"))
    print("Such samples are excluded and, therefore, not considered in downstream analysis.")
    print(paste("This/These is/are the sample/s:", as.vector(delete_samples)))
    
  }else{
    
    Sam$BSA <- c("yes")
    print(paste("BSA was detected in all samples."))
    
  }
  
  ## Store the sample list and write later in loop
  Sam_docu <- Sam
  
  ## Remove samples without BSA from the sample list!
  Sam <- Sam[Sam$BSA == "yes",]
  rownames(Sam) <- NULL
  
  ## In case of removing one sample, the BSA column is no longer complete and removed.
  Sam <- Sam[,!(colnames(Sam) %in% "BSA")]

  ###########################################################################################
  ####### Remove proteins of selected result classes and those that were not selected #######
  ###########################################################################################
  # Remove all proteins identified as contamination, reverse, marked as "Only identified by site" or with a name starting with "gi" by MQ
  # Create an output table including the removed proteins, the respective reason for exclusion and the not normalized iBAQ values (extract by colnames).
  # Add proteins that were not selected in case the selected proteins arguments is not "ALL"
  
  # Prepare a data.frame for documenting excluded proteins with the MeCuP_exclude_prot function if it does not already exist
  if (!exists("MeCuP__Excluded_Proteins")) {
    MeCuP__Excluded_Proteins_names <- c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", "Reason4Exclusion", Sam$iBAQ_sample_colnames)
    MeCuP__Excluded_Proteins <- data.frame(matrix(nrow=0, ncol=length(MeCuP__Excluded_Proteins_names)))
    colnames(MeCuP__Excluded_Proteins) <- MeCuP__Excluded_Proteins_names
  }
  
  # Document reasons for exclusion: "name starts with 'gi'"/"Potential.contaminant"/"Reverse":
  MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = "name_starts_with_gi", SELECTION = grep("^gi", MQin_Xtract$Majority.protein.IDs), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
  MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = "Potential.contaminant", SELECTION = (MQin_Xtract[,"Potential.contaminant"] == "+"), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
  MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = "Reverse", SELECTION = (MQin_Xtract[,"Reverse"] == "+"), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
  MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = "Only.identified.by.site", SELECTION = (MQin_Xtract[,"Only.identified.by.site"] == "+"), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
  
  # Remove proteins as identified by the reasons for exclusion
  if (length(MQin_Xtract[grep("^gi", MQin_Xtract$Majority.protein.IDs),1]) != 0) {
    MQin_Xtract <- MQin_Xtract[-grep("^gi", MQin_Xtract$Majority.protein.IDs),]
  }
  MQin_Xtract <- MQin_Xtract[!(MQin_Xtract[,"Potential.contaminant"] == "+"),]
  MQin_Xtract <- MQin_Xtract[!(MQin_Xtract[,"Reverse"] == "+"),]
  MQin_Xtract <- MQin_Xtract[!(MQin_Xtract[,"Only.identified.by.site"] == "+"),]
  
  # Remove columns used for this selection as these are now not needed any more:
  MQin_Xtract <- MQin_Xtract[, !colnames(MQin_Xtract) %in% c("Potential.contaminant", "Reverse", "Only.identified.by.site")]
  
  if (length(notSelectedPROTs) != 0){
    MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = "not_selected", SELECTION = (!(MQin_Xtract$First.Majority.protein.ID %in% selPROT)), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
  }
  
  MQin_Xtract <- MQin_Xtract[MQin_Xtract$First.Majority.protein.ID %in% c(selPROT, "BSA"), ]

  ##########################################################################################################
  ### Normalize with BSA and extract coverage of protein detection per treatment-temperature combination ###
  ##########################################################################################################
  
  # 4) Document the coverage. this can be used to remove all proteins with detection in less than x replicates or repetitions (according to a user selection).

  # 4) Document the coverage. this can be used to remove all proteins with detection in less than x replicates or repetitions (according to a user selection).
  # Here, only extract for each sample and protein in how many samples this protein was detected and save this as a table.
  # Reason: At the end of the melting curve, it is expected that proteins are not detected and the end of the melting curve is reached at different temperatures for different proteins.
  # Therefore, this information can be used later for specific relevant temperatures which are later identified as non-endpoints of the respective's protein's melting curve.
  # Based on a threshold, proteins can be excluded which have only a coverage of 1 or 2 samples (currently the maximum number is 3),
  # in which the protein is detected for such relevant non-end-point temperatures.
  
  # Identify the number of samples with BSA in which a protein was detected above the selected threshold per treatment-temperature combination
  unique_factors <- unique(Sam[,c("Treatment", "Temperature")])
  rownames(unique_factors) <- NULL
  
  for (i in c(1:length(unique_factors[,1]))) {

    my_factors <- Sam[which((Sam$Treatment==unique_factors$Treatment[i]) & 
                              (Sam$Temperature == unique_factors$Temperature[i])),
                      "iBAQ_sample_colnames"]
    
    MQin_Xtract[,paste0(unique_factors[i,1], "_", unique_factors[i,2], "_Detect")] <- apply(MQin_Xtract[, my_factors], 1, function(x) sum(x > as.numeric(arguments$THRESH)))
  }
  
  MeCuP__Coverage <- MQin_Xtract[,!colnames(MQin_Xtract) %in% c(Sam$iBAQ_sample_colnames)]
  MeCuP__Coverage <- MeCuP__Coverage[,!(colnames(MeCuP__Coverage) %in% c("plot_title_lines"))]
  
  ################################################################################
  ##########################  SPmean filtering loop  #############################
  ################################################################################
  
  MQIN_XTRACT <- MQin_Xtract
  MECUP__EXCLUDED_PROTEINS <- MeCuP__Excluded_Proteins
  SAM <- Sam

  if (arguments$SPmean_filtering=="both") {
    SPmean_filtering_steps <- c(1,2)
    
  }
  
  if (arguments$SPmean_filtering==TRUE) {
    SPmean_filtering_steps <- c(2)
  }
  
  if (arguments$SPmean_filtering==FALSE) {
    SPmean_filtering_steps <- c(1)
  }
  
  # Starting the loop for all three SPmean_filtering options
  for (SPmeanfilter in SPmean_filtering_steps) {
    
    used_time[[(length(used_time) + 1)]] <- Sys.time()
    
    setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
    source("MeCuP__functions.R")
    
    MQin_Xtract <- MQIN_XTRACT
    MeCuP__Excluded_Proteins <- MECUP__EXCLUDED_PROTEINS
    Sam <- SAM
    #selPROT <- selectedPROTEINS
    
    #SPmeanfilter <- 1
    
    if (SPmeanfilter == 1) {
      SPmean_filter <- FALSE
    }else{
      SPmean_filter <- TRUE
    }
  
    ################################################################################
    ###  Setting the result PATH for the SPmean_filtering selection / iteration  ###
    ################################################################################
    
    # Construct the (ARC) output path
    # Get the name of the script
    SCRIPT <- gsub(".R", "",tail(unlist(strsplit(rstudioapi::getActiveDocumentContext()$path, split='/', fixed=TRUE)),1))
    
    # Use the name of the script and input assay as the output directory's name
    if (is.na(arguments$NORM)) {
      resultPath1 = paste0("../runs/", SCRIPT, "__", arguments$ASSAY, "__", SPmeanLOOP_NORM)
    } else {
      resultPath1 = paste0("../runs/", SCRIPT, "__", arguments$ASSAY, "__", as.numeric(arguments$NORM), "__", SPmeanLOOP_NORM)
    }
    
    # Create the path name based on the selected filtering option
    if (SPmean_filter) {
      resultPath1 = paste0(resultPath1, "__Filtered/")
    } else {
      resultPath1 = paste0(resultPath1, "__noFiltering/")
    }
    
    # Delete previous output if it exists.
    if (arguments$SPmean_filtering == "both" & SPmeanfilter == 1) {
      if (file.exists(paste0(resultPath1))) {
        unlink(paste0(resultPath1), recursive = TRUE)
      }
      if (file.exists(paste0(resultPath1))) {
        unlink(paste0(resultPath1), recursive = TRUE)
      }
    }
    
    # For the two other options (not "both") for filtering
    if (file.exists(resultPath1)) {
      unlink(resultPath1, recursive = TRUE)
    }
    
    # Create sub-directories for MeCuP output and info files
    resultPath2 <- paste0(resultPath1, "output/")
    resultPath3 <- paste0(resultPath1, "output_detailed/")
    resultPath4 <- paste0(resultPath1, "info/")
    dir.create(resultPath2, showWarnings = FALSE, recursive = TRUE)
    dir.create(resultPath3, showWarnings = FALSE, recursive = TRUE)
    
    ################################################################################
    #############################  Create Info File ################################
    ################################################################################
    
    # Open an empty info file for documentation
    dir.create(resultPath4, showWarnings = FALSE, recursive = TRUE)
    write.table("", paste0(resultPath4, "mecup_info.txt"))
    info.file <- file(paste0(resultPath4, "mecup_info.txt"),"w")
    
    # Write first information in the info file
    cat("MeCuP Script - Info File\n\nScript: Andrea Schrader\nORCID: 0000-0002-3879-7057\nGitHub: andreaschrader\n\nAll data originates from the Hildebrandt lab at University of Cologne / CEPLAS.\nThe data was provided for support with scripts for thermal proteome profiling.\n", file=info.file, append = T)
    
    ################################################################################
    ############  Write files and plots with equal output ± filtering ##############
    ################################################################################
    
    # Write MeCuP__Selected_Arguments.txt used for this MeCuP run
    write.table(argumentsDF, paste0(resultPath3, "MeCuP__Selected_Arguments.txt"), sep="\t", row.names = FALSE)
    write.table(argumentsDF, paste0(resultPath3, "MeCuP__Selected_Arguments.csv"), row.names = FALSE)
    
    # Write MeCuP__Input_Proteins_Script.txt of the proteins used for this MeCuP run (selected proteins)
    write.table(selPROT, paste0(resultPath3, "MeCuP__Input_Proteins_Script.txt"), sep="\t", col.names = FALSE)
    write.table(selPROT, paste0(resultPath3, "MeCuP__Input_Proteins_Script.csv"), col.names = FALSE)
    
    # Write MeCuP__Sample_List_BSA.txt including information of BSA detected in the samples
    write.table(Sam_docu, paste0(resultPath3, "MeCuP__Sample_List_BSA.txt"), sep="\t", row.names=FALSE)
    write.csv(Sam_docu, paste0(resultPath3, "MeCuP__Sample_List_BSA.csv"), row.names=FALSE)
    
    ## Write MeCuP__Excluded_Samples.txt with the excluded samples
    write.table(MQin_Xtract_docu, paste0(resultPath3, "MeCuP__Excluded_Samples.txt"), sep="\t", row.names=FALSE)
    write.csv(MQin_Xtract_docu, paste0(resultPath3, "MeCuP__Excluded_Samples.csv"), row.names=FALSE)
    
    # Write MeCuP__Coverage.txt
    write.table(MeCuP__Coverage, paste0(resultPath3, "MeCuP__Coverage.txt"), sep="\t", row.names=FALSE)
    write.csv(MeCuP__Coverage, paste0(resultPath3, "MeCuP__Coverage.csv"), row.names=FALSE)
    
    # Get numbers about reasons for exclusion before SPmean filtering and plot as a venn diagram (following this page: https://r-graph-gallery.com/14-venn-diagramm)
    set1 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == "name_starts_with_gi",]$First.Majority.protein.ID
    set2 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == "Potential.contaminant",]$First.Majority.protein.ID
    set3 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == "Reverse",]$First.Majority.protein.ID
    set4 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == "Only.identified.by.site",]$First.Majority.protein.ID
    
    # Prepare a palette of 4 colors with R colorbrewer:
    myCol <- brewer.pal(4, "Pastel2")
    
    # Chart
    venn.diagram(
      x = list(set1, set2, set3, set4),
      category.names = c("name_starts_with_gi" , "Only.identified.by.site" , "Potential.contaminant", "Reverse"),
      filename = paste0(resultPath3, "MeCuP__Reason4Exclusion_MQ_VENN.png"),
      disable.logging = TRUE,
      output=TRUE,
      
      # Output features
      imagetype="png" ,
      height = 480 , 
      width = 480 , 
      resolution = 300,
      compression = "lzw",
      
      # Circles
      lwd = 2,
      lty = 'blank',
      fill = myCol,
      
      # Numbers
      cex = .6,
      fontface = "bold",
      fontfamily = "sans",
      
      # Set names
      cat.cex = 0.3,
      cat.fontface = "bold",
      cat.default.pos = "outer",
      cat.fontfamily = "sans",
      cat.pos = c(0, 60, 120, 150),
      cat.just = list(c(0.4,3.9) , c(1.6,-4.9) , c(-0.8,0) , c(3.7,-5.8)) # Might need adjustment or order of sets in venn needs to be fixed
    )
    
    # Plot non-normalized BSA input values
    
    # MeCuP__BSAraw plot.png
    png(paste0(resultPath3, "MeCuP__BSAraw plot.png"), width = (29 * length(BSA_plotTable[,1])), height = 638, type = "cairo")
    
    par(mar = c((max(nchar(BSA_plotTable[,1])) / 2), 4.1, 4.1, 4.1), # change the margins
        lwd = 2 # increase the line thickness
    )
    
    plot(BSA_plotTable[,2], 
         pch = 21, 
         col = "blue", 
         bg = "blue", 
         xaxt="n",
         xlab = "", 
         ylab= "",
         cex.main = 2,
         main = "BSA raw amount - MaxQuant derived input data",
         ylim = c(0,((max(as.numeric(BSA_plotTable[,2])) + (max( as.numeric(BSA_plotTable[,2]) ) * 0.01) )))
         )
    abline(h = 0, lty = 2, col = "red")
    mtext(text="MaxQuant input value for BSA", side =2, line = 2.5, cex = 1.5)
    axis(side = 1, at = c(1:(length(BSA_plotTable[,1]))), labels = c(BSA_plotTable[,1]), srt=90, las=2)
    dev.off()
    
    ################################################################################
    #########################  SPmean filtering steps  #############################
    ################################################################################
    
    # Create the list of treatments used for normalization.
    # This list either only comprise "Control" or all treatments depending on the choice of the argument SPmeanNORM.
    
    if (SPmeanLOOP_NORM == "Control"){
      TREAT_NORM <- c("Control")
    }
    if (SPmeanLOOP_NORM == "treat"){
      TREAT_NORM <- c(unique(Sam$Treatment))
    }

    # For SPmean_filtering action
    # 4) Exclude proteins based on coverage only in the samples used for normalization.
    # 5) Document the excluded proteins.
    # 6) Set normalization samples which have a value below or of the threshold (which includes zero) to NA in order to subsequently adjust the SP means.
    # 7) Document which samples were set to NA in step 6. (adjusted samples)
    
    # After SPmean filtering
    # 8) Normalize with BSA.
    
    if (SPmean_filter == TRUE) {
      
      # 4) Use the coverage to exclude proteins with a coverage < SPmean_THRESH at the lowest temperature used for normalization
      
      if (arguments$NORM %in% c(NA)) {
        Temp_min = min(Sam$Temperature)
      }else{
        Temp_min = as.numeric(arguments$NORM)
      }
    
      # In order to print the number of removed proteins, the current number of proteins is stored in the variable dim_before
      dim_before <- dim(MQin_Xtract)[1]
      
      # The number of samples used for the cut off is either provided as an absolute number
      # Or is derived as a percentage from the maximal number of repeats according to the sample list. 
      if (arguments$SPmean_THRESH_type == "absolute") {
        SPm_THRESH <- as.numeric(arguments$SPmean_THRESH)
      }
      
      if (arguments$SPmean_THRESH_type == "percent") {
        SPm_THRESH <- max(count(Sam_docu, Treatment, Temperature)$n) * (as.numeric(arguments$SPmean_THRESH)/100)
      }
      
      # A) Identify all proteins with low coverage in the starting point samples (used for normalization)
      # Starting point samples are defined by the NORM (here stored in Temp_min) and SPmeanNORM (here reflected by TREAT_NORM) argument selection)

      # Add a printed warning if for treat-temp combinations after BSA exclusion or provided as input the coverage is already below the selected threshold.

      if (length(Sam[count(Sam, Treatment, Temperature)$n < SPm_THRESH,1]) > 0) {
        print("The following samples have already a coverage below the selected threshold of exclusion either in the input already or after BSA sample exclusion:")
        print(Sam[count(Sam, Treatment, Temperature)$n < SPm_THRESH,])
        print(paste0("If, among these, there are samples at the temperature used for normalization ( ", Temp_min, " ), these are deleted and, therfore, the whole treatment can not be analyzed."))
      }
      
      # Now the coverage is checked per proteins and proteins need to be excluded if their respective coverage is below the selected threshold at the normalization temperature.
      for (TREAT in TREAT_NORM) {
        MQin_Xtract[paste0(TREAT, "_", Temp_min, "_low_coverage")] <- c(MQin_Xtract[paste0(TREAT, "_", Temp_min, "_Detect")] < SPm_THRESH)
      }
      
      # B) In case SPmeanNORM is "treat", it is tested if the coverage is below the threshold 
      # for all treatment normalization sample groups which means that the whole protein can be excluded.
      
      if (SPmeanLOOP_NORM == "treat") {
        # Get a list of treatments without "Control"
        ONLY_TREAT <- TREAT_NORM[!(TREAT_NORM %in% c("Control"))]
        
        # Get a column stating if for all treatments (except Control) the coverage is low.
        if ((length(ONLY_TREAT) > 1) & (length(ONLY_TREAT) != 0)) {
          MQin_Xtract[,paste0("allTreat_", Temp_min, "_low_coverage")] <- apply(MQin_Xtract[ ,paste0(ONLY_TREAT, "_", Temp_min, "_low_coverage")], 1, function(x) c(!(c("FALSE") %in% x))) 
        }else{
          MQin_Xtract[,paste0("allTreat_", Temp_min, "_low_coverage")] <- MQin_Xtract[ ,paste0(ONLY_TREAT, "_", Temp_min, "_low_coverage")] 
        }
        
        # Use these columns for documentation using the EXCLUDE function and pass the columns as a condition. For "treat", it is only needed to state "treat_treat" and "treat_Control" in the Reason4Exclusion.
        MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_treat"), SELECTION = (MQin_Xtract[,(paste0("allTreat_", Temp_min, "_low_coverage"))]), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
        # For "Control"
        MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_Control"), SELECTION = (MQin_Xtract[,(paste0("Control_", Temp_min, "_low_coverage"))]), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
  
        # Delete all proteins with TRUE in the low_coverage column for all treatments (without the Control).
        MQin_Xtract <- MQin_Xtract[!MQin_Xtract[,paste0("allTreat_", Temp_min, "_low_coverage")],]
        
        # As we compare the melting temperature to the controle. 
        # If the normalization samples for the control samples have to be excluded for a protein, 
        # this protein can not be analyzed any more with MeCuP and has to be excluded here.
        # Delete all proteins with TRUE in the low_coverage column for Control.
        MQin_Xtract <- MQin_Xtract[!MQin_Xtract[,paste0("Control_", Temp_min, "_low_coverage")],] 
      
      # C) If only for one out of multiple treatments this is true, all values at the starting point are set to NA for this treatment.
      # By this, also, all subsequent calculations like mean and SD and all normalized samples as well are NA for these samples.
      # Thereby the protein remains in the analysis for the other treatments but this treatment is not considered and plotted for this protein.
        if ((length(ONLY_TREAT) > 1) & (length(ONLY_TREAT) != 0)) {
          MQin_Xtract[,paste0("allTreat_", Temp_min, "_mixed_coverage")] <- apply(MQin_Xtract[ ,paste0(ONLY_TREAT, "_", Temp_min, "_low_coverage")], 1, function(x) c((c("TRUE") %in% x) & (c("FALSE") %in% x))) 
          
          for (TREAT in ONLY_TREAT) {
            my_columns <- Sam[which((Sam$Treatment==TREAT) & (Sam$Temperature == Temp_min)), "iBAQ_sample_colnames"]
            MQin_Xtract[MQin_Xtract[c("TRUE") %in% MQin_Xtract[,(paste0("allTreat_", Temp_min, "_mixed_coverage"))],paste0(TREAT, "_", Temp_min, "_low_coverage")], my_columns] <- rep(NA, count(Sam, Treatment, Temperature)[((count(Sam, Treatment, Temperature)$Treatment == TREAT) & (count(Sam, Treatment, Temperature)$Temperature == Temp_min)),]$n)
          }
        }
      
        # Add a Venn on excluded proteins
        # Get numbers about SPmean_filtering low coverage exclusion as a reason for exclusion per treatment and plot as a venn diagram 
        set1 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_Control"),]$First.Majority.protein.ID
        set2 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_treat"),]$First.Majority.protein.ID
        
        # Only plot if not Null for at least one of the sets:
        
        if (length(set1) > 0 | length(set2) > 0) {

        # Prepare a palette of 2 colors with R colorbrewer:
        myCol <- brewer.pal(3, "Pastel2")
        myCol <- myCol[1:2]
        
        # Define a conditional rotation in case set2 > set1 to maintain the labels as they are.
        if (length(set2) > length(set1)) {
          conditionalRotation <- 180
        }else{
          conditionalRotation <- 0
        }
        
        # Chart
        venn.diagram(
          x = list(set1, set2),
          category.names = c(paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_Control"), paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_treat")),
          filename = paste0(resultPath3, "MeCuP__Reason4Exclusion_SPmean_Filtering_VENN.png"),
          disable.logging = TRUE,
          output=TRUE,
          
          # Output features
          imagetype="png" ,
          height = 480 , 
          width = 480 , 
          resolution = 300,
          compression = "lzw",
          
          # Circles
          lwd = 2,
          lty = 'blank',
          fill = myCol,
          
          # Numbers
          cex = .6,
          fontface = "bold",
          fontfamily = "sans",
          
          # Set names
          cat.cex = 0.3,
          cat.fontface = "bold",
          cat.default.pos = "outer",
          cat.fontfamily = "sans",
          cat.pos = c(90, 180),
          cat.just = list(c(0,-19), c(0.1,39)),
          rotation.degree = conditionalRotation
          )
        }
      }
      
      # For "Control"
      # D) For SPmeanNORM == "Control" the exclusion can be done directly based on the coverage column for "Control".
      if (SPmeanLOOP_NORM == "Control") {
        MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = paste0("SPmean_filtering_", SPmeanLOOP_NORM, "_Control"), SELECTION = MQin_Xtract[,(paste0("Control_", Temp_min, "_low_coverage"))], MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
        MQin_Xtract <- MQin_Xtract[!MQin_Xtract[,paste0("Control_", Temp_min, "_low_coverage")],] 
      }
      
      print(paste0((dim_before - dim(MQin_Xtract)[1]), " proteins are excluded from the analysis as they are only detected in less of the samples used for normalization than the number of samples determined by the threshold."))
      print(paste0(dim(MQin_Xtract)[1], " proteins are remaining."))
      
      # 5) Document which proteins are excluded from the analysis based on coverage of the normalization sample(s). -> Already done in the MeCuP_exclude_prot function.
      # 6) Set normalization samples to NA if these are smaller or equal to the threshold for proteins in order to not be considered for the calculation of the respective mean subsequently.
      # 7) Document for which proteins at least one sample is set to NA in a normalization sample(s). (adjusted)

      adjustedSP <- data.frame(matrix(nrow=0, ncol=dim(MQin_Xtract)[2]))
      colnames(adjustedSP) <- colnames(MQin_Xtract)
      
      for (TREAT in TREAT_NORM) {
    
        norm_samples <- Sam[(Sam$Temperature == Temp_min) & (Sam$Treatment == TREAT),]$iBAQ_sample_colnames
        
        for (COLUMN in norm_samples) {
          MQin_Xtract[MQin_Xtract[, COLUMN] <= as.numeric(arguments$THRESH), COLUMN] <- NA
          adjustedSP <- rbind(adjustedSP, MQin_Xtract[MQin_Xtract[, COLUMN] %in% c(NA),])
        }
      }
      
      # Make sure that the list of adjusted proteins is unique and if no protein was adjusted that it is set to NA for downstream steps
      if (length(unique(adjustedSP$First.Majority.protein.ID) > 0)){
        
        adjusted_proteins <- unique(adjustedSP$First.Majority.protein.ID)
        
      }else{
        adjusted_proteins <- NA
      }
      
      # Print information on the number of adjusted proteins.
      print(paste0(dim(adjustedSP)[1], " proteins are adjusted and the respective normalization samples is set to 'NA' as it is smaller or equal to the threshold."))
      
      # Write list of  proteins for which at least one sample is set to NA in a normalization sample(s).
      write.table(adjustedSP, paste0(resultPath3, "MeCuP__SPmean_filtering_adjusted.txt"), sep="\t", row.names=FALSE)
      
    }else{
      
      # Make sure that the list of adjusted proteins is set to NA for downstream steps if no SPmean_filtering is applied
      adjusted_proteins <- NA
    }
    
    ################################################################################
    #############################  BSA normalization ###############################
    ################################################################################
    
    # 8) Normalize with BSA
    for (i in c(which(colnames(MQin_Xtract) %in% Sam$iBAQ_sample_colnames))) {
      MQin_Xtract[,paste0(colnames(MQin_Xtract)[i], "_BSA")] <- as.numeric(MQin_Xtract[,i])/as.numeric(MQin_Xtract[MQin_Xtract$First.Majority.protein.ID == "BSA",i])
    }
    
    ###########################################################################################
    ################################## SP mean normalization ##################################
    ###########################################################################################

    
    # Relative protein amount to the control sample at the lowest temperature:
    # 1) Set NORM to the lowest or lowest selected temperature
    # 2) Remove all samples with lower temperature if the selected temperature is not the lowest temperature in the input file.
    
    # In SPmean_filtering loop
    # 3) Calculate the mean per treatment-temperature combination
    # 4) Set all treatment-temperature combinations' means relative to the control samples' mean at the lowest temperature.
    
    # 1) Set NORM to the lowest or lowest selected temperature
    # Extract the iBAQ colname for the lowest temperature from the merged sample list
    # Determine the temperature for normalizing which is the lowest temperature with which samples were treated.
    Temp_min <- min(Sam$Temperature)
    
    if (is.na(arguments$NORM)) {
      NORM <- Temp_min
    }
    
    # 2) Remove all samples with lower temperature if the selected temperature is not the lowest temperature in the input file.
    # If NORM > Temp_min, delete all temperatures below NORM and test if the new Temp_min is the user selected NORM
    if(NORM>Temp_min) {
      for (TEMP in c(unique(Sam[Sam$Temperature < NORM,]$Temperature))) {
        Sam <- Sam[!Sam$Temperature==TEMP,]
      }
      Temp_min <- min(Sam$Temperature)
    }
    
    # Relative protein amount to the control sample at the lowest temperature:
    
    # 3) Calculate the mean and STDEV per treatment-temperature combination
    ### 1) Extract all treatment - temperature combinations after possible removal of low temperatures above.
    unique_factors <- unique(Sam[,c("Treatment", "Temperature")])
    rownames(unique_factors) <- NULL
    
    ### 2) Extract per treatment-temperature combination all iBAQ colnames and
    for (i in c(1:length(unique_factors[,1]))) {
      my_factors <- paste0(Sam[which((Sam$Treatment==unique_factors$Treatment[i]) & 
                              (Sam$Temperature == unique_factors$Temperature[i])), "iBAQ_sample_colnames"], "_BSA")
    ### 3) Calculate the mean
      MQin_Xtract[,paste0(unique_factors[i,1], "_", unique_factors[i,2], "_BSA_Mean")] <- apply(MQin_Xtract[, my_factors], 1, function(x) mean(x, na.rm = TRUE))
    }
    
    for (i in c(1:length(unique_factors[,1]))) {
      my_factors <- paste0(Sam[which((Sam$Treatment==unique_factors$Treatment[i]) & 
                                       (Sam$Temperature == unique_factors$Temperature[i])), "iBAQ_sample_colnames"], "_BSA")
    ### 4) Calculate the STDEV
      MQin_Xtract[,paste0(unique_factors[i,1], "_", unique_factors[i,2], "_BSA_SD")] <- apply(MQin_Xtract[, my_factors], 1, function(x) sd(x, na.rm=TRUE))
    }
    
    MeCuP__Stat <- MQin_Xtract[,!colnames(MQin_Xtract) %in% c(Sam$iBAQ_sample_colnames)]
    
    # Save these results as MeCuP__Stat.txt
    write.table(MeCuP__Stat, paste0(resultPath3, "MeCuP__Stat.txt"), sep="\t", row.names=FALSE)
    
    # 4) Set all treatment-temperature combinations' means and BSA-normalized individual samples relative to the control samples' mean at the lowest temperature.
    ### 1) Test for start points which are at or below the threshold (including zero) and exclude these proteins from the calculation.
    ### 2) Document for which proteins in which sample the starting point is at or below the threshold (including zero) and the protein was excluded.
    ### 3) Set all treatment-temperature combinations' means relative to the control samples' mean at the lowest temperature.
    ### 4) Calculate starting-point normalized STDEV.
    ### 5) Set all BSA-normalized individual samples relative to the control samples' mean at the lowest temperature.
    ### 6) Save results as MeCuP__Stat_SP_Norm.txt.
    
    ### 1) Test for start points which are smaller or equal to the threshold and exclude these proteins from the calculation.
    ### 2) Document for which proteins in which sample the starting point is at or below the threshold (including zero) and the protein was excluded.
    
    ###    Should only be needed when the filtering for SP samples above is deactivated.
    ###    Needed to avoid division by zero.
    
    # In order to print the number of removed proteins, the current number of proteins is stored in the variable dim_before
    dim_before <- dim(MQin_Xtract)[1]
    
    # For SPmean = "control": Remove all proteins for which in the control at the normalization temperature (NORM), there was no protein detected.
    # For SPmean = "treat": Only if for all treatments no protein was detected!
    # Therefore, set first to NA, than check if NA for all treatments, plot only if not NA at lowest temperature.
    
    # A) Set all BSA means to NA that have a value of or below the threshold (including zero)
    # B) For each treatment (including the "Control"), add a column to MQin_Xtract stating if the respective BSA mean for a protein is NA with a bool.
    # C) For all treatments (excluding the "Control"), add a column to MQin_Xtract stating if the BSA means is NA for all treatment (not for the control) with a bool.
    # D) Use these columns for documentation using the EXCLUDE function and pass the columns as a condition. For "treat", it is only needed to state "treat_treat" and "treat_control" in the Reason4Exclusion.
    # E) Delete all proteins with a TRUE in the "Control" column first and than repeat the same for the "all_treat" column.
    # F) Add a Venn for documentation.
    
    # First check if there is any value at or below the threshold (including zero)
    thresh_list <- c()
    
    for (TREAT in TREAT_NORM) {
      # A) Set all means of BSA normalized values to NA that have a value smaller or equal to the selected threshold (default THRESH = 0).
      thresh_list <- c(thresh_list, length(MQin_Xtract[(MQin_Xtract[,paste0(TREAT, "_", NORM, "_BSA_Mean")] <= as.numeric(arguments$THRESH)), paste0(TREAT, "_", NORM, "_BSA_Mean")]))
    }
    
    # The following removal of zero values or values at or below the threshold is only required if there is any protein with a BSA-normalized mean below or at the value of the threshold (default: THRESH = 0) for the relevant normalizing sample.
    if (max(thresh_list) > 0) {
      
      for (TREAT in TREAT_NORM) {
        # A) Set all means of BSA normalized values to NA that have a value at or below the threshold (including zero).
        MQin_Xtract[(MQin_Xtract[,paste0(TREAT, "_", NORM, "_BSA_Mean")] <= as.numeric(arguments$THRESH)), paste0(TREAT, "_", NORM, "_BSA_Mean")] <- NA
      }
      
      for (TREAT in TREAT_NORM) {    
        # B) For each treatment (including the "Control"), add a column to MQin_Xtract stating if the respective BSA mean for a protein is NA with a bool.
        MQin_Xtract[,paste0("isNA4", TREAT,"SPmean")] <- is.na(MQin_Xtract[,paste0(TREAT, "_", NORM, "_BSA_Mean")])
      }
      
      # For "treat", not for "Control" (see below)
      if (SPmeanLOOP_NORM == "treat") {
        # C) For all treatments (excluding the "Control"), add a column to MQin_Xtract stating if the BSA means is NA for all treatment (not for the control) with a bool.
        # Create a TREAT_NORM version without "Control"  
        ONLY_TREAT <- TREAT_NORM[!(TREAT_NORM %in% c("Control"))]
        
        if ((length(ONLY_TREAT) > 1) & (length(ONLY_TREAT) != 0)) {
          MQin_Xtract[,"isNA4treatSPmean"] <- apply(MQin_Xtract[ ,paste0("isNA4", c(ONLY_TREAT), "SPmean")], 1, function(x) c(!(c("FALSE") %in% x)))
        }else{
          MQin_Xtract[,"isNA4treatSPmean"] <- MQin_Xtract[ ,paste0("isNA4", c(ONLY_TREAT), "SPmean")]
        }
        
        # D) Use these columns for documentation using the EXCLUDE function and pass the columns as a condition. For "treat", it is only needed to state "treat_treat" and "treat_Control" in the Reason4Exclusion.
        MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_treat_threshMeanDivision"), SELECTION = (MQin_Xtract[,paste0("isNA4treatSPmean")]), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
        # For "Control"
        MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_Control_threshMeanDivision"), SELECTION = (MQin_Xtract[,paste0("isNA4ControlSPmean")]), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
        
        # E) Delete all proteins with a TRUE in the "treat" column.
        MQin_Xtract <- MQin_Xtract[!MQin_Xtract[,"isNA4treatSPmean"],] 
        # For "Control"
        MQin_Xtract <- MQin_Xtract[!MQin_Xtract[,"isNA4ControlSPmean"],]   
        
        # F) Add a venn.
        # Get numbers about zero-division protection (at or below the threshold (including zero)) as a reason for exclusion per treatment and plot as a venn diagram 
        set1 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_Control_threshMeanDivision"),]$First.Majority.protein.ID
        set2 <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$Reason4Exclusion == paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_treat_threshMeanDivision"),]$First.Majority.protein.ID
        
        # Prepare a palette of 2 colors with R colorbrewer:
        myCol <- brewer.pal(3, "Pastel2")
        myCol <- myCol[1:2]
        
        # Define a conditional rotation in case set2 > set1 to maintain the labels as they are.
        if (length(set2) > length(set1)) {
          conditionalRotation <- 180
        }else{
          conditionalRotation <- 0
        }
        
        # Chart
        venn.diagram(
          x = list(set1, set2),
          category.names = c(paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_Control_threshMeanDivision") , paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_", "treat_threshMeanDivision")),
          filename = paste0(resultPath3, "MeCuP__Reason4Exclusion_threshDivision_VENN.png"),
          disable.logging = TRUE,
          output=TRUE,
          
          # Output features
          imagetype="png" ,
          height = 480 , 
          width = 480 , 
          resolution = 300,
          compression = "lzw",
          
          # Circles
          lwd = 2,
          lty = 'blank',
          fill = myCol,
  
          # Numbers
          cex = .6,
          fontface = "bold",
          fontfamily = "sans",
          
          # Set names
          cat.cex = 0.3,
          cat.fontface = "bold",
          cat.default.pos = "outer",
          cat.fontfamily = "sans",
          cat.pos = c(90, 180),
          cat.just = list(c(1.075,-18) , c(0.45,0)), # Might need adjustment or order of sets in venn needs to be fixed
          rotation.degree = conditionalRotation
          )
      }
      
      if (SPmeanLOOP_NORM == "Control"){
        # For "Control"
        # D) Document for "Control" the proteins that will be excluded
        MeCuP__Excluded_Proteins <- MeCuP_exclude_prot(REASON = paste0("SPmeanNORM_", SPmeanLOOP_NORM, "_Control_threshMeanDivision"), SELECTION = (MQin_Xtract[,paste0("isNA4ControlSPmean")]), MQ_DF = MQin_Xtract, COLUMNS = c("Majority.protein.IDs","First.Majority.protein.ID", "Annotation", Sam$iBAQ_sample_colnames), EXCLUDE_DF = MeCuP__Excluded_Proteins)
        
        # E) Delete all proteins with a TRUE in the "Control" column.
        MQin_Xtract <- MQin_Xtract[!MQin_Xtract[,"isNA4ControlSPmean"],]    
      }
    }
    
    print(paste0(dim_before - dim(MQin_Xtract)[1], " proteins were excluded in this step checking for BSA normalized means if these are smaller or equal to the threshold. \n This should only have an effect when there is no SPmean_filtering and avoids a division by zero.\nIt is possible that for multiple treatments one mean is set to NA here while others are not. In this case the protein was not excluded as it can be analyzed for this one treatment. However, this might need to be considered downstream especially if new code is added."))
    
    ### 3) Set all treatment-temperature combinations' means relative to the normalization samples' mean at the lowest temperature. If this is NA, set all values for this protein for this treatment also to NA.
    
    for (TREAT in TREAT_NORM) {
      
      unique_factors <- unique(Sam[,c("Treatment", "Temperature")])
    
      if (SPmeanLOOP_NORM == "treat"){
        unique_factors <- unique_factors[unique_factors$Treatment == TREAT,]
      }
    
      SP_Norm <- MQin_Xtract[,c("First.Majority.protein.ID",paste0(TREAT, "_", NORM, "_BSA_Mean"))]
    
      for (i in c(1:length(unique_factors[,1]))) {
      
        next_col <- paste0(unique_factors$Treatment[i], "_", unique_factors$Temperature[i], "_BSA_Mean")
        new_col <-  paste0(next_col, "_SP_Norm_", TREAT)
        MQin_Xtract[,new_col] <- NA
          
        MQin_Xtract[,new_col] <- MQin_Xtract[,next_col] / SP_Norm[, paste0(TREAT, "_", NORM, "_BSA_Mean")]
      
      }
    
    }
    
    ### 4) Calculate starting-point normalized STDEV.
    
    for (TREAT in TREAT_NORM) {
      
      unique_factors <- unique(Sam[,c("Treatment", "Temperature")])
    
      if (SPmeanLOOP_NORM == "treat"){
        unique_factors <- unique_factors[unique_factors$Treatment == TREAT,]
      }
    
      SP_Norm <- MQin_Xtract[,c("First.Majority.protein.ID",paste0(TREAT, "_", NORM, "_BSA_Mean"))]
      
      for (i in c(1:length(unique_factors[,1]))) {
      
        next_col <- paste0(unique_factors$Treatment[i], "_", unique_factors$Temperature[i], "_BSA_SD")
        new_col <-  paste0(next_col, "_SP_Norm_", TREAT)
        MQin_Xtract[,new_col] <- NA
      
        MQin_Xtract[,new_col] <- MQin_Xtract[,next_col] / SP_Norm[, paste0(TREAT, "_", NORM, "_BSA_Mean")]
      }
    }
    
    ### 5) Set all BSA-normalized individual samples relative to the control samples' mean at the lowest temperature.
    
    for (TREAT in TREAT_NORM) {
      
      unique_factors <- unique(Sam[,c("Treatment", "Temperature")])
      
      if (SPmeanLOOP_NORM == "treat"){
        unique_factors <- unique_factors[unique_factors$Treatment == TREAT,]
      }
      
      SP_Norm <- MQin_Xtract[,c("First.Majority.protein.ID",paste0(TREAT, "_", NORM, "_BSA_Mean"))]
      
      for (i in c(1:length(unique_factors[,1]))) {
    
        ### Extract the individual sample's colnames from the sample list for the currently selected treatment-temperature combination
        my_factors <- paste0(Sam[which((Sam$Treatment==unique_factors$Treatment[i]) & 
                                         (Sam$Temperature == unique_factors$Temperature[i])), "iBAQ_sample_colnames"], "_BSA")
          
        ### Set relative to the starting point of the control used for normalization
    
        # Create colnames for the new columns to be added to the existing dataframe MQin_Xtract
        # Important! The two underscores are used for extraction of a minimal plotting dataframe!
        new_cols <- c(paste0(my_factors, "__", unique_factors[i,1], "_", unique_factors[i,2], "_SP_Norm_", TREAT))
          
        # Adding new columns to add the normalized values to the MQin_Xtract dataframe
        MQin_Xtract[,new_cols] <- NA
        
        for (protein_ID in MQin_Xtract$First.Majority.protein.ID) {
        # normalizing all values for protein_ID in the current treatment-temperature combination
          MQin_Xtract[(MQin_Xtract$First.Majority.protein.ID == protein_ID),new_cols] <- t(apply(MQin_Xtract[(MQin_Xtract$First.Majority.protein.ID == protein_ID), my_factors], 1, function(x) x / SP_Norm[(SP_Norm$First.Majority.protein.ID == protein_ID), paste0(TREAT, "_", NORM, "_BSA_Mean")]))[1,]
        }
      }
    }
    
    ### 6) Save results as MeCuP__MQin_Xtract_BSA_SP_Norm.txt
    write.table(MQin_Xtract, paste0(resultPath3, "MeCuP__MQin_Xtract_BSA_SP_Norm.txt"), sep="\t", row.names=FALSE)

    ###########################################################################################
    ######################### MeCuP - Melting Curve Plots and Data ############################
    ###########################################################################################
    
    # Optional: data could also be read in here from a file and the following can be stored as 
    # a function / as the next module of the pipeline.
    df <- MQin_Xtract
    
    # Select only the normalized individual sample
    df <- df[, c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", colnames(df[,grepl("__" , names(df))]))]
    
    # Simplify colnames, remove MaxQuant colname contribution. Not an ideal solution but 1,2,3 could also suggest that these are clean replicates
    colnames(df) <- gsub(".*__", "", colnames(df))
    
    # vector of all unique temperatures in the sample list
    Temp = unique(Sam$Temperature)
    Treat = unique(Sam$Treatment)
    
    mecup_list <- list()
    
    # To iterate through proteins, prepare selPROT.
    # selPROT can also be a sub-list of df[,"First.Majority.protein.ID"] upon filtering
    
    if ("ALL" %in% arguments$selectedPROTEINS) {
      selPROT <- df[,"First.Majority.protein.ID"]
    }else{
      selPROT <- selectedPROTEINS[selectedPROTEINS %in% df[,"First.Majority.protein.ID"]]
    }
    
    ## Save the input protein list as MeCuP__Input_Proteins_Plot.txt and use it for the following loop per protein
    write.table(selPROT, paste0(resultPath3, "MeCuP__Input_Proteins_Plot.txt"), sep="\t", col.names = FALSE)
    
    # LOESS fit
    
    for (i in c(1:length(selPROT))) {
    #i=1
    
    # Only extract data per protein
    PROT <- selPROT[i]
    df_prot <- df[df$First.Majority.protein.ID == PROT,]
    
      # An empty list to collect all created plotting data.frames per treatment type
      plot_list = list()
      plot_input = data.frame(matrix(nrow = 0, ncol = 3))
      colnames(plot_input) <- c("Temperature", "Normalized_Soluble_Fraction", "Treatment")
      
      for (j in c(1:length(Treat))) {
        # j = 2
        # Iterate through treatments and create one plotting data.frame per treatment
        treat = Treat[j]
        df_treat <- df_prot[,grepl(paste0(treat, "_"), names(df_prot))]
        
        # For each treatment, iterate through all temperatures and build a data.frame with increasing temperatures.
        plot_df = data.frame()
        plot_df = data.frame(cbind(Temp[1], df_treat[grepl(Temp[1] , names(df_treat))]))
        names(plot_df) <- c("Temperature", rep(treat, each = length(df_treat[grepl(Temp[1] , names(df_treat))])))
        
        for (k in c(2:length(Temp))) {
          #k=2
          new_row <- cbind(Temp[k], df_treat[grepl(Temp[k] , names(df_treat))])
          names(new_row) <- c("Temperature", rep(treat, each = length(df_treat[grepl(Temp[k] , names(df_treat))])))
          
          plot_df <- suppressMessages(bind_rows(plot_df, new_row))
        }
        
        # Iteratively creating a list of plotting data.frames per treatment.
        plot_list$treat <- plot_df
        names(plot_list) <- gsub("treat", treat, names(plot_list))
        
        
        # Prepare and combine input data for plot function per protein
        plot_input_treat <- data.frame(matrix(nrow = 0, ncol = 3))
        colnames(plot_input_treat) <- c("Temperature", "Normalized_Soluble_Fraction", "Treatment")
        
        for (l in c(2 : (as.numeric(arguments$repeats) + 1))){
          #l=4
          plot_input_treat_next <- plot_list[treat][[1]][,c(1,l)]
          plot_input_treat_next <- cbind(plot_input_treat_next, replicate(dim(plot_input_treat_next)[1],treat))
          
          colnames(plot_input_treat_next) <- c("Temperature", "Normalized_Soluble_Fraction", "Treatment")
          plot_input_treat <- rbind(plot_input_treat, plot_input_treat_next)
        }
      
        plot_input <- rbind(plot_input, plot_input_treat)
      }
      
      # Preparing a warning if less than 3 samples were provided for any of the 
      # treatment - temperature combinations to avoid misinterpretation of individually used plots.
      N3_count <- count(Sam_docu, Treatment, Temperature)
      N3 <- length(N3_count[N3_count$n < 3,1])
      N3x <- (min(as.numeric(Sam$Temperature), na.rm = TRUE) + ((max(as.numeric(Sam$Temperature), na.rm = TRUE) - min(as.numeric(Sam$Temperature), na.rm = TRUE)) * (3/4)))
      N3y <- (max(as.numeric(plot_input$Normalized_Soluble_Fraction), na.rm = TRUE)) - 0.1
      
      if (N3 > 0) {
        LABEL <- paste0("Warning: MeCuP input N < 3 for\n", N3, " treat.-temp. combinations.\nConclusions on significance\nof the grey area might be impaired!")
      } else {
        LABEL <- ""
      }
      
      ## First run can be done with low resolution, selected proteins can be plotted with high resolution e.g. for publication.

      # Create the basic plot - text, MeCuP results and lines highlighting the melting points will be added later in a second step when plots are saved.
      p <-
        ggplot(data = plot_input, mapping = aes(x = Temperature, y = Normalized_Soluble_Fraction, color = Treatment) ) + 
        geom_point(size = as.numeric(arguments$geom_POINT)) + 
        geom_smooth(se = TRUE, na.rm = FALSE, linewidth = as.numeric(arguments$LOESS_LINEWIDTH)) +
        labs(
          x = "Temperature [°C]",
          y = "Normalized Soluble Fraction",
          title = paste0(PROT, " - ", df_prot[df_prot$First.Majority.protein.ID == PROT,]$Annotation)) +
        # create a series with distance 0.25 including 0.0 and starting just below the lowest value and ending just above the highest value.
        theme_bw() +
        theme(plot.title=element_text(size=as.numeric(arguments$title_SIZE), face = arguments$title_FACE, color = arguments$title_COLOR),
              axis.title.x=element_text(size=as.numeric(arguments$x_axis_TITLE_SIZE)),
              axis.title.y=element_text(size=as.numeric(arguments$y_axis_TITLE_SIZE)),
              legend.title=element_text(size=as.numeric(arguments$legend_TITLE_SIZE)),
              legend.text=element_text(size=as.numeric(arguments$legend_TEXT_SIZE)),
              axis.text=element_text(size=as.numeric(arguments$axis_TEXT_SIZE))) +
        scale_y_continuous(breaks=seq(-100, 1000, by = as.numeric(arguments$y_ticks_SPACING))) +
        scale_colour_manual(values=arguments$colour_values) +
        annotate("text", x = N3x, y = N3y, col = "red", size = 3, label = LABEL)
      
      # export the LOESS fit result and other plot data
      LOESS_plot_data <- ggplot_build(p)
      
      LOESS <- LOESS_plot_data["data"][[1]][[2]]

      # Tm50
      ### Add option if y=0.5 is not in one or all LOESS curves for a protein (set results to NA etc.)
      # In order to walk along the melting curve, extract only values for one treatment
      # How to identify which group is which treatment?
      # Currently the unique treatment values are extracted and sorted, colors are assigned in this order, here along the three color vector which needs to be extended when there are more samples.
      treatment <- sort(unique(plot_input$Treatment))
      group <- c(1:length(treatment))
      label_translate <- as.data.frame(cbind(group, treatment))
      label_translate$group <- as.numeric(label_translate$group)
      
      # Add a treatment column to LOESS
      LOESS <- merge(LOESS, label_translate , all=T, by='group')
      
      # Add column with an identifier (row numbers)
      LOESS$LOESS_data_ID <- rownames(LOESS)
      
      # Extracting the temperature for y=50 and the respective 95% corridor of the LOESS fit is now done per treatment.
      # Extraction is done for y, as well as ymax and ymin. All are merged in the end to one dataframe.
      # Thereby, the quality of the shift can be characterized by the overlap of the two individual fits within an experiment.
      
      mecup_temp50 <- function (PROT, LOESS, Y){
        #Y <- "ymax"
        # subtract 0.5 from the selected y values (y, ymin or ymax)
        LOESS[paste0(Y, "_diff_0_5")] <- LOESS[Y] - 0.5
        
        # Prepare mecup_Tm50 data.frame
        mecup_Tm50 <- data.frame(matrix(nrow=0, ncol=12))
        colnames(mecup_Tm50) <- c("First.Majority.protein.ID", "group", "treatment", "colour", "X_Tm50_A", "Y_Tm50_A", "X_Tm50_B", "Y_Tm50_B", "X_m_Tm50", "X_b_Tm50", "X_Tm50", "X_Tm50_present")
        
        # Now proceed per treatment
        for (i in c(1:length(treatment))) {
          #i=2
          LOESS_treat <- LOESS[LOESS$treatment==treatment[i],]
        
          # Prepare an empty data.frame to collect the extracted rows from LOSS
          mecup_Tm50_treat <- data.frame(matrix(nrow=0, ncol=dim(LOESS)[2]))
          colnames(mecup_Tm50_treat) <- colnames(LOESS)
        
          # Extract per treatment the one to two rows framing the Y=0.5 value while the curve has a negative slope or theoretically might reached a saddle point
          # Extraction is only done when Y=0.5 is reached for the first time with increasing temperature.
          # The respective row or rows are added to the prepared empty data.frame above.
          for (j in c(1:(dim(LOESS_treat)[1]-1))){
          
            if (dim(mecup_Tm50_treat)[1] == 0) {
            
              if ((LOESS_treat[j,paste0(Y, "_diff_0_5")] == 0) & (LOESS_treat[c(j+1),paste0(Y, "_diff_0_5")] < 0)) {
                mecup_Tm50_treat <- rbind(mecup_Tm50_treat, LOESS_treat[j,])
              }
            
              if ((LOESS_treat[j,paste0(Y, "_diff_0_5")] > 0) & (LOESS_treat[c(j+1),paste0(Y, "_diff_0_5")] == 0)) {
                mecup_Tm50_treat <- rbind(mecup_Tm50_treat, LOESS_treat[(j+1),])
              }
            
              if ((LOESS_treat[j,paste0(Y, "_diff_0_5")] == 0) & (LOESS_treat[c(j+1),paste0(Y, "_diff_0_5")] == 0)) {
                mecup_Tm50_treat <- rbind(mecup_Tm50_treat, LOESS_treat[j,])
              }
            
              if ((LOESS_treat[j,paste0(Y, "_diff_0_5")] > 0) & (LOESS_treat[c(j+1),paste0(Y, "_diff_0_5")] < 0)) {
                mecup_Tm50_treat <- rbind(mecup_Tm50_treat, LOESS_treat[c(j, j+1),])
              }
            
            }else{
              break
            }
          }
          # Iteratively create a mecupTm50 data.frame in which there is only one line per treatment which also comprises calculations done for Tm50 determination.
        
          # NEXT: Paste names in a way that they fit for y, ymin, ymax, x, xmin, xmax
          # Prepare the last x/xmin/xmax value of the datapoint in the LOESS fit before the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
            X_value_A = mecup_Tm50_treat[1,"x"]
          
          # Prepare the last y/ymin/ymax value of the datapoint in the LOESS fit before the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
          if (Y=="y") {
            Y_value_A = mecup_Tm50_treat[1,"y"]
          }
          if (Y=="ymin") {
            Y_value_A = mecup_Tm50_treat[1,"ymin"]
          }
          if (Y=="ymax") {
            Y_value_A = mecup_Tm50_treat[1,"ymax"]
          }
          
          # Prepare the first x/xmin/xmax value of the datapoint in the LOESS fit after the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
          X_value_B = mecup_Tm50_treat[2,"x"]
          
          
          # T´Prepare the first y/ymin/ymax value of the datapoint in the LOESS fit after the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
          if (Y=="y") {
            Y_value_B = mecup_Tm50_treat[2,"y"]
          }
          if (Y=="ymin") {
            Y_value_B = mecup_Tm50_treat[2,"ymin"]
          }
          if (Y=="ymax") {
            Y_value_B = mecup_Tm50_treat[2,"ymax"]
          }
          
          # Set X to x/xmin/xmax
          if (Y=="y") {
            X <-  "x"
          }
          if (Y=="ymin") {
            X = "xmin"
          }
          if (Y=="ymax") {
            X = "xmax"
          }
          
          if (dim(mecup_Tm50_treat)[1]==0) {
            mecup_Tm50 <- rbind(mecup_Tm50, c(
              # First.Majority.protein.ID
              PROT,
              # The group ID from the lOESS output table
              unique(LOESS_treat[1,]$group),
              # The treatment corresponding to the group ID from the LOESS output table
              unique(LOESS_treat[1,]$treatment),
              # The used colour for this treatment in the plot
              unique(LOESS[LOESS$treatment==unique(LOESS_treat[1,]$treatment),]$colour),
              # The last x/xmin/xmax value of the datapoint in the LOESS fit before the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
              "NA",
              # The last y/ymin/ymax value of the datapoint in the LOESS fit before the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
              "NA",
              # The first x/xmin/xmax value of the datapoint in the LOESS fit after the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
              "NA",
              # The first y/ymin/ymax value of the datapoint in the LOESS fit after the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
              "NA",
              # x/xmin/xmax_m_Tm50 The slope of the linear approximation of the LOESS plot through the two points extracted directly before and after y/ymin/ymax=0.5 is reached for the first time in a descending part of the LOESS plot.
              "NA",
              # x/xmin/xmax_b_Tm50
              "NA",
              # x/xmin/xmax_Tm50
              "NA",
              "no"
            )
            ) 
          }else{
          
          mecup_Tm50 <- rbind(mecup_Tm50, c(
            # First.Majority.protein.ID
            PROT,
            # The group ID from the lOESS output table
            mecup_Tm50_treat[1,]$group,
            # The treatment corresponding to the group ID from the LOESS output table
            mecup_Tm50_treat[1,]$treatment,
            # The used colour for this treatment in the plot
            mecup_Tm50_treat[1,]$colour,
            # The last x/xmin/xmax value of the datapoint in the LOESS fit before the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
            X_value_A,
            # The last y/ymin/ymax value of the datapoint in the LOESS fit before the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
            Y_value_A,
            # The first x/xmin/xmax value of the datapoint in the LOESS fit after the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
            X_value_B,
            # The first y/ymin/ymax value of the datapoint in the LOESS fit after the first y/ymin/ymax value of 0.5 is passed in a descending part of the LOESS plot
            Y_value_B,
            # x/xmin/xmax_m_Tm50 The slope of the linear approximation of the LOESS plot through the two points extracted directly before and after y/ymin/ymax=0.5 is reached for the first time in a descending part of the LOESS plot.
            (Y_value_B - Y_value_A) / (X_value_B - X_value_A),
            # x/xmin/xmax_b_Tm50
            Y_value_A - (((Y_value_B - Y_value_A) / (X_value_B - X_value_A)) * X_value_A),
            # x/xmin/xmax_Tm50
            (0.5 - (Y_value_A - (((Y_value_B - Y_value_A) / (X_value_B - X_value_A)) * X_value_A)))/((Y_value_B - Y_value_A) / (X_value_B - X_value_A)),
            "yes"
          )
          ) 
          }
          
        } #treatment iteration
        
        # Replace colnames based on selection
        if (Y=="y") {
          mecup_Tm50["DeltaTm50"] <- "NA"
          colnames(mecup_Tm50) <- c("First.Majority.protein.ID", "group", "treatment", "colour", paste0(X, "_Tm50_A"), paste0(Y, "_Tm50_A"), paste0(X, "_Tm50_B"), paste0(Y, "_Tm50_B"), paste0(X, "_m_Tm50"), paste0(X, "_b_Tm50"), paste0(X, "_Tm50"), paste0(X, "_Tm50_present"), "DeltaTm50")
          
        }else{
          colnames(mecup_Tm50) <- c("First.Majority.protein.ID", "group", "treatment", "colour", paste0(X, "_Tm50_A"), paste0(Y, "_Tm50_A"), paste0(X, "_Tm50_B"), paste0(Y, "_Tm50_B"), paste0(X, "_m_Tm50"), paste0(X, "_b_Tm50"), paste0(X, "_Tm50"), paste0(X, "_Tm50_present"))
        }
      
        ## Compare the Tm50 point for each treatment to the Control: DeltaTm50
        ## Only for Y=="y"
        if (Y=="y") {
          mecup_Tm50[, "x_Tm50"] <- as.numeric(mecup_Tm50[, "x_Tm50"])
          mecup_Tm50[mecup_Tm50$First.Majority.protein.ID==PROT, ]["DeltaTm50"] <- mecup_Tm50[mecup_Tm50$First.Majority.protein.ID==PROT, "x_Tm50"] - mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID==PROT) & (mecup_Tm50$treatment == "Control"), "x_Tm50"]
          
          # Create text to show results in plot as a text box/section
          Tm50_text <- paste0("Tm50 [°C]\n", treatment[1], ": ", paste0(round(mecup_Tm50[mecup_Tm50$First.Majority.protein.ID==PROT & mecup_Tm50$treatment==treatment[1], "x_Tm50"],2)))
          for (o in c(2:length(treatment))) {
            Tm50_text <- paste0(Tm50_text, "\n",treatment[o], ": ", paste0(round(mecup_Tm50[mecup_Tm50$First.Majority.protein.ID==PROT & mecup_Tm50$treatment==treatment[o], "x_Tm50"],2)))
          }    
          
          Tm50_text <- paste0(Tm50_text, "\n\n",  "DeltaTm50:\n")
          
          mecup_Tm50[, "DeltaTm50"] <- as.numeric(mecup_Tm50[, "DeltaTm50"])
          for (o in c(2:length(treatment))) {
            Tm50_text <- paste0(Tm50_text, treatment[o], ": ", round(mecup_Tm50[mecup_Tm50$First.Majority.protein.ID==PROT & mecup_Tm50$treatment==treatment[o], "DeltaTm50"],2))
          }
          # Add Tm50_text to mecup_Tm50 in column Tm50_text for all treatments included in the list for the protein of this current iteration.
          # Can be extracted for the plot from the Control row.
          # Take only the treatments included in the mecup_Tm50 data.frame
          
          length_treat <- length(mecup_Tm50$treatment[mecup_Tm50$treatment %in% treatment])
          # Add the text string for each treatment and control (repeat the string length_treat times in a vector)
          
          mecup_Tm50[((mecup_Tm50$treatment %in% treatment) & (mecup_Tm50$First.Majority.protein.ID == PROT)), "Tm50_text"] <- rep(Tm50_text, length_treat)
            
        } # if (Y=="y")
      return(mecup_Tm50)
      } #function ends
      
      # Create treatment vector with all unique treatments and Control being the first entry.
      treatment <- unique(LOESS$treatment)
      treatment <- c("Control", treatment[! treatment %in% c("Control")])
      
      # Apply the function to extract Tm50 profile characteristics
      mecup_Tm50 <- mecup_temp50(PROT, LOESS, "y")
      mecup_Tm50_min <- mecup_temp50(PROT, LOESS, "ymin")
      mecup_Tm50_max <- mecup_temp50(PROT, LOESS, "ymax")
      
      # Merge the three types of extracted data.frame into one
      mecup_Tm50 <- merge(mecup_Tm50, mecup_Tm50_min, all = T, by=c("First.Majority.protein.ID", "group", "treatment", "colour"))
      mecup_Tm50 <- merge(mecup_Tm50, mecup_Tm50_max, all = T, by=c("First.Majority.protein.ID", "group", "treatment", "colour"))
      
      
      # Prepare for overlap of fit determination
      # For calculations, ensure that the respective data is numeric
      mecup_Tm50[, "xmin_Tm50"] <- as.numeric(mecup_Tm50[, "xmin_Tm50"])
      mecup_Tm50[, "xmax_Tm50"] <- as.numeric(mecup_Tm50[, "xmax_Tm50"])
      
      # Prepare for Tm50 fit overlap calculations
      ## Add new columns
      mecup_Tm50$Delta_Treat_xmax_Control_xmin <- "NA"
      mecup_Tm50$Delta_Treat_xmin_Control_xmax <- "NA"
      mecup_Tm50$Tm50_fits_overlapping <- "NA"
      
      ## Extract the string to be modified with the resulting fit overlap information
      Tm50_text <- mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID==PROT & mecup_Tm50$treatment=="Control"), "Tm50_text"]
      
      ## When for ymin and ymax 0.5 is never reached, replace xmin_Tm50 and xmax_Tm50 with the min and max value minus and plus a small value to ensure it is obvious that this is not the true value.
      ### Condition 1: x_Tm50 is there for the control
      ### Condition 2: x_Tm50 is there for a treatment
      ### If then xmin_Tm50 and/or xmax_Tm50 can not be determined as ymin and ymax do not cross 0.5 for the control 
      ### and/or the respective treatment in a way as required
      ### Both can be replaced if not present by the minimal temperature -0.001 and the max temperature in the analysis + 0.001
      
      ## Prepare temperatures for replacement if xmin_Tm50 and xmax_Tm50 are not detected
      
      ### Temp_min
      if (is.na(arguments$NORM)) {
        Temp_min <- min(Sam$Temperature)
      }else{
        Temp_min <- as.numeric(arguments$NORM)
      }
      
      ### Temp_max
      Temp_max <- max(Sam$Temperature)
      
      ## Calculations and determinations for and of the overlap of the fits per treatment
      for (o in c(2:length(treatment))) {
        # If xmin_Tm50 or xmax_Tm50 are not present, they are exchnaged with the minimal and maximal temperature in the assay respectively. A small numnber (0.001) is substracted to clearly indicate that this is not the true temperature and donly required for fit overlap detection and a respective statement
        if (is.na(mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$xmin_Tm50)){
          mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$xmin_Tm50 <- Temp_min - 0.001
        }
        
        if (is.na(mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$xmax_Tm50)){
          mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$xmax_Tm50 <- Temp_max + 0.001
        }
        
        if (is.na(mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (mecup_Tm50$treatment %in% "Control")),]$xmin_Tm50)){
          mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (mecup_Tm50$treatment %in% "Control")),]$xmin_Tm50 <- Temp_min - 0.001
        }
        
        if (is.na(mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (mecup_Tm50$treatment %in% "Control")),]$xmax_Tm50)){
          mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (mecup_Tm50$treatment %in% "Control")),]$xmax_Tm50 <- Temp_max + 0.001
        }
        
        mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID %in%PROT),]$Delta_Treat_xmax_Control_xmin <- mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$xmax_Tm50 - mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (mecup_Tm50$treatment %in% "Control")),]$xmin_Tm50
        mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID %in%PROT),]$Delta_Treat_xmin_Control_xmax <- mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$xmin_Tm50 - mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (mecup_Tm50$treatment %in% "Control")),]$xmax_Tm50
        
        if (!is.na(mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$DeltaTm50)) {
          
          # Differentiate here for <0 and >0 and invert below for "yes" and "no" for >0
          if (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$DeltaTm50 < 0) {
            
           
            
            if (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$Delta_Treat_xmax_Control_xmin > 0) {
              mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID %in%PROT),]$Tm50_fits_overlapping <- "yes"
            }
            if (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$Delta_Treat_xmax_Control_xmin < 0) {
              mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID %in% PROT),]$Tm50_fits_overlapping <- "no"
            }
      
          }
          
          if (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$DeltaTm50 > 0) {
            
            
            
            if (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$Delta_Treat_xmin_Control_xmax > 0) {
              mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID %in%PROT),]$Tm50_fits_overlapping <- "no"
            }
            if (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$Delta_Treat_xmin_Control_xmax < 0) {
              mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID %in% PROT),]$Tm50_fits_overlapping <- "yes"
            }
            
          }
        }
        
        # Set "Tm50_fits_overlapping" to NA" if for the treatment or the control there is not Tm50 value 
        # as in this case the overlap of the fits at Tm50 makes no sense and can only be declared as NA.
        if ((mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% c("Control"))),"x_Tm50_present"] == "no") | 
            (mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),"x_Tm50_present"] == "no")) {
          mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$Tm50_fits_overlapping <- "NA"
          }
    
        # 
        
        Tm50_text <- paste0(Tm50_text, "\n\noverlapping fits\n", treatment[o], ": ", mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in%PROT) & (mecup_Tm50$treatment %in% treatment[o])),]$Tm50_fits_overlapping)
      }
      
      mecup_Tm50[mecup_Tm50$First.Majority.protein.ID==PROT, "Tm50_text"] <- Tm50_text
      
      # Extend plot list for storing plot data
      plot_list$plot_input <- plot_input
      plot_list$LOESS_plot_data <- LOESS_plot_data
      
      ### A mecup data.frame collecting all mecup_Tm50 per protein needs to be created as well to be saved as a result file
      plot_list$mecup_Tm50 <- mecup_Tm50
      
      # Save plot data per protein in mecup_list
      mecup_list$prot <- plot_list
      names(mecup_list) <- gsub("prot", df[i,"First.Majority.protein.ID"], names(mecup_list))
      
      # Create plot with info text
      if ((arguments$PLOT == TRUE) | ((arguments$PLOT == "Tm50_NO") & ("no" %in% mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (!(mecup_Tm50$treatment %in% c("Control")))),]$Tm50_fits_overlapping)) | (arguments$PLOT == "ALL_and_Tm50_NO")) {
    
          ## Extract Tm50_text from mecup_Tm50 for plot
          Tm50_text <- mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID==PROT & mecup_Tm50$treatment=="Control"), "Tm50_text"]
        
          # Create a vector for vertical lines through the different melting points
          vline_melt <- c()
          treatment <- unique(LOESS$treatment)
          
          for (TREAT in treatment) {
            vline_melt <- cbind(vline_melt, mecup_Tm50[(mecup_Tm50$First.Majority.protein.ID==PROT) & (mecup_Tm50$treatment == TREAT), "x_Tm50"])
          }
          vline_melt <- as.vector(vline_melt)
          
          ## plot and save the plot
          if (((arguments$PLOT == "Tm50_NO") & ("no" %in% mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (!(mecup_Tm50$treatment %in% c("Control")))),]$Tm50_fits_overlapping)) | ((arguments$PLOT == "ALL_and_Tm50_NO") & ("no" %in% mecup_Tm50[((mecup_Tm50$First.Majority.protein.ID %in% PROT) & (!(mecup_Tm50$treatment %in% c("Control")))),]$Tm50_fits_overlapping))) {
            dir.create(paste0(resultPath2, "plots_selected/mecup_Tm50_no_overlap/"), showWarnings = FALSE, recursive = TRUE)
            png(paste0(resultPath2, "plots_selected/mecup_Tm50_no_overlap/", PROT, ".png"), width = as.numeric(arguments$png_WIDTH), height = as.numeric(arguments$png_HEIGHT), units = arguments$png_UNITS, res = as.numeric(arguments$png_RESOLUTION), type = "cairo")

            # Print with vertical lines through melting points
            print(p + geom_vline(xintercept = vline_melt,
                                 colour = arguments$colour_values[1:length(vline_melt)],
                                 linewidth = rep(as.numeric(arguments$x_axis_INTERCEPT_LINEWIDTH),length(vline_melt)),
                                 linetype = rep("dashed",length(vline_melt))))
            
            ## Add info text on melting temperatures directly to the plot below the legend.
            ## Answer from Marco Sandri to a stackoverflow: https://stackoverflow.com/questions/58066943/how-to-add-text-below-legend-manually-in-ggplot
            vp = viewport(x=as.numeric(arguments$x_MeCuP_results_TEXT), y = as.numeric(arguments$y_MeCuP_results_TEXT), width = .05, height = .02, just = "center", clip = "off", angle = 0)
            pushViewport(vp)
            tbl <- textGrob(Tm50_text, gp = gpar(fontsize = as.numeric(arguments$MeCuP_results_TEXT_SIZE), col = arguments$MeCuP_results_TEXT_COLOR), just = "left")
            grid.draw(tbl)
            upViewport()
            
            dev.off()
          }
          
          if ((arguments$PLOT == TRUE) | (arguments$PLOT == "ALL_and_Tm50_NO")) {
            dir.create(paste0(resultPath3, "plots_all/mecup_Tm50/"), showWarnings = FALSE, recursive = TRUE)
            png(paste0(resultPath3, "plots_all/mecup_Tm50/", PROT, ".png"), width = as.numeric(arguments$png_WIDTH), height = as.numeric(arguments$png_HEIGHT), units = arguments$png_UNITS, res = as.numeric(arguments$png_RESOLUTION), type = "cairo")

            # Print with vertical lines through melting points
            print(p + geom_vline(xintercept = vline_melt,
                                 colour = arguments$colour_values[1:length(vline_melt)],
                                 linewidth = rep(as.numeric(arguments$x_axis_INTERCEPT_LINEWIDTH),length(vline_melt)),
                                 linetype = rep("dashed",length(vline_melt))))
            
            vp = viewport(x = as.numeric(arguments$x_MeCuP_results_TEXT), y = as.numeric(arguments$y_MeCuP_results_TEXT), width = .05, height = .02, just = "center", clip = "off", angle = 0)
            pushViewport(vp)
            tbl <- textGrob(Tm50_text, gp = gpar(fontsize = as.numeric(arguments$MeCuP_results_TEXT_SIZE), col = arguments$MeCuP_results_TEXT_COLOR), just = "left")
            grid.draw(tbl)
            upViewport()
            
            dev.off()
          }
        
        }
      
      if (!(exists("MeCuP_Tm50"))) {
        MeCuP_Tm50 <- data.frame(matrix(nrow=0, ncol=dim(mecup_Tm50)[2]))
        colnames(MeCuP_Tm50) <- colnames(mecup_Tm50)
      }
      
      MeCuP_Tm50 <- rbind(MeCuP_Tm50, mecup_Tm50)

    } # end of selPROT loop

    # Write time and date to info file
    used_time[[(length(used_time) + 1)]] <- Sys.time()
    cat('\nTime needed for running this SPmean filtering loop of the MeCuP script: ',   round(difftime(used_time[[(length(used_time))]], used_time[[(length(used_time)) - 1]], units = "mins"),2), ' min\n', file=info.file, append=T)
    print(round(difftime(used_time[[(length(used_time))]], used_time[[(length(used_time)) - 1]], units = "mins"),2))
    cat('\nDate MeCuP Script: ',  date(), ' \n', file=info.file, append=T)
    close(info.file)
    rm(info.file)
    
    ###########################################################################################
    ################# Remove Duplicated Entries from Excluded Proteins Table ##################
    ###########################################################################################
    # Prior to removal, store the number of excluded proteins per reason and thereafter the number of proteins removded in total - which is not the sum due to some overlaps.
    MeCuP__Excluded_Proteins %>% count(Reason4Exclusion, sort = TRUE) -> Reason4ExclusionCount
    
    excludedDuplicates <- MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins$First.Majority.protein.ID %in% MeCuP__Excluded_Proteins$First.Majority.protein.ID[duplicated(MeCuP__Excluded_Proteins$First.Majority.protein.ID)],]
    excludedDuplicateProteins <- unique(excludedDuplicates$First.Majority.protein.ID)
    
    for (j in c(1:length(excludedDuplicateProteins))) {
      vector <- paste(MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins[,"First.Majority.protein.ID"] == excludedDuplicateProteins[j], ]$Reason4Exclusion, collapse = ",")
      MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins[,"First.Majority.protein.ID"] == excludedDuplicateProteins[j], ]$Reason4Exclusion <- rep(vector, length(MeCuP__Excluded_Proteins[MeCuP__Excluded_Proteins[,"First.Majority.protein.ID"] == excludedDuplicateProteins[j], ]$Reason4Exclusion))
    }
    
    # Remove duplicated entries after combining the reasons for duplicates
    MeCuP__Excluded_Proteins <- MeCuP__Excluded_Proteins[!duplicated(MeCuP__Excluded_Proteins[,c("First.Majority.protein.ID", "Reason4Exclusion")]),]
    
    # Sort the dataframe by representative identifiers
    MeCuP__Excluded_Proteins <- MeCuP__Excluded_Proteins[order(MeCuP__Excluded_Proteins$First.Majority.protein.ID, decreasing = FALSE), ]
    
    # Add counts for the new multi_reason groups
    MeCuP__Excluded_Proteins %>% count(Reason4Exclusion, sort = TRUE) -> Reason4ExclusionCountMultiReason
    Reason4ExclusionCountMultiReason <- Reason4ExclusionCountMultiReason[!(Reason4ExclusionCountMultiReason[,1] %in% Reason4ExclusionCount[,1]),]
    Reason4ExclusionCount <- rbind( Reason4ExclusionCount , Reason4ExclusionCountMultiReason)
    
    # Add the number of proteins excluded in total (note, some have multiple reasons for exclusion).
    Reason4ExclusionCount <- rbind(Reason4ExclusionCount, c("all_excluded_proteins", length(MeCuP__Excluded_Proteins[,1] )))
    
    ###########################################################################################
    ################################### Save Output Tables ####################################
    ###########################################################################################
    
    # Add results with a column with links to the respective plots
    
    # Save the MeCuP_Tm50 output file as a txt file
    write.table(MeCuP_Tm50, paste0(resultPath3, "MeCuP__Tm50_plotTable.txt"), sep="\t", row.names=FALSE)
    write.csv(MeCuP_Tm50, paste0(resultPath3, "MeCuP__Tm50_plotTable.csv"), row.names=FALSE)
    
    # Save the excluded proteins collected in MeCuP__Excluded_Proteins - remove duplicates for +/- SPmean_filtering or add a column with SPmean_filtering or save one file per iteration in the different directories.
    write.table(MeCuP__Excluded_Proteins, paste0(resultPath3, "MeCuP__Table2_Excluded_Proteins.txt"), sep = "\t", row.names=FALSE)
    write.csv(MeCuP__Excluded_Proteins, paste0(resultPath3, "MeCuP__Table2_Excluded_Proteins.csv"), row.names=FALSE)
   
    # Save the count of reasons4exclusions
    write.table(Reason4ExclusionCount, paste0(resultPath3, "MeCuP__Reason4ExclusionCount.txt"), sep = "\t", row.names=FALSE)
    write.csv(Reason4ExclusionCount, paste0(resultPath3, "MeCuP__Reason4ExclusionCount.csv"), row.names=FALSE)
    
    ###########################################################################################
    ###########################################################################################
    
    # Remove data not needed for the next loop and downstream code
    rm(list=setdiff(ls(), c("Anno",
                            "arguments",
                            "argumentsDF",
                            "BSA_plotTable",
                            "excluded_duplicated",
                            "input_proteins",
                            "MeCuP__Coverage",
                            "MECUP__EXCLUDED_PROTEINS", 
                            "MQIN_XTRACT", 
                            "MQin_Xtract_docu",
                            "resultPath1", 
                            "SAM", 
                            "Sam_docu",
                            "selPROT",
                            "selectedPROTEINS",
                            "selectedPROTEINS_FILE",
                            "SPmeanfilter", 
                            "SPmean_filter",
                            "SPmean_filtering_steps",
                            "SPmeanLOOP",
                            "SPmeanLOOP_NORM",
                            "TREAT_NORM",
                            "used_time")))
    
    # Modified in the previous loop it is set back to the initial argument
    #NORM <- norm

    
  } #end of SPmean_filtering loop
  
  ###########################################################################################
  ######################### SPmean filtering effect documentation ###########################
  ###########################################################################################
  # When the script has been run with and without the SPmean_filtering option, 
  # the effect of filtering is documented if the user has selected this (SP_mean_filter_effect == TRUE). 
  
  # The function likely needs to be adjusted when multiple treatments are used.
  if (arguments$sp_mean_filter_effect == TRUE) {
     source("MeCuP__functions.R")
     MeCuP_filter_effect(resultPath1)
  }
  
  
  ###########################################################################################
  ######################### Create  MeCuP__Table1_Results Table #############################
  ###########################################################################################
  # This part grew over the time of the project. 
  # It might benefit from a final refactoring but is not very demanding with respect to computation.
  
  # Request:
  # One line per protein
  # Add a column with links to the respective plots.
  # Provide core MeCuP results on melting points.
  # Write properties per protein that can be used for filtering.
  # Provide some defined input data, normalization results and means plus SD.
  # Idea: read output MeCuPTm50 plot tables as changes in there are directly transferred to this part but if not all columns are wanted these need to be removed in this approach.
  # Split into one df per treatment and adapt colnames with treatment name, cbind data frames per treatment to one dataframe with one line per protein
  # Input: Path to filtered or unfiltered output therefore no additional argument or hard encoding is required as this is available in the MeCuP script already.
  # Can be run before applying MeCuP_writeXlsx and the result table in there can eventually be replaced with this version. The initial version was only a placeholder.
  # Prepare here and move as much as possible to functions.
  # Might eventually be combined in a function names CreateResultsFile - not sure, keeping format issues and rearranging and extracting results separate might make maintenance easier.
  
  source("MeCuP__functions.R")
  
  path_list <- MeCuP_CreateResultsPathList(resultPath1, arguments$SPmean_filtering)
  
  for (PATH in path_list) {
  
   # 1) read in the data
    # Read data from the MeCuP output used for plotting
    df <- read.table(paste0(PATH, "output_detailed/", "MeCuP__Tm50_plotTable.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
    
   # 2) split df by treatment, adapt colnames and combine to new data frame per protein
    
    # extract the treatment list and ensure that "Control" comes first
    treatmentList <- c("Control", unique(df$treatment[!df$treatment == "Control"]))
    
    # Create a dataframe with colors for the colname background and font
    colnameColor <- MeCuP_resultsColnameColor(df)
    
    # Create a data.frame with one line per protein from the plot table 
    newDf <- data.frame(matrix(ncol = 0, nrow = (dim(df)[1]/length(treatmentList))))
    
    for (treat in treatmentList) {
      nextColnames <- c("First.Majority.protein.ID", paste0(treat, "_", colnames(df)[c(2:(length(colnames(df))))]))
      nextDf <- df[df$treatment == treat,]
      row.names(nextDf) <- seq_len(dim(df)[1]/length(treatmentList))
      
      colnames(nextDf) <- nextColnames
      if (dim(newDf)[2] > 0) {
        newDf <- merge(newDf, nextDf, by = "First.Majority.protein.ID")
      }else{
        newDf <- cbind(newDf,nextDf)
      }
    }
    
    # 3) extract other missing desired data
    
    # MaxQuant input data, BSA normalized data, data normalized to the start point (either lowest or selected temperature)
    
    # Read in the MQin_Xtract dataframe
    MQin_Xtract <- read.table(paste0(resultPath1, "/output_detailed/MeCuP__MQin_Xtract_BSA_SP_Norm.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
    
    # MaxQuant input data
    iBAQ_inputMQ <- MQin_Xtract[, c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", paste0(SAM$iBAQ_sample_colnames))]
    colnames(iBAQ_inputMQ) <- c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", paste0(SAM$Treatment, "_", SAM$Temperature, "_", SAM$iBAQ_sample_colnames))
    
    # Add a column informing about the selected proteins of this MeCuP run as only for the selected proteins melting curve data is available 
    # and only for theses or a subset of theses a plot is available based on the PLOT argument passed for this MeCuP run.
    # The normalization is done for all proteins which were not excluded.
    # Excluded proteins and their MaxQuant input data are stored in another output table for documentation.
    iBAQ_inputMQ$selected4MeCuP <- FALSE
    iBAQ_inputMQ[iBAQ_inputMQ$First.Majority.protein.ID %in% newDf$First.Majority.protein.ID,]$selected4MeCuP <- gsub(FALSE, TRUE, iBAQ_inputMQ[iBAQ_inputMQ$First.Majority.protein.ID %in% newDf$First.Majority.protein.ID,]$selected4MeCuP)
    iBAQ_inputMQ <- iBAQ_inputMQ[, c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", "selected4MeCuP", paste0(SAM$Treatment, "_", SAM$Temperature, "_", SAM$iBAQ_sample_colnames))]
    
    # BSA normalized data
    MeCuP__normBSA <- MQin_Xtract[, c("Majority.protein.IDs", paste0(SAM$iBAQ_sample_colnames, "_BSA"))]
    colnames(MeCuP__normBSA) <- c("Majority.protein.IDs", paste0(SAM$Treatment, "_", SAM$Temperature, "_", SAM$iBAQ_sample_colnames, "_BSA"))
    
    # data normalized to the start point (either lowest or selected temperature), respective means and standard deviations
    
    # For mean and SD extraction: use the unique treatment - temperature combinations (unique(SAM[, c("Treatment", "Temperature")]))
    
    if (SPmeanLOOP_NORM == "Control") {
      MeCuP_normSP <- MQin_Xtract[, c("Majority.protein.IDs", paste0(SAM$iBAQ_sample_colnames, "_BSA__", SAM$Treatment, "_", SAM$Temperature, "_SP_Norm_Control"))]
      colnames(MeCuP_normSP) <- c("Majority.protein.IDs", paste0(SAM$Treatment, "_", SAM$Temperature, "_", SAM$iBAQ_sample_colnames, "_BSA__SP_Norm_Control"))
      MeCuP_normSP_mean <- MQin_Xtract[, c("Majority.protein.IDs", paste0(unique(SAM[, c("Treatment", "Temperature")])$Treatment, "_", unique(SAM[, c("Treatment", "Temperature")])$Temperature, "_BSA_Mean_SP_Norm_Control"))]
      MeCuP_normSP_SD <- MQin_Xtract[, c("Majority.protein.IDs", paste0(unique(SAM[, c("Treatment", "Temperature")])$Treatment, "_", unique(SAM[, c("Treatment", "Temperature")])$Temperature, "_BSA_SD_SP_Norm_Control"))]
      } else {
      MeCuP_normSP <- MQin_Xtract[, c("Majority.protein.IDs", paste0(SAM$iBAQ_sample_colnames, "_BSA__", SAM$Treatment, "_", SAM$Temperature, "_SP_Norm_", SAM$Treatment))]
      colnames(MeCuP_normSP) <- c("Majority.protein.IDs", paste0(SAM$Treatment, "_", SAM$Temperature, "_", SAM$iBAQ_sample_colnames, "_BSA__SP_Norm_", SAM$Treatment))
      MeCuP_normSP_mean <- MQin_Xtract[, c("Majority.protein.IDs", paste0(unique(SAM[, c("Treatment", "Temperature")])$Treatment, "_", unique(SAM[, c("Treatment", "Temperature")])$Temperature, "_BSA_Mean_SP_Norm_", unique(SAM[, c("Treatment", "Temperature")])$Treatment))]
      MeCuP_normSP_SD <- MQin_Xtract[, c("Majority.protein.IDs", paste0(unique(SAM[, c("Treatment", "Temperature")])$Treatment, "_", unique(SAM[, c("Treatment", "Temperature")])$Temperature, "_BSA_SD_SP_Norm_", unique(SAM[, c("Treatment", "Temperature")])$Treatment))]
    }
    
    # Adding counts columns for filtering
    MeCuP_valid <- MQin_Xtract[, c("Majority.protein.IDs", "First.Majority.protein.ID", paste0(unique(SAM[, c("Treatment", "Temperature")])$Treatment, "_", unique(SAM[, c("Treatment", "Temperature")])$Temperature, "_Detect"))]
    
    
    for (treat in treatmentList) {
      MeCuP_valid[,paste0(treat, "_Detected_All")] <- 0
      MeCuP_valid[,paste0(treat, "_Detected_All_percent")] <- 0
      MeCuP_valid[,paste0(treat, "_Detected_Tm50")]  <- 0
      MeCuP_valid[,paste0(treat, "_Detected_Tm50_percent")]  <- 0
      
      # Extract Tm50 and merge with MeCuP_valid
      newDf_Tm50 <- newDf[, c("First.Majority.protein.ID", paste0(treat, "_x_Tm50"))]
      colnames(newDf_Tm50) <- c("First.Majority.protein.ID", paste0(treat, "_TM50"))
      
      MeCuP_valid <- merge(newDf_Tm50, MeCuP_valid, by = "First.Majority.protein.ID", all.y = TRUE)
      
      MeCuP_valid$maxCount_Tm50 <- 0
      
      for (temp in unique(SAM$Temperature)) {
        # Sum absolute values (Detected_All)
        MeCuP_valid[,paste0(treat, "_Detected_All")] <-  MeCuP_valid[,paste0(treat, "_Detected_All")] + MeCuP_valid[,paste0(treat, "_", temp, "_Detect")]
        
        # Sum absolute values below Tm50
        MeCuP_valid[is.na(MeCuP_valid[,paste0(treat, "_TM50")]), paste0(treat, "_TM50")] <- 0
        MeCuP_valid[MeCuP_valid[,paste0(treat, "_TM50")] < temp, paste0(treat, "_", temp, "_Detect")] <- 0 # Set all above Tm50 to zero
        MeCuP_valid[,paste0(treat, "_Detected_Tm50")]  <- MeCuP_valid[,paste0(treat, "_Detected_Tm50")] +  MeCuP_valid[,paste0(treat, "_", temp, "_Detect")]
        
        # Only set those to NA for which there was no melting temperature, for all others, it is possible that the result is zero
        MeCuP_valid[, paste0(treat, "_Detected_Tm50")][((MeCuP_valid[, paste0(treat, "_Detected_Tm50")] == 0) & (!(MeCuP_valid[, paste0(treat, "_TM50")] > 0)))] <- NA
      }
      
      # Percent of valid values (ALL)
      MeCuP_valid[,paste0(treat, "_Detected_All_percent")] <-  MeCuP_valid[,paste0(treat, "_Detected_All")] / (dim(unique(SAM[, c("Treatment", "Temperature")])[unique(SAM[, c("Treatment", "Temperature")])$Treatment == treat,])[1] * as.numeric(arguments$repeats))
      
      # Percent of valid values (<= Tm50)
      for (i in c(1:length(unique(SAM[SAM$Treatment == treat,]$Temperature)))){
        MeCuP_valid[(MeCuP_valid[ ,paste0(treat, "_TM50")] > unique(SAM[SAM$Treatment == treat,]$Temperature)[i]), "maxCount_Tm50"] <- MeCuP_valid[(MeCuP_valid[ ,paste0(treat, "_TM50")] > unique(SAM[SAM$Treatment == treat,]$Temperature)[i]), "maxCount_Tm50"]  + as.numeric(arguments$repeats)
      }
      
      MeCuP_valid[MeCuP_valid$maxCount_Tm50 == 0, "maxCount_Tm50"] <- NA
      MeCuP_valid[,paste0(treat, "_Detected_Tm50_percent")] <- MeCuP_valid[,paste0(treat, "_Detected_Tm50")] / MeCuP_valid[,"maxCount_Tm50"]
      }
    
    MeCuP_valid <- MeCuP_valid[,c("Majority.protein.IDs", colnames(MeCuP_valid[,grepl("_Detected_", colnames(MeCuP_valid))]))]
    
    # combined MQin_Xtract data for the result table
    MQin_Xtract_result <- merge(merge(MeCuP_valid, iBAQ_inputMQ, by="Majority.protein.IDs"), MeCuP_normSP, by = "Majority.protein.IDs")
    MQin_Xtract_result <- merge(merge(MQin_Xtract_result, MeCuP__normBSA, by="Majority.protein.IDs"), MeCuP_normSP_SD, by="Majority.protein.IDs") 
    MQin_Xtract_result <- merge(merge(MQin_Xtract_result, MeCuP_normSP_mean, by="Majority.protein.IDs"), MeCuP_normSP_SD, by="Majority.protein.IDs") 
    MQin_Xtract_result <- MQin_Xtract_result[,c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", "selected4MeCuP", colnames(MQin_Xtract_result)[!(colnames(MQin_Xtract_result) %in% c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", "selected4MeCuP"))])]
    
    rm(iBAQ_inputMQ, MeCuP__normBSA, MeCuP_normSP, MeCuP_normSP_mean, MeCuP_normSP_SD, MeCuP_valid)
    
    
    # Calculate the span of temperatures(x) based on the y-confidence span around the melting curve
    for (treat in treatmentList){
      newDf[,paste0(treat, "_span_x_Tm50")] <-  newDf[,paste0(treat, "_xmax_Tm50")] -  newDf[,paste0(treat, "_xmin_Tm50")]
  
      for (i in c(1: dim(newDf)[1])) {
        if (newDf[i,paste0(treat, "_xmin_Tm50_present")] == "no" | newDf[i,paste0(treat, "_xmax_Tm50_present")] == "no"){
          newDf[i,paste0(treat, "_span_x_Tm50_borders_present")] <- FALSE
        }else{
          newDf[i,paste0(treat, "_span_x_Tm50_borders_present")] <- TRUE
        }
      }
      # Use the spanx_Tm50_borders_present information to set the span calculation result to NA if one borders is not present
      newDf[newDf[,paste0(treat, "_span_x_Tm50_borders_present")] == FALSE, paste0(treat, "_span_x_Tm50")] <- NA
      
      # Replace yes and no with TRUE and FALSE in paste0(treat, "_Tm50_fits_overlapping")
      newDf[,paste0(treat, "_Tm50_fits_overlapping")] <- gsub("yes", TRUE, newDf[,paste0(treat, "_Tm50_fits_overlapping")])
      newDf[,paste0(treat, "_Tm50_fits_overlapping")] <- gsub("no", FALSE, newDf[,paste0(treat, "_Tm50_fits_overlapping")])
      
      no_overlap <- rep(NA,dim(newDf)[1])
      
      # As more than one treatment might be analyzed in the future: Create a list with a list of treatments per protein for which there is no overlap with the control melting curve at the the melting points.
      for (i in c(1: dim(newDf)[1])) {
        if((treat != "Control") & (!(is.na(newDf[i,paste0(treat, "_Tm50_fits_overlapping")])))){
          if (newDf[i,paste0(treat, "_Tm50_fits_overlapping")] == FALSE){
            if (is.na(no_overlap[i])) {
              no_overlap[i] <- treat
            } else {
              no_overlap[i] <- c(no_overlap[i], treat)
            }
          }
        }
      }
      # If still present, delete "Control_Tm50_fits_overlapping"
      try({newDf <- newDf[,!grepl("Control_Tm50_fits_overlapping", colnames(newDf))]}, silent = TRUE)
    }
    
    # As more than one treatment might be analyzed in the future: Add a column with the respsective list of treatments per protein created in the loop above.ing points.
    newDf$treatNoOverlap <- no_overlap
  
    
    # Remove the information for Tm50_A and Tm50_B coordinates per treatment which is not needed in the output
    # Same for min and max
    # Remove the information on presence as these were wither used to set the unrealistic values inserted before to NA or to provide a column on the presence of any border of the span
  
    newDf <- newDf[,!grepl("_Tm50_A", colnames(newDf))]
    newDf <- newDf[,!grepl("_Tm50_B", colnames(newDf))]
    newDf <- newDf[,!grepl("xmin", colnames(newDf))]
    newDf <- newDf[,!grepl("xmax", colnames(newDf))]
    newDf <- newDf[,!grepl("ymin", colnames(newDf))]
    newDf <- newDf[,!grepl("ymax", colnames(newDf))]
    newDf <- newDf[,!grepl("_span_x_Tm50_borders_present", colnames(newDf))]
    newDf <- newDf[,!grepl("_x_Tm50_present", colnames(newDf))]
  
    # Extract the color and group used in ggplot for the style 
    MeCuP_color <- unique(newDf[!(apply(newDf[,grepl("_colour", colnames(newDf))], 1, function(x) all(is.na(x)))), c(colnames(newDf)[grepl("_colour", colnames(newDf))], colnames(newDf)[grepl("_group", colnames(newDf))])])
    rownames(MeCuP_color) <- c(1:dim(MeCuP_color)[1])
    MeCuP_color <- MeCuP_color[,order(colnames(MeCuP_color))]
    
    # Remove the respective columns
    newDf <- newDf[,!grepl("_colour", colnames(newDf))]
    newDf <- newDf[,!grepl("_group", colnames(newDf))]
    
    # Save as an additional table in 'output_detailed' to be used for the style of the colnames for the final xlsx file layout
    write.table(MeCuP_color, paste0(PATH, "output_detailed/", "MeCuP__PlotColorGroup.txt"))
    write.csv(MeCuP_color, paste0(PATH, "output_detailed/", "MeCuP__PlotColorGroup.csv"), row.names=FALSE)
    
    # Remove columns naming the treatment, this has already been concatenated with the respective colnames for the MeCuP analysis.
    newDf <- newDf[,!grepl("_treatment", colnames(newDf))]
    
    # Remove Tm50_text as this is not needed for the result file
    newDf <- newDf[,!grepl("_Tm50_text", colnames(newDf))]
    
    # Keep the slope at the melting point and the melting point temperature per treatment.
    # The slope might be of interest for additional filtering or clustering or when used for a predictive model as a valuable feature.
    # Remove the b values (intercept) for the linear formulars as this is not needed for the result file
    newDf <- newDf[,!grepl("_x_b_Tm50", colnames(newDf))]
    
    # 4) combine all result data extracted above for further selection and arrangement of results columns
    MeCuP_results <- merge(newDf, MQin_Xtract_result, by = "First.Majority.protein.ID", all.y = TRUE)
    
    # Rearrange the columns for the result file composition
    MeCuP_results <- MeCuP_results[, c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", "selected4MeCuP", colnames(MeCuP_results)[!(colnames(MeCuP_results) %in% c("Majority.protein.IDs", "First.Majority.protein.ID", "Annotation", "selected4MeCuP"))])]
    
    # 5) decide on arrangement of columns and compose output dataframe
    
    # 6) Write MeCuP_results to txt and csv file without the hyperlinks
    
    write.table(MeCuP_results, paste0(PATH, "output_detailed/MeCuP__Table1_Results.txt"), sep="\t", row.names=FALSE)
    write.csv(MeCuP_results, paste0(PATH, "output_detailed/MeCuP__Table1_Results.csv"), row.names=FALSE)
    
    rm(wb)
    
  } # paths

  ###########################################################################################
  ################################### Fit Melting Curve #####################################
  ###########################################################################################
  
  # This means fitting a sigmoid curve to the LOESS fit above 
  # or identify the correct region with the LOESS fit and fit there with sigmoid using the original points
  
  ###########################################################################################
  ################################### Cluster Profiles ######################################
  ###########################################################################################
  
  # filter
    # Ideas for clustering proteins per treatment:
    # 1) Cluster with b and m at melting point (maybe plus melting point)
    # 2) Cluster with b and m (and x) as above and add min. max and repectiv x values
    # 3) Cluster with same as in 2) and add delta Tm only for the treatments without the control
    # 4) Cluster with same as in 3) but add curve chracteristics from 2 also for the control for each treatment without the control
    # 5) Cluster with same as in 2) and add difference of control normalized values at start point
    # 6) Cluster with same as in 5 plus 3
    # 7) Cluster with same as in 6 plus 4
    # reduce feature list, what is interesting to be clustered, how many clusters can be differentiated
    # should more curve characteristics be considered? -> cluster whole curves (likely too much with low repetition number and LOESS fit)
    # Hierarchical clustering and/or PCA and scree plot / cumulative variability selection of dimensions
    
  ###########################################################################################
  ############################ Candidate Selection Summaries ################################
  ###########################################################################################
  
  # Can use characteristics extracted above.
  # Might consider clustered groups.
  # Enrichment could be done using e.g. Mercator output.
  
  ###########################################################################################
  ############################### Save Output Tables as xlsx ################################
  ###########################################################################################
  source("MeCuP__functions.R")
  
  path_list <- MeCuP_CreateResultsPathList(resultPath1, arguments$SPmean_filtering)
  
  for (path in path_list) {
    if ((file.exists(paste0(path, "output_detailed/", "MeCuP__Table2_Excluded_Proteins.txt"))) & (file.exists(paste0(path, "output_detailed/", "MeCuP__Tm50_plotTable.txt")))) {
      MeCuP_writeXlsx(path, arguments$XLSX_OUTPUT_LEGEND, Sam_docu, arguments$PLOT, arguments$selectedPROTEINS)
    }
  }
  ###########################################################################################
  ################################## Write session infos ####################################
  ###########################################################################################
  
  used_time[[(length(used_time) + 1)]] <- Sys.time()
  
  for (path in path_list) {  
    MeCuP_writeSession(path, used_time)
  }
  
  print(paste0("The MeCuP script finished for SPmeanNORM = ", SPmeanLOOP_NORM, " in ", round(difftime(used_time[[(length(used_time))]], used_time[[1]], units = "mins"),2), " min"))
  
  
  # Remove data not needed for the next loop and downstream code
  rm(list=setdiff(ls(), c("arguments",
                          "argumentsDF",
                          "SPmeanfilter", 
                          "SPmean_filter",
                          "SPmeanLOOP",
                          "SPmeanLOOP_NORM",
                          "TREAT_NORM",
                          "used_time")))
  
}
  
  if (length(SPmeanLOOP) > 1){
    print(paste0("The MeCuP script finished for both SPmeanNORMs in ", round(difftime(used_time[[(length(used_time))]], used_time[[1]], units = "mins"),2), " min"))
  }

###########################################################################################
###########################################################################################

# Modified break previously used for development and now signalling the end of the script :)
if (TRUE == TRUE) {
  stop("You reached the end of the MeCuP script.")
}

