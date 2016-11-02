pollutantmean <- function(directory, pollutant, id = 1:332){
  dir <- paste(getwd(), "/", directory, "/", sep = "")
  files <- list.files(dir)
  result <- 0
  for(iD in 1:length(id)){
    connection <- file(paste(getwd(), "/", directory, "/", files[id[iD]], sep = ""), "r")
    initial <- read.table(connection, nrows = 100)
    classes <- sapply(initial, class)
    data <- read.table(connection, sep = ",", colClasses = classes)
    close(connection)
    names(data) <- c("Date", "sulfate", "nitrate", "id")
    pollutantDataNa <- data[pollutant]
    pollutantData <- as.numeric(pollutantDataNa[!is.na(pollutantDataNa)])
    result <- mean(result + pollutantData)
  }
  result
}