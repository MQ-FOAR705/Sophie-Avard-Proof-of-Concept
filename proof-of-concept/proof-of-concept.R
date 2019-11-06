
#set working directory to $HOME/Desktop/proof-of-concept
#setwd()

#install packages
install.packages('plyr', repos = "http://cran.us.r-project.org")
install.packages("pdftools", repos = "http://cran.us.r-project.org")
library(pdftools)

install.packages("devtools", repos = "http://cran.us.r-project.org")
devtools::install_github("ropenscilabs/qcoder")
library(qcoder)



#pdf-to-text
file.names <- dir(path="pdfs", pattern =".pdf", full.names=TRUE)

for (file in file.names) {
  text <- pdf_text(file)
  
  
  output.file <- gsub("pdf", "txt",file)
  print(output.file)
  print(file)
  write(text, output.file)
}

#use create function if you want to create an empty qcoder analysis
#create_qcoder_project("qcoder-analysis-project")

#use import function to import an existing analysis
import_project_data(project = "qcoder-analysis-project")

project_name = "qcoder-analysis-project"
file_name <- "Fabian_2018.txt"
docs_df_path <-"qcoder-analysis-project/data_frames/qcoder_documents_qcoder-analysis-project.rds"
codes_df_path <- "qcoder-analysis-project/data_frames/qcoder_codes_qcoder-analysis-project.rds"
file_path <- "qcoder-analysis-project/documents"
dir("qcoder-analysis-project/documents")


#create path to diretory
#create path to txt files within directory
#copy txt files into qcoder_analysis directory
rawPath <- "~/Desktop/Sophie-Avard-Proof-of-Concept/proof-of-concept/txts"
datafiles <- dir(rawPath, "*.txt", ignore.case = TRUE, all.files = TRUE)
file.copy(file.path(rawPath, datafiles), file_path, overwrite = TRUE)

#read_documents_data(project_name = qcoder-analysis-project)

#This proves the data is "in" the system
new_dataframe <- readRDS(docs_df_path)

read_code_data(project_name = project_name)

codes_dataframe <- readRDS(codes_df_path)

qcode(use_wd=TRUE)