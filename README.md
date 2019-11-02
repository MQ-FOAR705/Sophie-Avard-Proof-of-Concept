

# Background
This repository was created as part of the Digital Humanities unit within Masters of Research at Macquarie University. It is a proof of concept (POC) that attempts to use digital tools and techniques for analysing qualitative data. Moreover, attempts have been made to automate testing via continuous integration. 

This PoC is a lightweight and easy-to-use tool for analysing qualitative data in R. This repository provides instructions and an installation script for running this tool in R. This tool can be used for any textual data, such as: interview transcripts, fieldwork notes, and primary documents.

This R script uses the qcoder package at https://github.com/ropenscilabs/qcoder. 


# Table of Contents
- [Outline of the project](#outline)
- [Setup](#setup)
- [Installation](#installation)
- [Results](#results)
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
In order for this tool to work you need to download the proof-of-concept repository and save it to your Desktop. 

# Installation 
Go follow the instructions at https://www.r-project.org if you need to install R. 

Alternatively, you can run the following command in OSX Mac terminal:
```xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Homebrew PATH
echo "export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
echo "export LANG=en_US.UTF-8" >> ~/.bash_profile
echo "export PATH=/usr/local/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile

brew install r
echo 'Sys.setlocale(category="LC_ALL", locale = "en_US.UTF-8")' >> ~/.bash_profile

brew install openblas
brew install r --with-openblas
echo 'Sys.setlocale(category="LC_ALL", locale = "en_US.UTF-8")' >> ~/.bash_profile

brew cask install rstudio
```


## Pdf to Text 
This script requires the use of txt files. If you have documents in pdf format run the following script in RStudio:

```Rscript
install.packages("pdftools")
library(pdftools)

#creates variable called file.names that builds path to the pdfs 
file.names <- dir(path="pdfs", pattern =".pdf", full.names=TRUE)

#this forloop converts the pdfs to text
for (file in file.names) {
  text <- pdf_text(file)

  #gsub replaces all matches of "pdf" and returns a string vector of "txt"
  output.file <- gsub("pdf", "txt",file)
  #print argument returns a visiable output
  print(output.file)
  print(file)
  #write the data to a file
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
To import the data into Qcoder, run: 
```Rscript
#locate the working directory
#make sure working directory is qcoder_analysis
getwd()
#use following line to create a new project
#create_qcoder_project("qcoder-analysis-project")
#import project data
import_project_data(project = "qcoder-analysis-project")
```

To build the paths to the data to be importated and to the data frame where the imported data is to be stored, run: 
```Rscript
project_name = "qcoder-analysis-project"
file_name <- "Fabian_2018.txt"
#creates a path to the data
docs_df_path <-"qcoder-analysis-project/data_frames/qcoder_documents_qcoder-analysis-project.rds"
#creates a path to the codes
codes_df_path <- "qcoder-analysis-project/data_frames/qcoder_codes_qcoder-analysis-project.rds"
file_path <- "qcoder-analysis-project/documents"
dir("qcoder-analysis-project/documents")
```

To create a path to the 'txts' folder and copy the txts to the qcoder_analysis directoy, run:
```Rscript
#create path to diretory
rawPath <- "/Users/sophieavard/Desktop/pdf-to-text/txts"
#create path to txt files within directory
datafiles <- dir(rawPath, "*.txt", ignore.case = TRUE, all.files = TRUE)
#copy txt files into qcoder_analysis directory
file.copy(file.path(rawPath, datafiles), file_path, overwrite = TRUE)
```

To read the data and codes into the system, run:
```Rscript 
#read_documents_data(project_name = project_name)
#This line proves the data is "in" the system
new_dataframe <- readRDS(docs_df_path)
#This line reads the codes 
read_code_data(project_name = project_name)
codes_dataframe <- readRDS(codes_df_path)
#This line opens qcoder and sets the qcoder-analysis-project as the directory
qcode(use_wd=TRUE)
```

## Coding the data 
Using a tagging system, codes can be assigned to text in two ways:
1. Surround the text to be coded with (QCODE)(/QCODE){#tag}. For example: 

```(QCODE)This text will be assigned a tag labelled 'example'.(/QCODE){#example}```

2. To use an existing code, highlight the text to be assigned a code, select the code, click ```add selected code```

When you are finished with coding the documents click ```save changes``` button.

Instructions on how to code data using qcoder can be found at https://github.com/ropenscilabs/qcoder. 

For the purposes of this PoC I have provided an example of coded data in the [Results](#results) section. 

# Results


# Issues
At this stage, the Qcoder application does not save coded data when the R session ends. This is due to a bug in the Qcoder package that is out of my control. As such, data must be coded and extracted within a single session. This is a work in progress and is a high priority development item. 

# Features

# FAQ

# License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

