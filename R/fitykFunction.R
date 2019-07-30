#easier way to get crystallinity?
fitykOnly <- function(){

ftykDataPath <- choose.files()

names(ftykDataPath) <- basename(ftykDataPath)

length <- nchar(as.character(basename(ftykDataPath)[1]))

renamedFityk <- names(ftykDataPath)
renamedFityk <- substr(renamedFityk, 2, length-10)
names(ftykDataPath) <- renamedFityk
renamedFityk
fitykData <- ldply(ftykDataPath, read.delim, header=FALSE, comment.char="#")
fitykData <- fitykData[1:6]
names(fitykData) <- c('Temp','Peak','Center','Height','Area','FWHM')
fitykData$Peak <- substr(fitykData$Peak, 3, 6)
fitykData <- fitykData[order(fitykData$Temp),]

x <- fitykData[fitykData$Peak == 1725,]
y <- fitykData[fitykData$Peak == 1736,]

cleaned <- cbind(as.data.frame(x$Temp), as.data.frame(x$Area), as.data.frame(y$Area))
names(cleaned) <- c("Temp","area1725", "area1736")

fitykCalcs<- cleaned
#fitykCalcs <- getPeakAreaAll(fitykData)
fitykCalcs$Crystallinity <- fitykCalcs$area1725/(fitykCalcs$area1725 + fitykCalcs$area1736*1.46)
length <- nchar(as.character(fitykCalcs$Temp[1]))
fitykCalcs$Replicate <- substr(fitykCalcs$Temp, length,length)
fitykCalcs$Temp <- as.numeric(substr(fitykCalcs$Temp, 1,2))
fitykCalcs <- fitykCalcs[order(fitykCalcs$Temp),]
return(fitykCalcs)
}
