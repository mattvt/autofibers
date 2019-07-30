# Power Analysis
library(pwr)
#get means for effect size
treatedMean <- mean(tempOpt$Crystallinity[tempOpt$Temp == 70])
UnTreatedMean <- mean(tempOpt$Crystallinity[tempOpt$Temp == 22])

#get standard deviation for each temp and take the mean
indi <- unique(tempOpt$Temp)

y <- data.frame()


for (i in 1:length(indi)){
  x <- tempOpt[tempOpt$Temp == indi[i],]
  stdev <- sd(x$Crystallinity)
  y <- rbind(y, stdev)
}
names(y) <- c("sd")
stdev <- mean(y$sd)


pwr.t.test(d=-(UnTreatedMean-treatedMean)/stdev, n = 4, sig.level=.00001,type="two.sample",alternative="greater" )
