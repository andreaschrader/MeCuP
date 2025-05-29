# MeCuP functions
# Support with TPP script analysis Hildebrandt lab
# 2022-11-28: started support
# 2023-11-09: started MeCuP-Dev-Detect development
# Script: Andrea Schrader
# ORCID: 0000-0002-3879-7057
# GitHub: andreaschrader
########################

################################################################################################################################################################################################################################################################################################################################

MeCuP_addExcludedProteinsXlsx <- function (wb, PATH) {
  #input is an existing workbook and the path for the MeCuP output directory
  ##### begin of function 'MeCuP_addExcludedProteinsXlsx'
  
  # Read data from the MeCuP output
  df <- read.table(paste0(PATH, "output_detailed/", "MeCuP__Table2_Excluded_Proteins.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Excluded_Proteins")
  
  # write supplies to the worksheet using headerStyle
  writeData(wb = wb, sheet = "Excluded_Proteins", x = df, colNames = TRUE)
  return(wb)
} ##### end of function 'MeCuP_addExcludedProteinsXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addLegendExcludedProteinsXlsx <- function (wb) {
  #input is an existing workbook
  ##### begin of function 'MeCuP_addLegendExcludedProteinsXlsx'
  
  # Add the text for the legend
  emptyLine <- c(NA,NA,NA)
  legendExcludedProteins <- as.data.frame(rbind(c("Legend",NA,NA),
                                                emptyLine, 
                                                c("Name of individual file:","MeCuP__Table2_Excluded_Proteins", NA),
                                                c("Name of sheet in collection:","Excluded_Proteins", NA),
                                                emptyLine,
                                                c("Column identifier", "Column name", "Description"),
                                                c("A", "Majority.protein.IDs", "Derived from the MaxQuant input file. Detected masses of peptides match for multiple proteins which are provided by the respective AGI codes."),
                                                c("B", "First.majority.protein.ID", "MeCuP extracts the first AGI / identifier from \"Majority.protein.IDs\" as a representative protein for this deteced peptide pattern to link an annotation. Please note, this might be representative not only for different proteins variants due to different gene models from one gene but, also, for different proteins/genes which are almost identical in amino acid sequence. This needs to be considered for downstream analysis of candidates as selected from this method which basically a script supporting a candidate screening method only!"),
                                                c("C", "Annotation", "Annotations are derived per protein identfier (based on the AGI codes) from a lab internal annotation file. NA: no annotation information in this used annotation file."),
                                                c("D", "Reason4Exclusion", "This file contains all proteins that were excluded from the candidate selection by the MeCuP script for various reasons e.g. due to a too low coverage. The different abbreviations used are described below in more detail."),
                                                c("E-end", "Pattern: iBAQ.XX_SlotY.ZZ_Z_ZZZZ", "Names for each analyzed sample from the mass spectrometry output. See the sample list written by the MeCuP script which contains these names as well as other provided information on each sample like applied temperature or treatment. These names are derived from the MaxQuant output used as input for MeCuP. XX stands for the run identifier for the run at the mass spectrometry device. These are used to link these columns from the MaxQuant input file with the trespective samples using the sample list."),
                                                emptyLine,
                                                emptyLine,
                                                c("Reason4Exclusion","Abbreviation used","Description of excluded proteins"),
                                                c(NA,"name_starts_with_gi","Proteins, for which a name in \"Majority.protein.IDs\" starts with \"gi\" as provided in the MaxQuant input file. These proteins are removed before SPmean filtering."),
                                                c(NA,"Potential.contaminant","Proteins identified as potential contaminats by MaxQuant (\"+\" in the column \"Potential.contaminant\"). These proteins are removed before SPmean filtering."),
                                                c(NA,"Reverse","Proteins identified as reverse by MaxQuant (\"+\" in the column \"Reverse\"). These proteins are removed before SPmean filtering."),
                                                c(NA,"Only.identified.by.site","Proteins identified as only identified by site by MaxQuant (\"+\" in the column \"Only.identified.by.site\"). These proteins are removed before SPmean filtering."),
                                                c(NA,"SPmean_filtering_Control_Control OR\n\rSPmean_filtering_treat_Control OR\n\rSPmean_filtering_treat_treat","Only, when the user selects SPmean_filtering \"TRUE\" or \"both\" for this parameter. Proteins for which less than X% or Y samples of the samples used for normalization* are detected (above the threshold) with X or Y being selectable by the user, default: 50%. At the end, the selection for SPmeanNORM is added (\"Control\" or \"treat\") and the respective treatement (Filtering due to exclusion in \"Control\" or because all treatments have the low coverage. If only one of more than one treatment has a low coverage, it is set to NA for downstream calculations for this protein at the starting point values and the protein is not removed in total.) in which this protein is excluded. For more details on normalization* see in the cell below or below the table."),
                                                c(NA,"SPmeanNORM_Control_Control_threshMeanDivision OR\n\rSPmeanNORM_treat_Control_threshMeanDivision OR\n\rSPmeanNORM_treat_treat_threshMeanDivision","When there is no filtering step, there is a protective step excluding proteins for which the normalization samples' mean is at or below the threshold (including zero). Thereby, a division by zero is prevented. SPmeanNORM is followed by the treatment used for normalization*, \"treat\" identifies the user selection for this parameter and \"threshMeanDivision\" describes the reason as outlined in this cell. The selection is either \"Control\" or \"treat\". If this is followed by a second \"treat\", this indicates that the normalization samples' mean is at or below the threshold (including zero) for all treatments (excluding the control). \"Control\" indicates that the normalization samples' mean is at or below the threshold regardless of the chosen SPmeanNORM option (\"Control\" or \"treat\"). If both conditions are met, both abbreviations are provided."),
                                                emptyLine,
                                                c(NA,"SP = starting point","* The samples used for normalization are determined as follows:\nNORM provides the temperature which is used for normalization and below which no samples are considered for the analysis. The default is the lowest provided temperature from the sample list input file.\nSPmeanNORM provides the treatment used for normalization: either \"Control\" for using the mean of the \"Controle\" samples at NORM temperature for normalization of all samples from all treatments or \"treat\" for using the mean of the samples of each treatment at the NORM temperature for normalization of all sampels of this treatment."))
  )
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Legend_Excluded_Proteins")
  
  # write the data to the worksheet
  writeData(wb = wb, sheet = "Legend_Excluded_Proteins", x = legendExcludedProteins, colNames = FALSE)
  
  # Adjust col widths
  setColWidths(wb = wb, sheet = "Legend_Excluded_Proteins", cols = 1, widths = 27.45)
  setColWidths(wb = wb, sheet = "Legend_Excluded_Proteins", cols = 2, widths = 43.85)
  setColWidths(wb = wb, sheet = "Legend_Excluded_Proteins", cols = 3, widths = 105.9)
  
  # Adjust row heights
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = 1, heights = 26)
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = c(3:4), heights = 19)
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = c(7,9,10,15,16,18), heights = 34)
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = c(8,11), heights = 85)
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = c(17), heights = 17)
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = c(19,22), heights = 102)
  setRowHeights(wb = wb, sheet = "Legend_Excluded_Proteins", rows = 20, heights = 115)
  
  
  # create styles
  legendStyle1 <- createStyle(fontSize = 20, 
                              textDecoration = "BOLD", 
                              valign = "center")
  legendStyle2 <- createStyle(fontSize = 14, 
                              valign = "center")
  legendStyle3 <- createStyle(fontSize = 12, 
                              textDecoration = "BOLD", 
                              valign = "center", 
                              border = c("top", "bottom", "left", "right"), 
                              borderColour = openxlsx_getOp("borderColour", "black"), 
                              borderStyle = c("thin", "thin", "thin", "thin"),
                              fgFill = "#E7E6E6",
                              bgFill = "black") # Headers in grey boxes
  legendStyle4 <- createStyle(fontSize = 12, 
                              valign = "center", 
                              border = c("top", "bottom", "left", "right"), 
                              borderColour = openxlsx_getOp("borderColour", "black"), 
                              borderStyle = c("thin", "thin", "thin", "thin"),
                              fgFill = "#E7E6E6",
                              bgFill = "black")
  legendStyle5 <- createStyle(fontSize = 12, 
                              fontColour = "#1E17FF",
                              valign = "center", 
                              border = c("top", "bottom", "left", "right"), 
                              borderColour = openxlsx_getOp("borderColour", "black"), 
                              borderStyle = c("thin", "thin", "thin", "thin"),
                              fgFill = "#E7E6E6",
                              bgFill = "black")
  legendStyle6 <- createStyle(fontSize = 12, 
                              textDecoration = "BOLD",
                              fontColour = "#1E17FF",
                              valign = "center") # blue font bold in white box
  legendStyle7 <- createStyle(fontSize = 12, 
                              valign = "center", 
                              halign = "justify",
                              border = c("top", "bottom", "left", "right"), 
                              borderColour = openxlsx_getOp("borderColour", "black"), 
                              borderStyle = c("thin", "thin", "thin", "thin"),
                              fgFill = "#E7E6E6",
                              bgFill = "black",
                              wrapText = TRUE)
  legendStyle8 <- createStyle(fontSize = 12, 
                              valign = "top", 
                              border = "top", 
                              borderColour = openxlsx_getOp("borderColour", "black"), 
                              borderStyle = "thin",
                              wrapText = TRUE)
  
  # add styles
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle1, cols = 1, rows = 1)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle2, cols = 1:3, rows = 3:4, gridExpand = TRUE)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle3, cols = 1:3, rows = 6, gridExpand = TRUE)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle4, cols = 1:2, rows = c(7:9, 11), gridExpand = TRUE)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle5, cols = 2, rows = 10)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle4, cols = 1, rows = 10)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle6, cols = 1, rows = 14)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle7, cols = 3, rows = 7:11, gridExpand = TRUE)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle3, cols = 2:3, rows = 14, gridExpand = TRUE)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle8, cols = 2:3, rows = 22, gridExpand = TRUE)
  addStyle(wb = wb, sheet = "Legend_Excluded_Proteins", style =  legendStyle7, cols = 2:3, rows = 15:20, gridExpand = TRUE)
  
  return(wb)
} ##### end of function 'MeCuP_addLegendExcludedProteins'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addLegendResults <- function (wb) {
  #input is an existing workbook
  ##### begin of function 'MeCuP_addLegendResults'
  
  # get an idea about the style options:
  # get some information from the prepared legend and its formatting following https://guslipkin.medium.com/making-pretty-excel-files-in-r-46a15c7a2ee8
  # get the sheet names, column heights and row widths
  # legendTable2 <- loadWorkbook("../resources/Legend_Table2_Excluded_Proteins.xlsx")
  # legendTable2
  
  # load the sheets and preview them
  # properly create from scratch
  #legendExcludedProteins <- readWorkbook(legendTable2, "Legend_Excluded_Proteins")
  # getStyles and set them appropriately
  #styles <- getStyles(legendTable2)
  #styles 
  
  # Add the text for the legend
  emptyLine <- c(NA,NA,NA)
  legendResults <- as.data.frame(rbind(c("Legend",NA,NA),
                                       emptyLine,
                                       c("Name of individual file:","MeCuP__Table1_Results", NA),
                                       c("Name of sheet in collection:","Results", NA),
                                       emptyLine,
                                       c("This will be the legend of the results' sheet", NA, NA)))
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Legend_Results")
  
  # write the data to the worksheet
  writeData(wb = wb, sheet = "Legend_Results", x = legendResults, colNames = FALSE)
  
  # Adjust some col widths
  setColWidths(wb = wb, sheet = "Legend_Results", cols = 1, widths = 27.45)
  setColWidths(wb = wb, sheet = "Legend_Results", cols = 2, widths = 40.62)
  setColWidths(wb = wb, sheet = "Legend_Results", cols = 3, widths = 105.9)
  
  # Adjust row heights
  setRowHeights(wb = wb, sheet = "Legend_Results", rows = 1, heights = 26)
  setRowHeights(wb = wb, sheet = "Legend_Results", rows = c(3,4,6), heights = 19)
  
  # create styles
  legendStyle1 <- createStyle(fontSize = 20, 
                              textDecoration = "BOLD", 
                              valign = "center")
  legendStyle2 <- createStyle(fontSize = 14, 
                              valign = "center")
  # add styles
  addStyle(wb = wb, sheet = "Legend_Results", style =  legendStyle1, cols = 1, rows = 1)
  addStyle(wb = wb, sheet = "Legend_Results", style =  legendStyle2, cols = 1:3, rows = 3:6, gridExpand = TRUE)
  
  return(wb)
} ##### end of function 'MeCuP_addLegendResults'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addLegendSampleListXlsx <- function (wb) {
  #input is an existing workbook
  ##### begin of function 'MeCuP_addLegendSampleListXlsx'
  
  # Add the text for the legend
  emptyLine <- c(NA,NA,NA)
  legendResults <- as.data.frame(rbind(c("Legend",NA,NA),
                                       emptyLine,
                                       c("Name of individual file:","MeCuP__Sample_List_BSA", NA),
                                       c("Name of sheet in collection:","Sample_List", NA),
                                       emptyLine,
                                       c("This will be the legend of the extended sample list's sheet", NA, NA)))
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Legend_Sample_List")
  
  # write the data to the worksheet
  writeData(wb = wb, sheet = "Legend_Sample_List", x = legendResults, colNames = FALSE)
  
  # Adjust some col widths
  setColWidths(wb = wb, sheet = "Legend_Sample_List", cols = 1, widths = 27.45)
  setColWidths(wb = wb, sheet = "Legend_Sample_List", cols = 2, widths = 40.62)
  setColWidths(wb = wb, sheet = "Legend_Sample_List", cols = 3, widths = 105.9)
  
  # Adjust row heights
  setRowHeights(wb = wb, sheet = "Legend_Sample_List", rows = 1, heights = 26)
  setRowHeights(wb = wb, sheet = "Legend_Sample_List", rows = c(3,4,6), heights = 19)
  
  # create styles
  legendStyle1 <- createStyle(fontSize = 20, 
                              textDecoration = "BOLD", 
                              valign = "center")
  legendStyle2 <- createStyle(fontSize = 14, 
                              valign = "center")
  # add styles
  addStyle(wb = wb, sheet = "Legend_Sample_List", style =  legendStyle1, cols = 1, rows = 1)
  addStyle(wb = wb, sheet = "Legend_Sample_List", style =  legendStyle2, cols = 1:3, rows = 3:6, gridExpand = TRUE)
  
  return(wb)
} ##### end of function 'MeCuP_addLegendSampleListXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addLegendSelectedArgumentsXlsx <- function(wb) {
  #input is an existing workbook
  ##### begin of function 'MeCuP_addLegendSelectedArgumentsXlsx'
  
  # Add the text for the legend
  emptyLine <- c(NA,NA,NA)
  legendResults <- as.data.frame(rbind(c("Legend",NA,NA),
                                       emptyLine,
                                       c("Name of individual file:","MeCuP__Selected_Arguments", NA),
                                       c("Name of sheet in collection:","Selected_Arguments", NA),
                                       emptyLine,
                                       c("This will be the legend of the selected arguments' sheet", NA, NA)))
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Legend_Selected_Arguments")
  
  # write the data to the worksheet
  writeData(wb = wb, sheet = "Legend_Selected_Arguments", x = legendResults, colNames = FALSE)
  
  # Adjust some col widths
  setColWidths(wb = wb, sheet = "Legend_Selected_Arguments", cols = 1, widths = 27.45)
  setColWidths(wb = wb, sheet = "Legend_Selected_Arguments", cols = 2, widths = 40.62)
  setColWidths(wb = wb, sheet = "Legend_Selected_Arguments", cols = 3, widths = 105.9)
  
  # Adjust row heights
  setRowHeights(wb = wb, sheet = "Legend_Selected_Arguments", rows = 1, heights = 26)
  setRowHeights(wb = wb, sheet = "Legend_Selected_Arguments", rows = c(3,4,6), heights = 19)
  
  # create styles
  legendStyle1 <- createStyle(fontSize = 20, 
                              textDecoration = "BOLD", 
                              valign = "center")
  legendStyle2 <- createStyle(fontSize = 14, 
                              valign = "center")
  # add styles
  addStyle(wb = wb, sheet = "Legend_Selected_Arguments", style =  legendStyle1, cols = 1, rows = 1)
  addStyle(wb = wb, sheet = "Legend_Selected_Arguments", style =  legendStyle2, cols = 1:3, rows = 3:6, gridExpand = TRUE)
  
  return(wb)
} ##### end of function 'MeCuP_addLegendSelectedArgumentsXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addResultsXlsx <- function (wb, PATH, PLOT, SELECTEDPROTEINSARGUMENT) {
  #input is an existing workbook, the path to derive the results data.frame path, the selected PLOT and selectedPROTEINSarg input arguments.
  ##### begin of function 'MeCuP_addResultsXlsx'
  
  # Read data from the MeCuP output
  df <- read.table(paste0(PATH, "output_detailed/", "MeCuP__Table1_Results.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
  
  MeCuP_plot <- MeCuP_createPngColumn(PLOT, SELECTEDPROTEINSARGUMENT, PATH)
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Results")
  
  # write the data to the worksheet and add a column with links to outout plots if available
  writeData(wb, sheet="Results", x=df[,c(1:3)], startCol=1, 
            startRow = 1, keepNA = TRUE)
  writeData(wb, sheet = "Results", x = "MeCuP_plot", startCol = 4, 
            startRow = 1, keepNA = TRUE)
  writeData(wb, sheet = "Results", x = MeCuP_plot, startCol = 4, 
            startRow = 2, keepNA = TRUE)
  writeData(wb, sheet="Results", x=df[,c(4:dim(df)[2])], startCol=5, 
            startRow = 1, keepNA = TRUE)
  
  return(wb)
} ##### end of function 'MeCuP_addResultsXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addSampleListXlsx <- function (wb, SAM) {
  #input is an existing workbook and the Sample list from the MeCuP script at the end of the script
  ##### begin of function 'MeCuP_addSampleListXlsx'
  
  # Read data from the MeCuP output
  df <- SAM

  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Sample_List")
  
  # write the data to the worksheet
  writeData(wb = wb, sheet = "Sample_List", x = df, colNames = TRUE)
  
  # add style separating thousands with "," and using "." as the decimal sign with 2 decimal digits used for the temperature.
  addStyle(wb = wb, sheet = "Sample_List", style = createStyle(numFmt = "0.00"), rows = 1:(dim(SAM)[1] + 1), cols = match("Temperature",names(SAM)), gridExpand = T)
  
  return(wb)
  
} ##### end of function 'MeCuP_addSampleListXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addSelectedArgumentsXlsx <- function(wb, PATH) {
  #input is an existing workbook and the Selected Arguments as stroed in a respective output file
  ##### begin of function 'MeCuP_addSelectedArgumentsXlsx'
  
  # Read data from the MeCuP output
  df <- read.table(paste0(PATH, "output_detailed/", "MeCuP__Selected_Arguments.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
  
  # add a new worksheet
  addWorksheet(wb = wb, sheetName = "Selected_Arguments")
  
  # write the data to the worksheet
  writeData(wb = wb, sheet = "Selected_Arguments", x = df, colNames = TRUE)
  return(wb)
  
} ##### end of function 'MeCuP_addSelectedArgumentsXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_addTOCOutputXlsx <- function (wb, XLSX_OUTPUT_LEGEND) {
  #input is an existing workbook
  ##### begin of function 'MeCuP_addLegendOutputXlsx'
  
  if (XLSX_OUTPUT_LEGEND == TRUE) {
    # Add the text for the legend
    emptyLine <- c(NA,NA,NA)
    legendOutput <- as.data.frame(rbind(c("TOC",NA,NA),
                                        emptyLine,
                                        c("Number","Name of sheet", "Description"),
                                        c("1","TOC", "Table of Content"),
                                        c("2","Legend_Results", "Description"),
                                        c("3","Results", "Description"),
                                        c("4","Legend_Excluded_Proteins", "Description"),
                                        c("5","Excluded_Proteins", "Description"),
                                        c("6","Legend_Sample_List", "Description"),
                                        c("7","Sample_List", "Description"),
                                        c("8","Legend_Selected_Arguments", "Description"),
                                        c("9","Selected_Arguments", "Description")
    ))
    
    # add a new worksheet
    addWorksheet(wb = wb, sheetName = "TOC")
    
    # write the data to the worksheet
    writeData(wb = wb, sheet = "TOC", x = legendOutput, colNames = FALSE)
    
    # Adjust some col widths
    setColWidths(wb = wb, sheet = "TOC", cols = 1, widths = 8)
    setColWidths(wb = wb, sheet = "TOC", cols = 2, widths = 24.5)
    setColWidths(wb = wb, sheet = "TOC", cols = 3, widths = 105.9)
    
    # Adjust row heights
    setRowHeights(wb = wb, sheet = "TOC", rows = 1, heights = 26)
    
    # create styles
    legendStyle1 <- createStyle(fontSize = 20, 
                                textDecoration = "BOLD", 
                                valign = "center")
    legendStyle2 <- createStyle(fontSize = 12, 
                                textDecoration = "BOLD", 
                                valign = "center", 
                                border = c("top", "bottom", "left", "right"), 
                                borderColour = openxlsx_getOp("borderColour", "black"), 
                                borderStyle = c("thin", "thin", "thin", "thin"),
                                fgFill = "#E7E6E6",
                                bgFill = "black") # Headers in grey boxes
    legendStyle3 <- createStyle(fontSize = 12, 
                                valign = "center", 
                                halign = "justify",
                                border = c("top", "bottom", "left", "right"), 
                                borderColour = openxlsx_getOp("borderColour", "black"), 
                                borderStyle = c("thin", "thin", "thin", "thin"),
                                fgFill = "#E7E6E6",
                                bgFill = "black",
                                wrapText = TRUE)
    # add styles
    addStyle(wb = wb, sheet = "TOC", style =  legendStyle1, cols = 1, rows = 1)
    addStyle(wb = wb, sheet = "TOC", style =  legendStyle2, cols = 1:3, rows = 3, gridExpand = TRUE)
    addStyle(wb = wb, sheet = "TOC", style =  legendStyle3, cols = 1:3, rows = 4:12, gridExpand = TRUE)
    
    return(wb)
  }else{
    # Add the text for the legend
    emptyLine <- c(NA,NA,NA)
    legendOutput <- as.data.frame(rbind(c("TOC",NA,NA),
                                        emptyLine,
                                        c("Number","Name of sheet", "Description"),
                                        c("1","TOC", "Table of Content"),
                                        c("2","Results", ""),
                                        c("3","Excluded_Proteins", ""),
                                        c("4","Sample_List", ""),
                                        c("5","Selected_Arguments", "")
    ))
    
    # add a new worksheet
    addWorksheet(wb = wb, sheetName = "TOC")
    
    # write the data to the worksheet
    writeData(wb = wb, sheet = "TOC", x = legendOutput, colNames = FALSE)
    
    # Adjust some col widths
    setColWidths(wb = wb, sheet = "TOC", cols = 1, widths = 8)
    setColWidths(wb = wb, sheet = "TOC", cols = 2, widths = 17.33)
    setColWidths(wb = wb, sheet = "TOC", cols = 3, widths = 105.9)
    
    # Adjust row heights
    setRowHeights(wb = wb, sheet = "TOC", rows = 1, heights = 26)
    
    # create styles
    legendStyle1 <- createStyle(fontSize = 20, 
                                textDecoration = "BOLD", 
                                valign = "center")
    legendStyle2 <- createStyle(fontSize = 12, 
                                textDecoration = "BOLD", 
                                valign = "center", 
                                border = c("top", "bottom", "left", "right"), 
                                borderColour = openxlsx_getOp("borderColour", "black"), 
                                borderStyle = c("thin", "thin", "thin", "thin"),
                                fgFill = "#E7E6E6",
                                bgFill = "black") # Headers in grey boxes
    legendStyle3 <- createStyle(fontSize = 12, 
                                valign = "center", 
                                halign = "justify",
                                border = c("top", "bottom", "left", "right"), 
                                borderColour = openxlsx_getOp("borderColour", "black"), 
                                borderStyle = c("thin", "thin", "thin", "thin"),
                                fgFill = "#E7E6E6",
                                bgFill = "black",
                                wrapText = TRUE)
    # add styles
    addStyle(wb = wb, sheet = "TOC", style =  legendStyle1, cols = 1, rows = 1)
    addStyle(wb = wb, sheet = "TOC", style =  legendStyle2, cols = 1:3, rows = 3, gridExpand = TRUE)
    addStyle(wb = wb, sheet = "TOC", style =  legendStyle3, cols = 1:3, rows = 4:8, gridExpand = TRUE)
    
    return(wb)
  }
} ##### end of function 'MeCuP_addLegendOutputXlsx'

