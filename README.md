

# Background
A lightweight and easy-to-use tool for manually coding qualitative data in R. This repository provides instructions and an installation script for running this tool in R.

Go follow the instructions at https://www.r-project.org if you need to install R. 



# Table of Contents
- [Installation](#installation)
- [Issues](#issues)
- [Features](#features)
- [FAQ](#faq)
- [License](#license)

# Installation 
To install the latest development version, run:
```Rscript
install.packages("devtools")
devtools::install_github("ropenscilabs/qcoder")
library(qcoder)
```

## Documents
This tool requires the use of txt files. If you have documents in pdf format run the following script: 

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

When you are finished with coding the documents click ```save changes``` button

**Known Issues** 

Please refer to [Issues](#issues) section for bug in saving coded data. 

# Issues
At this stage, the Qcoder application does not save coded data when the R session ends. This is due to a bug in the Qcoder package that is out of my control. As such, data must be coded and extracted within a single session. This is a work in progress and is a high priority development item. 

# Features

# FAQ

# License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

