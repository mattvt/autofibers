#easier way to get crystallinity?
fitykLongTerm <- function(day){

  ftykDataPath <- choose.files()

  names(ftykDataPath) <- basename(ftykDataPath)

  length <- nchar(as.character(basename(ftykDataPath)[1]))

  renamedFityk <- names(ftykDataPath)
  renamedFityk <- substr(renamedFityk, 2, length-10)
  names(ftykDataPath) <- renamedFityk
  renamedFityk
  fitykData <- ldply(ftykDataPath, read.delim, header=FALSE, comment.char="#")
  fitykData <- fitykData[1:6]
  names(fitykData) <- c('Day','Peak','Center','Height','Area','FWHM')
  fitykData$Peak <- substr(fitykData$Peak, 3, 6)
  fitykData <- fitykData[order(fitykData$Day),]

  x <- fitykData[fitykData$Peak == 1725,]
  y <- fitykData[fitykData$Peak == 1736,]

  cleaned <- cbind(as.data.frame(x$Day), as.data.frame(x$Area), as.data.frame(y$Area))
  names(cleaned) <- c("Day","area1725", "area1736")

  fitykCalcs <- cleaned
  #fitykCalcs <- getPeakAreaAll(fitykData)
  fitykCalcs$Crystallinity <- fitykCalcs$area1725/(fitykCalcs$area1725 + fitykCalcs$area1736*1.46)
  length <- nchar(as.character(fitykCalcs$Day[1]))
  fitykCalcs$Replicate <- substr(fitykCalcs$Day, length,length) #extract the replicate number
  fitykCalcs$Temp <- substr(fitykCalcs$Day, 1,2)
  fitykCalcs$Day <- rep(day,nrow(fitykCalcs))
  fitykCalcs <- fitykCalcs[order(fitykCalcs$Day),]
  fitykCalcs
  return(fitykCalcs)
}