################################################################################################################################################################################################################################################################################################################################

MeCuP_add_gitkeep <- function(PATH) {
  # "MeCuP_add_gitkeep" checks if a directory is empty and creates a .gitkeep file in this directory if there is no .gitkeep file in the directory
  # Input: Path of the directory to be checked
  if ((length(list.files(PATH)) == 0) & (!(file.exists(paste0(PATH, ".gitkeep"))))) {
    file.create(paste0(PATH, ".gitkeep"))
  }
} ##### end of function 'MeCuP_add_gitkeep'

################################################################################################################################################################################################################################################################################################################################

MeCuP__createArgumentsDF <- function(TYPE, ASSAY, name_input_file, name_sample_list_file, repeats, ANNO, 
                                     selectedPROTEINS, selectedPROTEINSfilename, THRESH_BSA, THRESH, 
                                     SPmean_filtering, NORM, SPmean_THRESH_type, SPmean_THRESH, SPmeanNORM, 
                                     PLOT, colour_values, sp_mean_filter_effect, XLSX_OUTPUT_LEGEND, plotSetting, 
                                     geom_POINT, LOESS_LINEWIDTH, y_ticks_SPACING, title_SIZE, title_FACE, 
                                     title_COLOR, x_axis_TITLE_SIZE, y_axis_TITLE_SIZE, axis_TEXT_SIZE, legend_TITLE_SIZE, 
                                     legend_TEXT_SIZE, png_UNITS, png_WIDTH, png_HEIGHT, png_RESOLUTION, 
                                     x_axis_INTERCEPT_LINEWIDTH, x_MeCuP_results_TEXT, y_MeCuP_results_TEXT, 
                                     MeCuP_results_TEXT_SIZE, MeCuP_results_TEXT_COLOR, annotation_LINEBREAK) {
  # MeCuP__createArgumentsDF writes arguments from the script for option 3 to a data.frame for documentation 
  # using MeCuP_Arguments_INPUT.csv from the resources directory.
  ##### begin of function 'MeCuP__createArgumentsDF'
  
  print("Reading arguments from script _ ONLY FOR EXPERTS.\n\n")
  
  # Only the ASSAY name is checked here as it is also immediately checked after the user inputs above. 
  # Check if the assay directory is there, otherwise: error.
  if (dir.exists(paste0("../assays/", ASSAY, "/"))) {
    print(paste0("Assay: '", ASSAY, "'"))
  } else {
    stop(print(paste("The assay" , ASSAY, "does not exist.\n The assay MUST be equal to a sub-directory name of the assay folder inside the ARC with this script.")))
  }
  
  # Read default arguments from the resources directory
  ARGUMENTS <- read.csv(file = paste0(sub("/workflows$", "", dirname(rstudioapi::getActiveDocumentContext()$path)), "/resources/MeCuP_Arguments_INPUT.csv"), header = TRUE, sep = ";", as.is=TRUE)
  
  # Remove rows without parameter names in the first column - if any
  ARGUMENTS <- ARGUMENTS[!(ARGUMENTS[,1] == ""),]
  
  # Set all default arguments to NULL and successively replace these with the selected arguments
  ARGUMENTS$SelectedArgument <- NA
  
  # Add the selected arguments from the script
  ARGUMENTS[ARGUMENTS$Parameter == "TYPE",]$SelectedArgument <- TYPE
  ARGUMENTS[ARGUMENTS$Parameter == "ASSAY",]$SelectedArgument <- ASSAY
  ARGUMENTS[ARGUMENTS$Parameter == "name_input_file",]$SelectedArgument <- name_input_file
  ARGUMENTS[ARGUMENTS$Parameter == "name_sample_list_file",]$SelectedArgument <- name_sample_list_file
  ARGUMENTS[ARGUMENTS$Parameter == "repeats",]$SelectedArgument <- as.numeric(repeats)
  ARGUMENTS[ARGUMENTS$Parameter == "ANNO",]$SelectedArgument <- ANNO
  ARGUMENTS[ARGUMENTS$Parameter == "selectedPROTEINS",]$SelectedArgument <- selectedPROTEINS
  ARGUMENTS[ARGUMENTS$Parameter == "selectedPROTEINSfilename",]$SelectedArgument <- selectedPROTEINSfilename
  ARGUMENTS[ARGUMENTS$Parameter == "THRESH_BSA",]$SelectedArgument <- as.numeric(THRESH_BSA)
  ARGUMENTS[ARGUMENTS$Parameter == "THRESH",]$SelectedArgument <- as.numeric(THRESH)
  ARGUMENTS[ARGUMENTS$Parameter == "SPmean_filtering",]$SelectedArgument <- SPmean_filtering
  
  if (NORM %in% c(NA)) {
    ARGUMENTS[ARGUMENTS$Parameter == "NORM",]$SelectedArgument <- NORM
  }else{
    ARGUMENTS[ARGUMENTS$Parameter == "NORM",]$SelectedArgument <- as.numeric(NORM)
  }
  
  ARGUMENTS[ARGUMENTS$Parameter == "SPmean_THRESH_type",]$SelectedArgument <- SPmean_THRESH_type
  ARGUMENTS[ARGUMENTS$Parameter == "SPmean_THRESH",]$SelectedArgument <- as.numeric(SPmean_THRESH)
  ARGUMENTS[ARGUMENTS$Parameter == "SPmeanNORM",]$SelectedArgument <- SPmeanNORM
  ARGUMENTS[ARGUMENTS$Parameter == "PLOT",]$SelectedArgument <- PLOT
  ARGUMENTS[ARGUMENTS$Parameter == "colour_values",]$SelectedArgument <- paste(colour_values, collapse = ", ")
  ARGUMENTS[ARGUMENTS$Parameter == "sp_mean_filter_effect",]$SelectedArgument <- sp_mean_filter_effect
  ARGUMENTS[ARGUMENTS$Parameter == "XLSX_OUTPUT_LEGEND",]$SelectedArgument <- XLSX_OUTPUT_LEGEND
  ARGUMENTS[ARGUMENTS$Parameter == "plotSetting",]$SelectedArgument <- plotSetting
  ARGUMENTS[ARGUMENTS$Parameter == "geom_POINT",]$SelectedArgument <- as.numeric(geom_POINT)
  ARGUMENTS[ARGUMENTS$Parameter == "LOESS_LINEWIDTH",]$SelectedArgument <- as.numeric(LOESS_LINEWIDTH)
  ARGUMENTS[ARGUMENTS$Parameter == "y_ticks_SPACING",]$SelectedArgument <- as.numeric(y_ticks_SPACING)
  ARGUMENTS[ARGUMENTS$Parameter == "title_SIZE",]$SelectedArgument <- as.numeric(title_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "title_FACE",]$SelectedArgument <- title_FACE
  ARGUMENTS[ARGUMENTS$Parameter == "title_COLOR",]$SelectedArgument <- title_COLOR
  ARGUMENTS[ARGUMENTS$Parameter == "x_axis_TITLE_SIZE",]$SelectedArgument <- as.numeric(x_axis_TITLE_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "y_axis_TITLE_SIZE",]$SelectedArgument <- as.numeric(y_axis_TITLE_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "axis_TEXT_SIZE",]$SelectedArgument <- as.numeric(axis_TEXT_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "legend_TITLE_SIZE",]$SelectedArgument <- as.numeric(legend_TITLE_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "legend_TEXT_SIZE",]$SelectedArgument <- as.numeric(legend_TEXT_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "png_UNITS",]$SelectedArgument <- png_UNITS
  ARGUMENTS[ARGUMENTS$Parameter == "png_WIDTH",]$SelectedArgument <- as.numeric(png_WIDTH)
  ARGUMENTS[ARGUMENTS$Parameter == "png_HEIGHT",]$SelectedArgument <- as.numeric(png_HEIGHT)
  ARGUMENTS[ARGUMENTS$Parameter == "png_RESOLUTION",]$SelectedArgument <- as.numeric(png_RESOLUTION)
  ARGUMENTS[ARGUMENTS$Parameter == "x_axis_INTERCEPT_LINEWIDTH",]$SelectedArgument <- as.numeric(x_axis_INTERCEPT_LINEWIDTH)  
  ARGUMENTS[ARGUMENTS$Parameter == "x_MeCuP_results_TEXT",]$SelectedArgument <- as.numeric(x_MeCuP_results_TEXT)
  ARGUMENTS[ARGUMENTS$Parameter == "y_MeCuP_results_TEXT",]$SelectedArgument <- as.numeric(y_MeCuP_results_TEXT)
  ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_SIZE",]$SelectedArgument <- as.numeric(MeCuP_results_TEXT_SIZE)
  ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_COLOR",]$SelectedArgument <- MeCuP_results_TEXT_COLOR
  ARGUMENTS[ARGUMENTS$Parameter == "annotation_LINEBREAK",]$SelectedArgument <- as.numeric(annotation_LINEBREAK)
  
  # Over writing custom arguments with the "highResolution" plot settings if "highResolution" is selected for the plotSetting parameter:
  
  if (ARGUMENTS[ARGUMENTS$Parameter == "plotSetting",]$SelectedArgument == "highResolution") {
    ARGUMENTS[ARGUMENTS$Parameter == "geom_POINT",]$SelectedArgument = 1
    ARGUMENTS[ARGUMENTS$Parameter == "LOESS_LINEWIDTH",]$SelectedArgument = 0.75
    ARGUMENTS[ARGUMENTS$Parameter == "y_ticks_SPACING",]$SelectedArgument = 0.25
    ARGUMENTS[ARGUMENTS$Parameter == "title_SIZE",]$SelectedArgument = 8.8
    ARGUMENTS[ARGUMENTS$Parameter == "x_axis_TITLE_SIZE",]$SelectedArgument = 12
    ARGUMENTS[ARGUMENTS$Parameter == "y_axis_TITLE_SIZE",]$SelectedArgument = 12
    ARGUMENTS[ARGUMENTS$Parameter == "axis_TEXT_SIZE",]$SelectedArgument = 13
    ARGUMENTS[ARGUMENTS$Parameter == "legend_TITLE_SIZE",]$SelectedArgument = 11
    ARGUMENTS[ARGUMENTS$Parameter == "legend_TEXT_SIZE",]$SelectedArgument = 10
    ARGUMENTS[ARGUMENTS$Parameter == "png_UNITS",]$SelectedArgument = "px"
    ARGUMENTS[ARGUMENTS$Parameter == "png_WIDTH",]$SelectedArgument = 960
    ARGUMENTS[ARGUMENTS$Parameter == "png_HEIGHT",]$SelectedArgument = 960
    ARGUMENTS[ARGUMENTS$Parameter == "png_RESOLUTION",]$SelectedArgument = 180
    ARGUMENTS[ARGUMENTS$Parameter == "x_axis_INTERCEPT_LINEWIDTH",]$SelectedArgument = 0.5
    ARGUMENTS[ARGUMENTS$Parameter == "x_MeCuP_results_TEXT",]$SelectedArgument = 0.795
    ARGUMENTS[ARGUMENTS$Parameter == "y_MeCuP_results_TEXT",]$SelectedArgument = 0.315
    ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_SIZE",]$SelectedArgument = 7
    ARGUMENTS[ARGUMENTS$Parameter == "annotation_LINEBREAK",]$SelectedArgument = 55
  }
  
  # Over writing custom arguments with the "lowResolution" plot settings if "lowResolution" is selected for the plotSetting parameter:
  
  if (ARGUMENTS[ARGUMENTS$Parameter == "plotSetting",]$SelectedArgument == "lowResolution") {
    ARGUMENTS[ARGUMENTS$Parameter == "geom_POINT",]$SelectedArgument = 1.5
    ARGUMENTS[ARGUMENTS$Parameter == "LOESS_LINEWIDTH",]$SelectedArgument = 1
    ARGUMENTS[ARGUMENTS$Parameter == "y_ticks_SPACING",]$SelectedArgument = 0.25
    ARGUMENTS[ARGUMENTS$Parameter == "title_SIZE",]$SelectedArgument = 11
    ARGUMENTS[ARGUMENTS$Parameter == "x_axis_TITLE_SIZE",]$SelectedArgument = 14
    ARGUMENTS[ARGUMENTS$Parameter == "y_axis_TITLE_SIZE",]$SelectedArgument = 14
    ARGUMENTS[ARGUMENTS$Parameter == "axis_TEXT_SIZE",]$SelectedArgument = 14
    ARGUMENTS[ARGUMENTS$Parameter == "legend_TITLE_SIZE",]$SelectedArgument = 14
    ARGUMENTS[ARGUMENTS$Parameter == "legend_TEXT_SIZE",]$SelectedArgument = 12
    ARGUMENTS[ARGUMENTS$Parameter == "png_UNITS",]$SelectedArgument = "px"
    ARGUMENTS[ARGUMENTS$Parameter == "png_WIDTH",]$SelectedArgument = 480
    ARGUMENTS[ARGUMENTS$Parameter == "png_HEIGHT",]$SelectedArgument = 480
    ARGUMENTS[ARGUMENTS$Parameter == "png_RESOLUTION",]$SelectedArgument = 72
    ARGUMENTS[ARGUMENTS$Parameter == "x_axis_INTERCEPT_LINEWIDTH",]$SelectedArgument = 0.5
    ARGUMENTS[ARGUMENTS$Parameter == "x_MeCuP_results_TEXT",]$SelectedArgument = 0.815
    ARGUMENTS[ARGUMENTS$Parameter == "y_MeCuP_results_TEXT",]$SelectedArgument = 0.32
    ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_SIZE",]$SelectedArgument = 9
    ARGUMENTS[ARGUMENTS$Parameter == "annotation_LINEBREAK",]$SelectedArgument = 55
  }
  
  # Over writing custom arguments with the "publicationResolution" plot settings if "publicationResolution" is selected for the plotSetting parameter:
  
  if (ARGUMENTS[ARGUMENTS$Parameter == "plotSetting",]$SelectedArgument == "publicationResolution") {
    ARGUMENTS[ARGUMENTS$Parameter == "geom_POINT",]$SelectedArgument = 1.3
    ARGUMENTS[ARGUMENTS$Parameter == "LOESS_LINEWIDTH",]$SelectedArgument = 0.9
    ARGUMENTS[ARGUMENTS$Parameter == "y_ticks_SPACING",]$SelectedArgument = 0.25
    ARGUMENTS[ARGUMENTS$Parameter == "title_SIZE",]$SelectedArgument = 10.75
    ARGUMENTS[ARGUMENTS$Parameter == "x_axis_TITLE_SIZE",]$SelectedArgument = 14
    ARGUMENTS[ARGUMENTS$Parameter == "y_axis_TITLE_SIZE",]$SelectedArgument = 14
    ARGUMENTS[ARGUMENTS$Parameter == "axis_TEXT_SIZE",]$SelectedArgument = 15
    ARGUMENTS[ARGUMENTS$Parameter == "legend_TITLE_SIZE",]$SelectedArgument = 13
    ARGUMENTS[ARGUMENTS$Parameter == "legend_TEXT_SIZE",]$SelectedArgument = 12
    ARGUMENTS[ARGUMENTS$Parameter == "png_UNITS",]$SelectedArgument = "px"
    ARGUMENTS[ARGUMENTS$Parameter == "png_WIDTH",]$SelectedArgument = 1920
    ARGUMENTS[ARGUMENTS$Parameter == "png_HEIGHT",]$SelectedArgument = 1920
    ARGUMENTS[ARGUMENTS$Parameter == "png_RESOLUTION",]$SelectedArgument = 300
    ARGUMENTS[ARGUMENTS$Parameter == "x_axis_INTERCEPT_LINEWIDTH",]$SelectedArgument = 0.6
    ARGUMENTS[ARGUMENTS$Parameter == "x_MeCuP_results_TEXT",]$SelectedArgument = 0.808
    ARGUMENTS[ARGUMENTS$Parameter == "y_MeCuP_results_TEXT",]$SelectedArgument = 0.32
    ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_SIZE",]$SelectedArgument = 9
    ARGUMENTS[ARGUMENTS$Parameter == "annotation_LINEBREAK",]$SelectedArgument = 55
  }
  
  return(ARGUMENTS)
} ##### end of function 'MeCuP__createArgumentsDF'

