

# Background
This repository was created as part of the Digital Humanities unit within Masters of Research at Macquarie University. It is a proof of concept (POC) that attempts to use digital tools and techniques for analysing qualitative data. Moreover, attempts have been made to automate testing via continuous integration. 

This PoC is a lightweight and easy-to-use tool for analysing qualitative data in R. This repository provides instructions and an installation script for running this tool in R. This tool can be used for any textual data, such as: interview transcripts, fieldwork notes, and primary documents.

Go follow the instructions at https://www.r-project.org if you need to install R. 

This R script uses the qcoder package at https://github.com/ropenscilabs/qcoder. 


# Table of Contents
- [Outline of the project](#outline)
- [Setup](#setup)
- [Installation](#installation)
- [Issues](#issues)
- [Features](#features)
- [FAQ](#faq)
- [License](#license)

# Outline
For this PoC, I searched Macquarie University's Library and found two pdf documents that are relevant to my MRes thesis. These were downloaded and saved to my PoC repository. 

I then used R to:
- Create a folder called 'txts'
- Convert the pdfs to txt files 
- Move the txt files to the 'txts' folder
- Import qcoder package 
- Import units and codes for textual analysis 
- Build a path between the txt files and R 
- Reduce repeitive work by integrating all of these processes


# Setup
In order for this tool to work you need to download the pdf-to-txt folder and the qcoder_analysis folder and save them to your Desktop. 

# Installation 


## Pdf to Text 
This R script requires the use of txt files. If you have documents in pdf format run the following script in OSX terminal:

```
cd ~/Desktop/pdf-to-text
#!/bin/bash
Rscript forloop.R
```

Alternatively, you can run the following script directly in RStudio: 

```Rscript
install.packages("pdftools")
library(pdftools)


file.names <- dir(path="pdfs", pattern =".pdf", full.names=TRUE)


for (file in file.names) {
  text <- pdf_text(file)

  
  output.file <- gsub("pdf", "txt",file)
  print(output.file)
  print(file)
  write(text, output.file)
}

```

Once you have converted your pdfs to txt files you are ready for the next step!

## Qcoder Analysis 
To install the latest development version, run:
```Rscript
install.packages("devtools")
devtools::install_github("ropenscilabs/qcoder")
library(qcoder)
```

## Importing data
To import the data into Qcode, run: 
```Rscript
#locate the working directory
getwd()
#use create_qcoder_project to create a new project
#create_qcoder_project("my_project")
import_project_data(project = "my_project")
```

```Rscript
#assign value to a variable
project_name = "my_project"
file_name <- "Fabian_2018.txt"
docs_df_path <-"my_project/data_frames/qcoder_documents_my_project.rds"
codes_df_path <- "my_project/data_frames/qcoder_codes_my_project.rds"
file_path <- "my_project/documents"
dir("my_project/documents")
```

```Rscript 
read_documents_data(project_name = project_name)
#This proves the data is "in" the system
new_dataframe <- readRDS(docs_df_path)
```

```Rscript 
read_code_data(project_name = project_name)
codes_dataframe <- readRDS(codes_df_path)
qcode(use_wd=TRUE)
```

## Coding the data 
Using a tagging system, codes can be assigned to text in two ways:
1. Surround the text to be coded with (QCODE)(/QCODE){#tag}. For example: 

```(QCODE)This text will be assigned a tag labelled 'example'.(/QCODE){#example}```

2. To use an existing code, highlight the text to be assigned a code, select the code, click ```add selected code```

When you are finished with coding the documents click ```save changes``` button.

Instructions on how to code data using qcoder can be found at https://github.com/ropenscilabs/qcoder. 

**Known Issues** 

Please refer to [Issues](#issues) section for bug in saving coded data. 

# Issues
At this stage, the Qcoder application does not save coded data when the R session ends. This is due to a bug in the Qcoder package that is out of my control. As such, data must be coded and extracted within a single session. This is a work in progress and is a high priority development item. 

# Features

# FAQ

# License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

