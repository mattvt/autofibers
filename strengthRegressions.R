#youngs modulus and ultimate strength plots
#' @export
ym_UTSVStemp <- function(all, path = getwd()){

library(gridExtra)
library(ggplot2)
library(dplyr)

################ Ultimate Strength ##############################

#data <- dplyr::filter(minusSS, variable == 'Perc_Cryst' | variable == 'UTS_FTIR' )

#subset the data
minusSS <- unique(subset(all, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
data <- minusSS

#nmake linear Model
mod <- lm(UTS_FTIR ~ Perc_Cryst, data = data)
sumMod <- summary(mod)
rSq <- round(sumMod$r.squared, digits = 4)
p <- round(sumMod$coefficients[2,4], digits = 4)

#Ultimate Strength
UTS_FTIR <- ggplot2::ggplot(data, aes(x = Perc_Cryst, y = UTS_FTIR))+
  geom_smooth(method=lm, color = 'black',  size = .7, alpha = .2 )+
  geom_point(aes(fill = temp), colour="black", pch=21, size = 3)+
  ylab('Ultimate Strength (GPa)')+
  xlab('Percent Crystallinity')+
  labs(title = "Heat Treatment, Quench",
       subtitle = paste('p=',p,', ','r^2=',rSq, sep = ""),
       color = 'Temperature (C)')+
  scale_fill_brewer(palette="RdBu", direction=-1)+
  theme_minimal()

png(filename=paste(path,"/UTS_FTIR.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

print(UTS_FTIR)
dev.off()

#Young's Modulus

#subset the data

#nmake linear Model
mod <- lm(ymMax ~ Perc_Cryst, data = data)
sumMod <- summary(mod)
rSq <- round(sumMod$r.squared, digits = 4)
p <- round(sumMod$coefficients[2,4], digits = 4)

#Young's Modulus
ymVsCryst <- ggplot2::ggplot(data, aes(x = Perc_Cryst, y = ymMax))+
  geom_smooth(method=lm, color = 'black',  size = .7, alpha = .2 )+
  geom_point(aes(fill = temp), colour="black", pch=21, size = 3)+
  ylab('Young\'s Modulus (GPa)')+
  xlab('Percent Crystallinity')+
  labs(title = "Heat Treatment, Quench",
       subtitle = paste('p=',p,', ','r^2=',rSq, sep = ""),
       color = 'Temperature (C)')+
  scale_fill_brewer(palette="RdBu", direction=-1)+
  theme_minimal()

png(filename=paste(path,"/ymVScrystal.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

print(ymVsCryst)
dev.off()

##################################
####### Temp vs Crystal ##########
##################################


# subset the data for the non linear part
lmtest <- minusSS[minusSS$temp >= 48,]

lmtest$Perc_Cryst <- as.numeric(lmtest$Perc_Cryst)
lmtest$temp <- as.numeric(lmtest$temp)

model <- lm(lmtest$Perc_Cryst ~ poly(lmtest$temp, 2, raw=TRUE))
sum <- summary(model)
rSq <- round(sum$r.squared, digits = 3)
p <- round(sum$coefficients[3,4], digits = 5)

tempVScrystal <- ggplot2::ggplot(data, aes(x = as.numeric(temp), y = Perc_Cryst))+
  geom_smooth(size = .7, alpha = .2, color = "steelblue1", data = lmtest, method = "lm", formula = y ~ poly(x,2,raw = TRUE))+
  geom_point(aes(fill = as.factor(round(UTS_FTIR, digits = 3))),pch=21, size = 3)+
  ylab('Percent Crystallinity')+
  xlab('Temperature (C)')+
  labs(title = "Heat Treatment, Quench",
       fill = "UTS (GPa)",
       subtitle = paste('p=',p,', ','r^2=',rSq, sep = ""))+
  scale_fill_brewer(palette="RdBu", direction=-1)+
  scale_y_continuous(limits = c(50,81))+
  theme_minimal()

png(filename=paste(path,"/tempVScrystal.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

print(tempVScrystal)
dev.off()

####################################
##########   Combine YM and UTS ####
####################################


png(filename=paste(path,"/combinedYMandUTS.png", sep = ""),
    type="cairo",
    units="in",
    width=10,
    height=4,
    pointsize=12,
    res=1000)

combinedYMandUTS <- gridExtra::grid.arrange(ymVsCryst, UTS_FTIR, ncol = 2)
dev.off()
}
