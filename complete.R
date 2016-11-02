complete <- function(directory, id = 1:332){
  dir <- paste(getwd(), "/", directory, "/", sep = "")
  files <- list.files(dir)
  idhi <- vector()
  nobs <- vector()
  for(iD in 1:length(id)){
    connection <- file(paste(getwd(), "/", directory, "/", files[id[iD]], sep = ""), "r")
    initial <- read.table(connection, nrows = 100)
    classes <- sapply(initial, class)
    data <- read.table(connection, sep = ",", colClasses = classes)
    close(connection)
    names(data) <- c("Date", "sulfate", "nitrate", "id")
    sulfateDataNa <- data["sulfate"]
    nitrateDataNa <- data["nitrate"]
    sul <- !is.na(sulfateDataNa)
    nit <- !is.na(nitrateDataNa)
    
    idhi <- c(idhi, id[iD])
    nobs <- c(nobs, as.numeric(length(sulfateDataNa[sul & nit])))
  }
  
  data.frame("id" = idhi, "nobs" = nobs)
}