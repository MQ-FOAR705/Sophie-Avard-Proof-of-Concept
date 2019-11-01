install.packages('plyr', repos = "http://cran.us.r-project.org")


install.packages("pdftools", repos = "http://cran.us.r-project.org")
library(pdftools)


file.names <- dir(path="pdfs", pattern =".pdf", full.names=TRUE)


for (file in file.names) {
  text <- pdf_text(file)
  
  
  output.file <- gsub("pdf", "txt",file)
  print(output.file)
  print(file)
  write(text, output.file)
}

