
rm(list=ls())
cat("\014")

initial_setup_and_files_function <- function(){
primary_input <- tolower(readline(prompt="Start initial setup(y/n) ? "))
if(primary_input=="y")
{
while(primary_input!='stop')
{
working_directory <- readline(prompt="Please enter the working directory in UNIX format: ")
setwd(working_directory)
print(list.files(path = ".", pattern = NULL, all.files = FALSE,
                 full.names = FALSE, recursive = FALSE,
                 ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE))
file_format <- tolower(readline(prompt="Please enter the format of the file: "))
# number_of_files<- as.integer(readline(prompt = "Enter the number of files to be read: "))


if(file_format=="csv")
{
  number_files <- tolower(readline(prompt = "Import all the files(y/n) ? "))
  if (number_files == "y")
  {
    temp <- list.files(pattern="*.csv")
    if (length(temp)==0)
    {
      print("No CSV files here!")
      break
    }else{
    for (i in 1:length(temp)){
      nam <- paste(temp[i], sep = "")
      nam<-gsub("\\..*","",nam)
      assign(nam, read.csv(temp[i],header=T,stringsAsFactors=F,check.names=F),envir=globalenv())}}
  }else{
    file_input <- tolower(readline(prompt= "Enter the name of the file to be imported(stop to terminate): "))
    while(file_input!='stop')
    {
      nam <- paste(file_input, sep = "")
      nam<-gsub("\\..*","",nam)
      assign(nam, read.csv(file_input,header=T,stringsAsFactors=F,check.names=F),envir=globalenv())
      file_input <- tolower(readline(prompt= "Enter the name of the next file to be imported(stop to terminate): "))
    }
  }
  
}

if(file_format=="xlsx")
{ 
   list.of.packages <- c("xlsx")
   new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
   if(length(new.packages)) install.packages(new.packages)
   library(xlsx)
   number_files <- tolower(readline(prompt = "Import all the files(y/n) ? "))
   if (number_files =="y")
   {temp = list.files(pattern="*.xlsx")
    if (length(temp)==0)
    {
      print("No XLSX files here!")
      break
    }else{
   for (i in 1:length(temp)){
   nam <- paste(temp[i], sep = "")
   nam<-gsub("\\..*","",nam)
   assign(nam, read.xlsx(temp[i],header=T,stringsAsFactors=F,sheetIndex = 1,check.names=F),envir=globalenv())}}
   }else{
     file_input <- tolower(readline(prompt= "Enter the name of the file to be imported(stop to terminate): "))
     while(file_input!='stop')
     {
       nam <- paste(file_input, sep = "")
       nam<-gsub("\\..*","",nam)
       assign(nam, read.xlsx(file_input,header=T,stringsAsFactors=F,sheetIndex = 1,check.names=F),envir=globalenv())
       file_input <- tolower(readline(prompt= "Enter the name of the next file to be imported(stop to terminate): "))
     }
   }
}
primary_input <- readline(prompt="Finished initial setup(n/stop)? ")
}
}else{
return()
}
}


initial_setup_and_files_function()
