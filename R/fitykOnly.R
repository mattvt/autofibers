ftykDataPath <- choose.files()

names(ftykDataPath) <- basename(ftykDataPath)
renamedFityk <- names(ftykDataPath)
renamedFityk <- substr(renamedFityk, 2, length(basename(ftykDataPath)) - 5)
names(ftykDataPath) <- renamedFityk
renamedFityk

fitykData <- ldply(ftykDataPath, read.delim, header=FALSE, comment.char="#")
fitykData <- fitykData[1:6]
names(fitykData) <- c('Time','Peak','Center','Height','Area','FWHM')
fitykData$Peak <- substr(fitykData$Peak, 3, 6)

fitykCalcs <- getPeakAreaAll(fitykData)
fitykCalcs$Crystallinity <- fitykCalcs$area1725/(fitykCalcs$area1725 + fitykCalcs$area1736*1.46)
fitykCalcs$time <- substr(fitykCalcs$Temp, 4,6)