################################################################################################################################################################################################################################################################################################################################

MeCuP_createPngColumn <- function (PLOT, SELECTEDPROTEINSARGUMENT, PATH) {
  #input is the path, the selected PLOT and selectedPROTEINSarg input arguments
  ##### begin of function 'MeCuP_createPngColumn'
  
  # get MeCuP__Table1_Results
  df <- read.table(paste0(PATH, "output_detailed/", "MeCuP__Table1_Results.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
  
  # Adjust the paths according to the selected plot behavior and/or use NA and add a txt file if the respective plots have not been created. 
  # The txt file describes why the plot can not shown and that this is due to the plotting settings.
  MeCuP_plot <- rep(NA, length(df$First.Majority.protein.ID))
  
  # Write the txt file explaining the hyperlink "NA" in the "Results" sheet of the output file.
  writeLines(paste0("This file is for informing the user when clicking on a link for a MeCuP plot with the name 'NA' that there is no png file for this protein likely due to the selected PLOT argument or a restricted protein list used in this MeCuP run.\n\nSelected proteins argument: ", SELECTEDPROTEINSARGUMENT, "\nSelected PLOT argument: ", PLOT), paste0(PATH, "output/naPlotInfo", ".txt"))
  
  if ((PLOT == TRUE) | (PLOT == "ALL_and_Tm50_NO")) {
    names_vector <- c()
    for (i in c(1:length(df$First.Majority.protein.ID))) {
      if (!(file.exists(paste0(PATH, "output_detailed/plots_all/mecup_Tm50/", df$First.Majority.protein.ID[i], ".png")))) {
        MeCuP_plot[i] <- paste0("../output/naPlotInfo", ".txt")
        names_vector <- c(names_vector,"NA")
      }
      if (file.exists(paste0(PATH, "output_detailed", "/plots_all/mecup_Tm50/", df$First.Majority.protein.ID[i], ".png"))) {
        MeCuP_plot[i] <- paste0("../output_detailed", "/plots_all/mecup_Tm50/", df$First.Majority.protein.ID[i], ".png")
        names_vector <- c(names_vector,df$First.Majority.protein.ID[i])
      }
    }
    
  } else if (PLOT == "Tm50_NO") {
    MeCuP_plot <- c(paste0("./plots_selected/mecup_Tm50_no_overlap/", df$First.Majority.protein.ID, ".png"))
    
    names_vector <- c()
    for (i in c(1:length(df$First.Majority.protein.ID))) {
      if (!(file.exists(paste0(PATH, "output", "/plots_selected/mecup_Tm50_no_overlap/", df$First.Majority.protein.ID[i], ".png")))) {
        MeCuP_plot[i] <- paste0("../output/naPlotInfo", ".txt")
        names_vector <- c(names_vector,"NA")
      }
      if (file.exists(paste0(PATH, "output", "/plots_selected/mecup_Tm50_no_overlap/", df$First.Majority.protein.ID[i], ".png"))) {
        MeCuP_plot[i] <- paste0("../output", "/plots_selected/mecup_Tm50_no_overlap/", df$First.Majority.protein.ID[i], ".png")
        names_vector <- c(names_vector,df$First.Majority.protein.ID[i])
      }
    }
    
  } else {
    MeCuP_plot <- rep(paste0("../output/naPlotInfo", ".txt"), length(df$First.Majority.protein.ID))
    names_vector <- rep("NA", length(df$First.Majority.protein.ID))
  }
  
  names(MeCuP_plot) <- names_vector
  class(MeCuP_plot) <- "hyperlink"
  
  return(MeCuP_plot)
} ##### end of function 'MeCuP_createPngColumn'

################################################################################################################################################################################################################################################################################################################################

MeCuP_CreateResultsPathList <- function(PATH, SPMEAN_FILTER) {
  # input
  ##### begin of function 'MeCuP_CreateResultsPathList'
  
  path1 <- gsub("noFiltering", "Filtered", PATH)    # filtered
  path2 <- gsub("Filtered", "noFiltering", path1)   # not filtered
  
  if (SPMEAN_FILTER %in% c("both")) {
    path_list <- c(path1, path2)
  }else{
    path_list <- c(PATH)
  }
  return(path_list)
} ##### end of function 'MeCuP_CreateResultsPathList'

################################################################################################################################################################################################################################################################################################################################

MeCuP_exclude_prot<- function(MQ_DF, SELECTION, COLUMNS, REASON, EXCLUDE_DF) {
  # Function for excluding proteins from MQin_Xtract with a selection criterion and specific columns in line with the respective exclusion data.frame collecting information on the excluded proteins.
  # Input
  ##### begin of function 'MeCuP_exclude_prot'
  if (length(MQ_DF[SELECTION,1]) != 0) {
    EXCLUDE <- MQ_DF[SELECTION,COLUMNS]
    EXCLUDE$Reason4Exclusion <- REASON
    EXCLUDE_DF <- rbind(EXCLUDE_DF, EXCLUDE[, c(COLUMNS[c(1:3)], "Reason4Exclusion", COLUMNS[c(4:(length(COLUMNS)))])])
  }
  return(EXCLUDE_DF)
} ##### end of function 'MeCuP_exclude_prot'

################################################################################################################################################################################################################################################################################################################################

MeCuP__extractArgumentsFromInput <- function(ARGUMENTS_INPUT, ARGUMENTS) {
  # Extract arguments.
  # Input is the user selected option for reading in the arguments 
  # and the arguments dataframe read in from the respectively selected source.
  ##### begin of function 'MeCuP_exclude_prot'
    
  ## READ
  TYPE <- ARGUMENTS[ARGUMENTS$Parameter == "TYPE", ]$SelectedArgument
  ASSAY <- ARGUMENTS[ARGUMENTS$Parameter == "ASSAY", ]$SelectedArgument
  name_input_file <- ARGUMENTS[ARGUMENTS$Parameter == "name_input_file", ]$SelectedArgument
  name_sample_list_file <- ARGUMENTS[ARGUMENTS$Parameter == "name_sample_list_file", ]$SelectedArgument
  repeats <- as.numeric(ARGUMENTS[ARGUMENTS$Parameter == "repeats", ]$SelectedArgument)
  ANNO <- ARGUMENTS[ARGUMENTS$Parameter == "ANNO", ]$SelectedArgument
  selectedPROTEINS <- ARGUMENTS[ARGUMENTS$Parameter == "selectedPROTEINS", ]$SelectedArgument
  
  if (selectedPROTEINS == "list"){
    selectedPROTEINSfilename <- ARGUMENTS[ARGUMENTS$Parameter == "selectedPROTEINSfilename", ]$SelectedArgument
  }else{
    selectedPROTEINS <- c(selectedPROTEINS)
    selectedPROTEINSfilename <- ""
  }
  
  THRESH_BSA <- as.numeric(ARGUMENTS[ARGUMENTS$Parameter == "THRESH_BSA", ]$SelectedArgument)
  THRESH <- as.numeric(ARGUMENTS[ARGUMENTS$Parameter == "THRESH", ]$SelectedArgument)
  SPmean_filtering <- ARGUMENTS[ARGUMENTS$Parameter == "SPmean_filtering", ]$SelectedArgument
  
  if (!(is.na(ARGUMENTS[ARGUMENTS$Parameter == "NORM", ]$SelectedArgument))){
    NORM <- as.numeric(ARGUMENTS[ARGUMENTS$Parameter == "NORM", ]$SelectedArgument)
  }else{
    NORM <- ARGUMENTS[ARGUMENTS$Parameter == "NORM", ]$SelectedArgument
  }
  
  SPmean_THRESH_type <- ARGUMENTS[ARGUMENTS$Parameter == "SPmean_THRESH_type", ]$SelectedArgument
  SPmean_THRESH <- as.numeric(ARGUMENTS[ARGUMENTS$Parameter == "SPmean_THRESH", ]$SelectedArgument)
  SPmeanNORM <- ARGUMENTS[ARGUMENTS$Parameter == "SPmeanNORM", ]$SelectedArgument
  PLOT <- ARGUMENTS[ARGUMENTS$Parameter == "PLOT", ]$SelectedArgument
  
  colours <- strsplit(unlist(as.character(lapply((ARGUMENTS[ARGUMENTS$Parameter == "colour_values", ]$SelectedArgument), function(x) gsub("\"", "",  x)))), ",")
  
  colour_values <- c()
  for (colour in colours){
    colour_values <- c(colour_values, colour)
  }
  
  colour_values <- unlist(as.character(lapply(colour_values, function(x) gsub(" ", "",  x))))
  
  sp_mean_filter_effect <- ARGUMENTS[ARGUMENTS$Parameter == "sp_mean_filter_effect", ]$SelectedArgument
  XLSX_OUTPUT_LEGEND <- ARGUMENTS[ARGUMENTS$Parameter == "XLSX_OUTPUT_LEGEND", ]$SelectedArgument
  plotSetting <- ARGUMENTS[ARGUMENTS$Parameter == "plotSetting", ]$SelectedArgument
  geom_POINT <- ARGUMENTS[ARGUMENTS$Parameter == "geom_POINT", ]$SelectedArgument
  LOESS_LINEWIDTH <- ARGUMENTS[ARGUMENTS$Parameter == "LOESS_LINEWIDTH", ]$SelectedArgument
  y_ticks_SPACING <- ARGUMENTS[ARGUMENTS$Parameter == "y_ticks_SPACING", ]$SelectedArgument
  title_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "title_SIZE", ]$SelectedArgument
  title_FACE <- ARGUMENTS[ARGUMENTS$Parameter == "title_FACE", ]$SelectedArgument
  title_COLOR <- ARGUMENTS[ARGUMENTS$Parameter == "title_COLOR", ]$SelectedArgument
  x_axis_TITLE_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "x_axis_TITLE_SIZE", ]$SelectedArgument
  y_axis_TITLE_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "y_axis_TITLE_SIZE", ]$SelectedArgument
  axis_TEXT_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "axis_TEXT_SIZE", ]$SelectedArgument
  legend_TITLE_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "legend_TITLE_SIZE", ]$SelectedArgument
  legend_TEXT_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "legend_TEXT_SIZE", ]$SelectedArgument
  png_UNITS <- ARGUMENTS[ARGUMENTS$Parameter == "png_UNITS", ]$SelectedArgument
  png_WIDTH <- ARGUMENTS[ARGUMENTS$Parameter == "png_WIDTH", ]$SelectedArgument
  png_HEIGHT <- ARGUMENTS[ARGUMENTS$Parameter == "png_HEIGHT", ]$SelectedArgument
  png_RESOLUTION <- ARGUMENTS[ARGUMENTS$Parameter == "png_RESOLUTION", ]$SelectedArgument
  x_axis_INTERCEPT_LINEWIDTH <- ARGUMENTS[ARGUMENTS$Parameter == "x_axis_INTERCEPT_LINEWIDTH", ]$SelectedArgument
  x_MeCuP_results_TEXT <- ARGUMENTS[ARGUMENTS$Parameter == "x_MeCuP_results_TEXT", ]$SelectedArgument
  y_MeCuP_results_TEXT <- ARGUMENTS[ARGUMENTS$Parameter == "y_MeCuP_results_TEXT", ]$SelectedArgument
  MeCuP_results_TEXT_SIZE <- ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_SIZE", ]$SelectedArgument
  MeCuP_results_TEXT_COLOR <- ARGUMENTS[ARGUMENTS$Parameter == "MeCuP_results_TEXT_COLOR", ]$SelectedArgument
  annotation_LINEBREAK <- ARGUMENTS[ARGUMENTS$Parameter == "annotation_LINEBREAK", ]$SelectedArgument

  return(list("TYPE" = as.character(TYPE), 
              "ASSAY" = as.character(ASSAY), 
              "name_input_file" = as.character(name_input_file), 
              "name_sample_list_file" = as.character(name_sample_list_file), 
              "repeats" = as.character(repeats), 
              "ANNO" = as.character(ANNO), 
              "selectedPROTEINS" = as.character(selectedPROTEINS), 
              "selectedPROTEINSfilename" = as.character(selectedPROTEINSfilename), 
              "THRESH_BSA" = as.character(THRESH_BSA), 
              "THRESH" = as.character(THRESH), 
              "SPmean_filtering" = as.character(SPmean_filtering), 
              "NORM" = as.character(NORM), 
              "SPmean_THRESH_type" = as.character(SPmean_THRESH_type), 
              "SPmean_THRESH" = as.character(SPmean_THRESH), 
              "SPmeanNORM" = as.character(SPmeanNORM), 
              "PLOT" = as.character(PLOT), 
              "colour_values" = colour_values, 
              "sp_mean_filter_effect" = as.character(sp_mean_filter_effect), 
              "XLSX_OUTPUT_LEGEND" = as.character(XLSX_OUTPUT_LEGEND),
              "plotSetting" = as.character(plotSetting),
              "geom_POINT" = as.character(geom_POINT),
              "LOESS_LINEWIDTH" = as.character(LOESS_LINEWIDTH),
              "y_ticks_SPACING" = as.character(y_ticks_SPACING),
              "title_SIZE" = as.character(title_SIZE),
              "title_FACE" = as.character(title_FACE),
              "title_COLOR" = as.character(title_COLOR),
              "x_axis_TITLE_SIZE" = as.character(x_axis_TITLE_SIZE),
              "y_axis_TITLE_SIZE" = as.character(y_axis_TITLE_SIZE),
              "axis_TEXT_SIZE" = as.character(axis_TEXT_SIZE),
              "legend_TITLE_SIZE" = as.character(legend_TITLE_SIZE),
              "legend_TEXT_SIZE" = as.character(legend_TEXT_SIZE),
              "png_UNITS" = as.character(png_UNITS),
              "png_WIDTH" = as.character(png_WIDTH),
              "png_HEIGHT" = as.character(png_HEIGHT),
              "png_RESOLUTION" = as.character(png_RESOLUTION),
              "x_axis_INTERCEPT_LINEWIDTH" = as.character(x_axis_INTERCEPT_LINEWIDTH),
              "x_MeCuP_results_TEXT" = as.character(x_MeCuP_results_TEXT),
              "y_MeCuP_results_TEXT" = as.character(y_MeCuP_results_TEXT),
              "MeCuP_results_TEXT_SIZE" = as.character(MeCuP_results_TEXT_SIZE),
              "MeCuP_results_TEXT_COLOR" = as.character(MeCuP_results_TEXT_COLOR),
              "annotation_LINEBREAK" = as.character(annotation_LINEBREAK)
              )
         )
  
} ##### end of function 'MeCuP__extractArgumentsForFileInput'

