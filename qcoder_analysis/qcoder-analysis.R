install.packages("devtools", repos = "http://cran.us.r-project.org")
devtools::install_github("ropenscilabs/qcoder")

#library(shiny)
 library(qcoder)
getwd()
#create_qcoder_project("qcoder-analysis-project")

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
rawPath <- "/Users/sophieavard/Desktop/pdf-to-text/txts"
datafiles <- dir(rawPath, "*.txt", ignore.case = TRUE, all.files = TRUE)
file.copy(file.path(rawPath, datafiles), file_path, overwrite = TRUE)


# TODO Make a for loop ala the pdf -> txt to add *all* documents
# add_new_documents(file_name,
#                   docs_df_path,
#                   file_path)

#read_documents_data(project_name = qcoder-analysis-project)

#This proves the data is "in" the system
new_dataframe <- readRDS(docs_df_path)

read_code_data(project_name = project_name)

codes_dataframe <- readRDS(codes_df_path)

qcode(use_wd=TRUE)
