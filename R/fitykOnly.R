fitykOnly <- function(){

ftykDataPath <- choose.files()

names(ftykDataPath) <- basename(ftykDataPath)
renamedFityk <- names(ftykDataPath)
renamedFityk <- substr(renamedFityk, 2, 5)
names(ftykDataPath) <- renamedFityk
renamedFityk
fitykData <- ldply(ftykDataPath, read.delim, header=FALSE, comment.char="#")
fitykData <- fitykData[1:6]
names(fitykData) <- c('Temp','Peak','Center','Height','Area','FWHM')
fitykData$Peak <- substr(fitykData$Peak, 3, 6)
fitykData <- fitykData[order(fitykData$Temp),]


#sums <- fitykData[fitykData$Center == 1725,]
#sums1 <- vector()

#for (i in 1:length(sums$Temp)){
#  sums1[i] <- sums[i,5] + sums[i+1,5]
#}
#sums$Area <- as.numeric(sums1)
#sumsOdd <- sums[seq(1,length(sums$Temp),2),]
#names(sumsOdd) <- c('Temp','Peak','Center','Height','Area','FWHM')

#all <- rbind(sumsOdd, fitykData[fitykData$Center == 1735,])
#fitykData <- all



fitykCalcs <- getPeakAreaAll(fitykData)
fitykCalcs$Crystallinity <- fitykCalcs$area1725/(fitykCalcs$area1725 + fitykCalcs$area1736*1.46)
fitykCalcs$Replicate <- substr(fitykCalcs$Temp, 5,6)
fitykCalcs$Temp <- as.numeric(substr(fitykCalcs$Temp, 1,4))
fitykCalcs <- fitykCalcs[order(fitykCalcs$Temp),]
return(fitykCalcs)
}


tempOptOLD <- fitykCalcs
plot <- ggplot(tempOptOLD, aes(x = as.numeric(Temp), y = Crystallinity)) +
  stat_smooth()+
  geom_point(alpha = .5)+
  xlab("Temperature")+
  theme_minimal(base_size = 15)
#  ggtitle("Temperature Vs Crystallinity")

#path <- getwd()

#png(filename=paste(path,"/tempVSCrystallinity.png", sep = ""),
#    type="cairo",
#    units="in",
#    width=5,
#    height=4,
#    pointsize=12,
#    res=1500)

#Plot
#print(plot)

#dev.off()

############