################################################################################################################################################################################################################################################################################################################################

MeCuP_filter_effect <- function(PATH) {
  # This function MeCuP_filter_effect creates directories with plots before and after adjustment 
  # or before removal due to low coverage of the normalizing samples 
  # in a new sub-director named "plots_filter_effect" in the detailed_output directory.
  # Respectively, text files are saved for the sets of coverage_removed, adjusted_added, adjusted_removed, adjusted_remained proteins.
  # Eventually, the distribution of proteins per effect is provided and saved as a text file to the output_detailed directory.
  
  
  # REQUIREMENTS
  ##
  
  # INPUT
  ## MeCuP_Tm50.txt file name and file needs to be present in filtering and not_filtered run/iteration output directories and has a column named "Tm50_fits_overlapping" with "yes" or "no" entries.
  ## adjusted proteins from MeCuP__SPmean_filtering_adjusted.txt file in filtering run in a txt file with "First.Majority.protein.ID" column containing the proteinIDs.
  ## path name strings for filtering and filtered output only differ by "Filtered" and "noFiltering"
  ## expected directory structure of relevance at both paths and place for MeCuP__SPmean_filtering_adjusted.txt in the filtered path:
  #" path
  #" |
  #" |- output
  #" | |-plots_selected
  #" |   |-mecup_Tm50_no_overlap
  #" |     |- protID3.png
  #" |     |- protID17.png
  #" |     |- protID200.png
  #" |     |- ...
  #" |- output_detailed
  #" | |-MeCuP__SPmean_filtering_adjusted.txt
  #" | |-MeCuP__Tm50_plotTable.csv
  #" | |-MeCuP__Tm50_plotTable.txt
  #" | |-plots_all
  #" |   |-mecup_Tm50
  #" |     |- protID1.png
  #" |     |- protID2.png
  #" |     |- protID3.png
  #" |     |- ...
  
  ### The only argument to be handed over to a respective function is "resultPath1" pointing to one of the two output directories.
  
  ##### begin of function 'MeCuP_filter_effect'
  
  # Read in and prepare the data for the comparison
  ## Fixing the paths for SPmean filtering filtered and not_filtered MeCuP output in the ARC's run directory. It is important that path1 is for the filtered output. 
  path1 <- gsub("noFiltering", "Filtered", PATH)  # filtered
  path2 <- gsub("Filtered", "noFiltering", path1) # not filtered
  
  ## Only proceed if the MeCuP__Tm50_plotTable.txt output files exist in both paths including the MeCuP__SPmean_filtering_adjusted.txt file.
  if (!file.exists(paste0(path1, "output_detailed/", "MeCuP__Tm50_plotTable.txt")) | !file.exists(paste0(path2, "output_detailed/", "MeCuP__Tm50_plotTable.txt")) | !file.exists(paste0(path1, "output_detailed/", "MeCuP__SPmean_filtering_adjusted.txt"))){
    
    stop("One of the required input files for the sp_mean_filter_effect scrip is not present. Please provide both MeCuP_Tm50.txt files, the MeCuP__SPmean_filtering_adjusted.txt file and resultPath1.")
    
  }else{
    ## Read in both MeCuP__Tm50_plotTable.txt result files
    df1_all <- read.table(paste0(path1, "output_detailed/", "MeCuP__Tm50_plotTable.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
    df2_all <- read.table(paste0(path2, "output_detailed/", "MeCuP__Tm50_plotTable.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
    
    ## Extract only those proteins with no_overlap of the LOESS fit confidence intervals at the melting point
    df1 <- df1_all[df1_all$Tm50_fits_overlapping %in% c("no"),]
    df2 <- df2_all[df2_all$Tm50_fits_overlapping %in% c("no"),]
    
    ## Read in the adjusted protein file from the output
    df3 <- read.table(paste0(path1, "output_detailed/", "MeCuP__SPmean_filtering_adjusted.txt"), header=TRUE, sep = "", dec = ".", check.names = FALSE)
    df3 <- df3[df3$First.Majority.protein.ID %in% df2_all$First.Majority.protein.ID,]
    adjusted_proteins <- unique(df3$First.Majority.protein.ID)
    
    # Identify proteins that were either added, removed or remained in the selected set of proteins for this MeCuP run (no overlap)
    ## Added (adjusted) due to filtering: adjusted and IN df1 (SPmean_filtering) and NOT IN df2 (noSPmean_filtering)
    PROT_added <- unique(df1$First.Majority.protein.ID[!(df1$First.Majority.protein.ID %in% df2$First.Majority.protein.ID)])
    ## Removed (coverage or adjusted) by filtering: either removed due to low coverage of the normalizing samples or adjusted. In addition IN df2 (noSPmean_filtering) and NOT IN df1 (SPmean_filtering) 
    PROT_removed <- unique(df2$First.Majority.protein.ID[!(df2$First.Majority.protein.ID %in% df1$First.Majority.protein.ID)])
    ## Removed (coverage): completely removed and were in the selected set before filtering. 
    PROT_removed_coverage <- unique(df2$First.Majority.protein.ID[(!(df2$First.Majority.protein.ID %in% df1_all$First.Majority.protein.ID))])
    ## Remained (coverage or adjusted) upon filtering: adjusted and IN df1 (SPmean_filtering) and in df2 (noSPmean_filtering)
    PROT_remained <- unique((df2$First.Majority.protein.ID)[(df2$First.Majority.protein.ID %in% df1$First.Majority.protein.ID)])
    
    # Copy plots in directories for the three selections above
    ## Removed (coverage): Collect plots before removal (no_filtering)
    dir.create(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_coverage_removed/"), showWarnings = FALSE, recursive = TRUE)
    
    if ((c("FALSE") %in% unique(file.exists(paste0(path2, "output/plots_selected/mecup_Tm50_no_overlap/", PROT_removed_coverage, ".png")))) & 
        (length(PROT_removed_coverage) != 0)) {
      warning("Not all plots have been created already and, therefore, can not be moved for the 'SPmean_filtering_coverage_removed' directory! Either there are no removed proteins due to low coverage or you did not yet run the script with and without the filtering option which needs to be done first.")
    }else{
      file.copy(paste0(path2, "output/plots_selected/mecup_Tm50_no_overlap/", PROT_removed_coverage, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_coverage_removed/", PROT_removed_coverage, ".png"))
    }
    
    ## Differentiate the adjusted proteins (adjusted by the SPmean filtering) into those that were added, remained and those that were removed from the candidates (no_overlap)
    adjusted_remained <- c(NA)
    adjusted_removed <- c(NA)
    adjusted_added <- c(NA)
    
    if (sum(is.na(adjusted_proteins) %in% c("FALSE")) > 0){
      adjusted_removed <- adjusted_proteins[(adjusted_proteins %in% PROT_removed)]
      adjusted_added <- adjusted_proteins[(adjusted_proteins %in% PROT_added)]        # in current version added and adjusted added is equal
      adjusted_remained <- adjusted_proteins[(adjusted_proteins %in% PROT_remained)]
    }
    
    ## Added (adjusted): Collect plots before and after adjustment
    dir.create(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_added/"), showWarnings = FALSE, recursive = TRUE)
    
    if (dir.exists(paste0(path2, "output_detailed/plots_all/mecup_Tm50"))) {
      
      if ((length(adjusted_added) != 0) &
          ((c("FALSE") %in% unique(file.exists(paste0(path1, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_added, ".png")))) |
           (c("FALSE") %in% unique(file.exists(paste0(path2, "output_detailed/plots_all/mecup_Tm50/", adjusted_added, ".png"))))) |
          (length(adjusted_added) == 0)) {
        warning("Not all plots have been created already and, therefore, can not be moved for the 'SPmean_filtering_added' directory! Either there are no adjusted, added proteins or you did not yet run the script with and without the filtering option which needs to be done first.")
      }else{
        file.copy(paste0(path2, "output_detailed/plots_all/mecup_Tm50/", adjusted_added, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_added/", adjusted_added, ".png"))
        file.copy(paste0(path1, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_added, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_added/", adjusted_added, "_adj.png"))
      }
    }
    
    ## Removed (adjusted): Collect plots before and after adjustment.
    dir.create(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_removed/"), showWarnings = FALSE, recursive = TRUE)
    
    if (dir.exists(paste0(path1, "output_detailed/plots_all/mecup_Tm50"))) {
      if ((length(adjusted_removed) != 0) & 
          ((c("FALSE") %in% unique(file.exists(paste0(path1, "output_detailed/plots_all/mecup_Tm50/", adjusted_removed, ".png")))) |
           (c("FALSE") %in% unique(file.exists(paste0(path2, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_removed, ".png"))))) |
          (length(adjusted_removed) == 0)) {
        warning("Not all plots have been created and, therefore, can not be moved for the 'SPmean_filtering_adjusted_removed' directory! Either there are no adjusted, removed proteins or you did not yet run the script with and without the filtering option which needs to be done first.")
      }else{
        if (length(adjusted_removed) != 0) {
          file.copy(paste0(path2, "output/plots_selected/mecup_Tm50_no_overlap/",adjusted_removed, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_removed/", adjusted_removed, ".png"))
          file.copy(paste0(path1, "output_detailed/plots_all/mecup_Tm50/",adjusted_removed, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_removed/", adjusted_removed, "_adj.png"))
        }
      }
    }
    
    ## Remained (adjusted): Collect plots before and after adjustment.
    dir.create(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_remained/"), showWarnings = FALSE, recursive = TRUE)
    
    if ((length(adjusted_remained) != 0) & 
        ((c("FALSE") %in% unique(file.exists(paste0(path1, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_remained, ".png")))) | 
         (c("FALSE") %in% unique(file.exists(paste0(path2, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_remained, ".png"))))) | 
        (length(adjusted_remained) == 0)) {
      warning("Not all plots have been created and, therefore, can not be moved for the 'SPmean_filtering_adjusted_remained' directory! Either there are no adjusted, remaining proteins or you did not yet run the script with and without the filtering option which needs to be done first.")
    }else{
      if (length(adjusted_remained) != 0) {
        file.copy(paste0(path2, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_remained, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_remained/", adjusted_remained, ".png"))
        file.copy(paste0(path1, "output/plots_selected/mecup_Tm50_no_overlap/", adjusted_remained, ".png"), paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_remained/", adjusted_remained, "_adj.png"))
      }
    }
    
    # Write tables for the different sets.
    # The first results are extracted form the noFiltering output as the respective proteins were removed during the filtering step due to low coverage.
    
    # If an empty file causes problems, the following if statement can be uncommented and adapted for all write.table lines below:
    #if (sum(is.na(adjusted_proteins)%in%c("FALSE")) > 0) {
    write.table(df2[df2$First.Majority.protein.ID %in% PROT_removed_coverage,], paste0(path1, "output_detailed/plots_filter_effect/MeCuP__Tm50_SPmean_Filtered_coverage_removed.txt"), sep="\t", row.names=FALSE)
    #}
    # The following results are extracted from the filtered output.
    write.table(df1_all[df1_all$First.Majority.protein.ID %in% adjusted_added,], paste0(path1, "output_detailed/plots_filter_effect/MeCuP__Tm50_SPmean_Filtered_adjusted_added.txt"), sep="\t", row.names=FALSE)
    write.table(df1_all[df1_all$First.Majority.protein.ID %in% adjusted_removed,], paste0(path1, "output_detailed/plots_filter_effect/MeCuP__Tm50_SPmean_Filtered_adjusted_removed.txt"), sep="\t", row.names=FALSE)
    write.table(df1[df1$First.Majority.protein.ID %in% adjusted_remained,], paste0(path1, "output_detailed/plots_filter_effect/MeCuP__Tm50_SPmean_Filtered_adjusted_remained.txt"), sep="\t", row.names=FALSE)
    
    # Add .gitkeep in case of empty directories.
    MeCuP_add_gitkeep(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_coverage_removed/"))
    MeCuP_add_gitkeep(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_added/"))
    MeCuP_add_gitkeep(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_removed/"))
    MeCuP_add_gitkeep(paste0(path1, "output_detailed/plots_filter_effect/mecup_Tm50_no_overlap_adjusted_remained/"))
    
  }
  
  # WRITE A SUMMARY OF THE FILTERING EFFECT
  summary_fe <- as.data.frame(matrix(nrow=length(unique(df1$treatment[!df1$treatment %in% c("Control")])), ncol=12))
  colnames(summary_fe) <- c("treatment", "proteins_pre_filtered", "proteins_post_filtered", "proteins_coverage_removed", "proteins_adjusted", "selected_proteins_pre_filtered", "selected_proteins_post_filtered", "selected_proteins_coverage_removed", "selected_proteins_adjusted", "selected_proteins_adjusted_added", "selected_proteins_adjusted_removed", "selected_proteins_adjusted_remained")
  
  TREAT = unique(df1$treatment[!df1$treatment %in% c("Control")])

  for (treat in TREAT) {
    treat_df1 <- df1[df1$treatment %in% treat, ]  
    treat_df1_all <- df1_all[df1_all$treatment %in% treat, ]
    treat_df2 <- df2[df2$treatment %in% treat, ]  
    treat_df2_all <- df2_all[df2_all$treatment %in% treat, ]
    
    summary_fe$treatment <- treat
    summary_fe$proteins_pre_filtered <- length(unique(treat_df2_all$First.Majority.protein.ID))
    summary_fe$proteins_post_filtered <- length(unique(treat_df1_all$First.Majority.protein.ID))
    summary_fe$proteins_coverage_removed <- summary_fe$proteins_pre_filtered - summary_fe$proteins_post_filtered
    summary_fe$proteins_adjusted <- length(adjusted_proteins)
    summary_fe$selected_proteins_pre_filtered <- length(unique(treat_df2$First.Majority.protein.ID))
    summary_fe$selected_proteins_post_filtered <- length(unique(treat_df1$First.Majority.protein.ID))
    summary_fe$selected_proteins_coverage_removed <- length(PROT_removed_coverage)
    summary_fe$selected_proteins_adjusted <- length(adjusted_proteins[adjusted_proteins %in% treat_df2$First.Majority.protein.ID])
    summary_fe$selected_proteins_adjusted_added <- length(adjusted_added)
    summary_fe$selected_proteins_adjusted_removed <- length(adjusted_removed)
    summary_fe$selected_proteins_adjusted_remained <- length(adjusted_remained)
    
    write.xlsx(list("summary_filter_effects" = t(summary_fe)), paste0(path1, "output_detailed/plots_filter_effect/MeCuP__Tm50_SPmean_summary_filter_effect_", treat, ".xlsx"), colNames = FALSE, rowNames = TRUE)
    
  }

} ##### end of function 'MeCuP_filter_effect'

################################################################################################################################################################################################################################################################################################################################

MeCuP__getPackagesAndWd <- function(){
  ##### begin of function 'MeCuP__getPackagesAndWd'
  
  ################################################################################
  ###################  Install and Load all Required Packages ####################
  ################################################################################
  
  # List of required packages
  requirements <- c("rstudioapi", "stringr", "ggplot2", "grid", "gridExtra", "openxlsx", "DescTools", "VennDiagram", "RColorBrewer", "dplyr")
  
  # Install missing packages
  installedPackages <- requirements %in% as.data.frame(installed.packages())$Package
  if(length(requirements[!installedPackages]) > 0) install.packages(requirements[!installedPackages], dependencies = TRUE)
  
  # Load packages into session 
  requirementsMatched <- lapply(requirements, require, character.only=TRUE)
  install.packages(requirements[!unlist(requirementsMatched)], dependencies = TRUE)
    
  ################################################################################
  ############################  Setting the Path  ################################
  ################################################################################
  
  ## Use the directory of this script as the working directory
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  
} ##### end of function 'MeCuP__getPackagesAndWd'

################################################################################################################################################################################################################################################################################################################################

MeCuP_promptArgumentsOptions <- function(DEFAULT){
  # input is the default option for reading in arguments used by the prompt.
  ##### begin of function 'MeCuP_promptArgumentsOptions'
  
  ARGUMENTS_INPUT <- showPrompt("How do you want to provide the arguments?", 
                                "Enter 1: DEFAULT: USE TEMPLATE --- 
                                 Enter 2: OWN CUSTOM FILE ('MeCuP_Arguments_INPUT.csv'). --- 
                                 Enter 3: SCRIPT (Only for development). --- 
                                 Hit 'enter' or press 'ok'.", default = DEFAULT)
  return(ARGUMENTS_INPUT)
  
} ##### end of function 'MeCuP_promptArgumentsOptions'

################################################################################################################################################################################################################################################################################################################################

MeCuP__readCustomArguments <- function(ARGUMENTS_INPUT) {
  # Read the arguments from a custum file for option 2
  # Input is the ARGUMENTS_INPUT provided by the user via prompt (MeCuP_promptArgumentsOptions).
  ##### begin of function 'MeCuP__readCustomArguments'
  
  ASSAY <- showPrompt(title, "Please enter your ASSAY NAME and hit 'enter'.", default = NULL)
  
  # Check if the assay is there, otherwise: error.
  if (dir.exists(paste0("../assays/", ASSAY, "/"))) {
    print(paste0("Assay: '", ASSAY, "'"))
  } else {
    stop(print(paste("The assay" , ASSAY, "does not exist.\n The assay MUST be equal to a subdirectory name of the assay folder inside the ARC with this script.")))
  }
  
  print("Reading in the arguments file.\n\n")
  
  arguments <- read.csv(file = paste0("../assays/", ASSAY, "/protocols/MeCuP_Arguments_INPUT.csv"), header = TRUE, sep = ",", as.is=TRUE)
  if (dim(arguments)[2] == 1) {
    arguments <- read.csv(file = paste0("../assays/", ASSAY, "/protocols/MeCuP_Arguments_INPUT.csv"), header = TRUE, sep = ";", as.is=TRUE)
  }
  
  return(arguments)
  
} ##### end of function 'MeCuP__readCustomArguments'

################################################################################################################################################################################################################################################################################################################################

MeCuP__readDefaultArguments <- function(ARGUMENTS_INPUT){
  # Read the default arguments from template
  # Input is the ARGUMENTS_INPUT provided by the user via prompt (MeCuP_promptArgumentsOptions).
  ##### begin of function 'MeCuP__readDefaultArguments'
  
  ASSAY <- showPrompt(title, "Please enter your ASSAY NAME and hit 'enter'.", default = NULL)
  
  # Check if the assay is there, otherwise: error.
  if (dir.exists(paste0("../assays/", ASSAY, "/"))) {
    print(paste0("Assay: '", ASSAY, "'"))
  } else {
    stop(print(paste("The assay" , ASSAY, "does not exist.\n The assay MUST be equal to a subdirectory name of the assay folder inside the ARC with this script.")))
  }
  
  print("Reading in the arguments file.\n\n")
  
  arguments <- read.csv(file = "../resources/MeCuP_Arguments_INPUT.csv", header = TRUE, sep = ",", as.is=TRUE)
  if (dim(arguments)[2] == 1) {
    arguments <- read.csv(file = "../resources/MeCuP_Arguments_INPUT.csv", header = TRUE, sep = ";", as.is=TRUE)
  }
  
  # Prompt for / add arguments not provided by the default values
  arguments[arguments$Parameter == "ASSAY", ]$SelectedArgument <- ASSAY
  arguments[arguments$Parameter == "name_input_file", ]$SelectedArgument <- showPrompt("Parameter: name_input_file", "Please enter the name of your input file residing in the 'dataset' directory of your assay directory. (Including the '.txt' file extension.). Hit 'enter' or 'ok'.", default = NULL)
  arguments[arguments$Parameter == "name_sample_list_file", ]$SelectedArgument <- showPrompt("Parameter: name_sample_list_file", "Please enter the name of your sample list file residing in the 'protocols' directory of your assay directory. (Including the '.csv' file extension.) Hit 'enter' or 'ok'.", default = NULL)
  arguments[arguments$Parameter == "repeats", ]$SelectedArgument <- showPrompt("Parameter: repeats", "Please enter the number of repeats for each treatment-temperature combination. (Recommended: at least 3!) Hit 'enter' or 'ok'.", default = NULL)

  return(arguments)
  
} ##### end of function 'MeCuP__readDefaultArguments'

################################################################################################################################################################################################################################################################################################################################

MeCuP_resultsColnameColor <- function(df) {
  # extract a color data.frame for eventually format the colnames in the result xlsx
  colnameColor <- unique(df[,c("treatment","colour")])
  
  # automatically define the font color for each background color
  colnameColor[,"font_color"] <- NA 
  
  for (i in c(1:dim(colnameColor)[1])) {
    colnameColor[,"font_color"][i] <- TextContrastColor(colnameColor$colour[i], white = "white", black = "black", method = "glynn")
  }
  return(colnameColor)
} ##### end of function 'MeCuP_resultsColnameColor'

################################################################################################################################################################################################################################################################################################################################

MeCuP_writeSession <- function(PATH, used_time) {
  
  if (file.exists(paste0(PATH,"/info/"))) {
    writeLines(capture.output(sessionInfo()), paste0(PATH,"/info/","mecup_r_session_info.txt"))
    cat('\nTime needed for running this MeCuP script: ', round(difftime(used_time[[(length(used_time))]], used_time[[1]], units = "mins"),2), ' min\n', file=paste0(PATH,"/info/","mecup_r_session_info.txt"), append=T)
    cat('\nDate MeCuP Script finished: ',  date(), ' \n', file=paste0(PATH,"/info/","mecup_r_session_info.txt"), append=T)
    return 
  }
} ##### end of function 'MeCuP_writeSession'

################################################################################################################################################################################################################################################################################################################################

MeCuP_writeXlsx <- function (PATH, XLSX_OUTPUT_LEGEND, SAM, PLOT, SELECTEDPROTEINSARGUMENT) {
  ##### build a MeCuP outout xlsx file comprising TOC&legend (optional), results, excluded protein information, sample list, BSA content information and the selected input arguments
  # Parameters:
  # - PATH: the path for the current MeCuP run output
  # - LEGEND: the selection if the legend should be included in the ouput xlsx file
  # - SAM: the extended sample list to be stored in the output xlsx file
  # - PLOT: the selected PLOT MeCup argument
  # - SELECTEDPROTEINSARGUMENT: the selected arguments$selectedPROTEINS MeCuP argument.
  
  ##### begin of function 'MeCuP_writeXlsx'

  if (!(exists("wb"))) {
    wb <- createWorkbook()
  }
  
  wb <- MeCuP_addTOCOutputXlsx(wb, XLSX_OUTPUT_LEGEND)
  
  # Results
  if (XLSX_OUTPUT_LEGEND == TRUE) {
    wb <- MeCuP_addLegendResults(wb)
  }
  
  wb <- MeCuP_addResultsXlsx(wb, PATH, PLOT, SELECTEDPROTEINSARGUMENT)
  
  # Excluded Proteins
  if (XLSX_OUTPUT_LEGEND == TRUE) {
    wb <- MeCuP_addLegendExcludedProteinsXlsx(wb)
  }
  
  wb <- MeCuP_addExcludedProteinsXlsx(wb, PATH)
  
  # Sample List
  if (XLSX_OUTPUT_LEGEND == TRUE) {
    wb <- MeCuP_addLegendSampleListXlsx(wb)
  }
  
  wb <- MeCuP_addSampleListXlsx(wb, SAM)
  
  # Selected Arguments (optional, add in case an arguments output file is generated)
  if (XLSX_OUTPUT_LEGEND == TRUE) {
    wb <- MeCuP_addLegendSelectedArgumentsXlsx(wb)
  }
  
  wb <- MeCuP_addSelectedArgumentsXlsx(wb, PATH)
  
  # save the workbook
  if (file.exists(paste0(PATH, "output/", "MeCuP__Tm50.xlsx"))) {
    unlink(paste0(PATH, "output/", "MeCuP__Tm50.xlsx"))
  }
  saveWorkbook(wb, paste0(PATH, "output/", "MeCuP__Tm50.xlsx"))
  rm(wb)
} ##### end of function 'MeCuP_writeXlsx'
