

# Background
This repository was created as part of the Digital Humanities unit within Masters of Research at Macquarie University. It is a proof of concept (POC) that attempts to use digital tools and techniques for analysing qualitative data. Moreover, attempts have been made to automate testing via continuous integration. 

This PoC is a lightweight and easy-to-use tool for analysing qualitative data in R. This repository provides instructions and an installation script for running this tool in R. This tool can be used for any textual data, such as: interview transcripts, fieldwork notes, and primary documents.

This R script uses the qcoder package at https://github.com/ropenscilabs/qcoder. 

You can view my Notebook at http://rpubs.com/Savard/PoC.


# Table of Contents
- [Outline of the project](#outline)
- [Setup](#setup)
- [Installation](#installation)
- [Results](#results)
- [Issues](#issues)
- [Future Direction](#futuredirection)
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
In order for this tool to work you need to download the [proof-of-concept zip file](proof-of-concept.zip), unzip it and save it to your Desktop. Follow the instruction in this README to run the R script, for a more detailed description of the script visist my Notebook at: http://rpubs.com/Savard/PoC

Prior to running the script, you need to set your working directory to the proof-of-concept directory in RStudio.

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
## Set working directory
In order for this PoC to work, users must set their working directory to the proof-of-concept directory (this should have been saved on the Desktop during [Setup](#setup). To set your working directory, run the following script: 

```Rscript
#set wd to $HOME/path/to/proof-of-concept
setwd($HOME/Desktop/proof-of-concept)
```
NOTE: '$HOME' should be replaced with the users home directory. For example, 
```Rscript 
setwd(Users/sophieavard/Desktop/proof-of-concept)
```

## Install packages
To install the latest development version of the required packages, run:

```Rscript
#packages for pdf to txt
install.packages('plyr', repos = "http://cran.us.r-project.org")
install.packages("pdftools", repos = "http://cran.us.r-project.org")
library(pdftools)

#packages for textual analysis
install.packages("devtools", repos = "http://cran.us.r-project.org")
devtools::install_github("ropenscilabs/qcoder")
library(qcoder)

```

## Pdf to Text 
As the textual analysis requires the use of txt files, users need to convert pdfdocuments into txt. To do this, run the following script in RStudio:

```Rscript
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
Once you have have run this script, check the 'txts' folder in the proof-of-concept directory to make sure that the converted files are there.

![txt files in directory](https://github.com/MQ-FOAR705/Sophie-Avard-Proof-of-Concept/blob/master/images/txt-files.png )


## Importing data
Firstly, ensure that your working directory is proof-of-concept:

```Rscript 
getwd()
```

For the purposes of this project the user will be using a project that has already been created. For future references, if you want to create an empty project, run:
```Rscript
create_qcoder_project("insert-peroject-name-here")
```

To import the data proof-of-concept data into Qcoder, run: 
```Rscript
import_project_data(project = "qcoder-analysis-project")
```

To build the paths to the data to be importated and to the dataframes where the imported data is to be stored, run: 
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

Now the user needs to copy the files in 'txts' and place them in the 'documents' folder within the qcoder_analysis_project. To do this, run:
```Rscript
rawPath <- "~/Desktop/proof-of-concept/txts"
datafiles <- dir(rawPath, "*.txt", ignore.case = TRUE, all.files = TRUE)
file.copy(file.path(rawPath, datafiles), file_path, overwrite = TRUE)
```
Check the 'documents' folder in the qcoder_analysis_project to make sure that the text files have been copied into the folder.

To read the data and codes into the system, run:
```Rscript 
new_dataframe <- readRDS(docs_df_path)
read_code_data(project_name = project_name)
codes_dataframe <- readRDS(codes_df_path)
```
Lastly, to open the qcoder analysis, run:
```Rscript
qcode(use_wd=TRUE)
```

Please note, a breakdown of this R script and its function is located in my Notebook at http://rpubs.com/Savard/PoC

## Coding the data 
For the purposes of this PoC, I have provided examples of how I coded the two txt files in the proof-of-concept directory. Using the Shiny app, codes can be assigned to text in two ways:

1. Surround the text to be coded with (QCODE)(/QCODE){#tag}. For example: 

```(QCODE)This text will be assigned a tag labelled 'example'.(/QCODE){#example}```

2. To use an existing code (see example below), highlight the text to be assigned a code, select the code, click ```add selected code```

When you are finished with coding the documents click ```save changes``` button.

Here is an example of the codes that were used to tag the files in this proof of concept. This must be a csv format and it must be saved in the 'codes' folder within the qcoder_analysis_project.
![example codes](https://github.com/MQ-FOAR705/Sophie-Avard-Proof-of-Concept/blob/master/images/codes-template.png)

Further instructions on how to code data using qcoder can be found at https://github.com/ropenscilabs/qcoder. 

For the purposes of this PoC I have provided an example of coded data in the [Results](#results) section. 

# Results
This is an example of data that I have coded in the Shiny app: 
![example highlighted data](https://github.com/MQ-FOAR705/Sophie-Avard-Proof-of-Concept/blob/master/images/highlighted-data.png)

This is an example of the data that I exported as a csv format: 
- doc: this is the value that users assign to each document 
- qcode: this is the code of that particular segment of text
- text: is the segment of text that has been coded
![example csv file](https://github.com/MQ-FOAR705/Sophie-Avard-Proof-of-Concept/blob/master/images/coded-data.png)

# Issues
At this stage, the Qcoder application does not save coded data when the R session ends. This is due to a bug in the Qcoder package that is out of my control. As such, data must be coded and extracted within a single session. This is a work in progress and is a high priority development item. 

# Future direction
1. I am currently working on being able to save and re-open qcoder sessions in R. 
2. At this stage, the script cannot be run through terminal due to the ui and server of the shiny app. I am working towards being able to run the script through the terminal command ```Rscript qcoder.R```
3. I am also working towards creating my own Shiny app for this Rscript so that it can be run easily through Chrome browser.
4. Lastly, I am working on a script that will assign a column to the csv file for references. This script will used the document unit (.eg "1") and the document name (eg. "Fabian_2018") to automatically create an in-text references that can be pasted into my thesis. 

# License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

