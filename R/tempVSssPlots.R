### this script makes all the stress strain curves, including combined graphs
# and for temperature and crystallinity
#' @export
ssOverlay <- function(all, path = getwd()){

#library(gridExtra)
#library(ggplot2)

SEM <- ggplot2::ggplot(all, aes(x = strain, y = stressSEM, color = as.factor(Perc_Cryst)))+
  geom_line(alpha = .7, size = 1)+
  scale_color_brewer(palette="PRGn", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Crystallinity',
       title = "Heat Treatment, Quench",
       subtitle = "SEM normalization")+
  theme_minimal()

png(filename=paste(path,"/ssSEMCrystal.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
print(SEM)

dev.off()


FTIR <- ggplot2::ggplot(all, aes(x = strain, y = stressFTIR, color = as.factor(Perc_Cryst)))+
  geom_line(alpha = .7, size = 1)+
  scale_color_brewer(palette="PRGn", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Crystallinity',
       title = "Heat Treatment, Quench",
       subtitle = "FTIR normalization")+
  theme_minimal()

png(filename=paste(path,"/ssFTIRCrystal.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
print(FTIR)

dev.off()

Hyb <- ggplot2::ggplot(all, aes(x = strain, y = stressHyb, color = as.factor(Perc_Cryst)))+
  geom_line(alpha = .7, size = 1)+
  scale_color_brewer(palette="PRGn", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Crystallinity',
       title = "Heat Treatment, Quench",
       subtitle = "Hyb normalization")+
  theme_minimal()

png(filename=paste(path,"/ssHybCrystal.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
print(Hyb)

dev.off()


##combine all the graphs into one figure

png(filename=paste(path,"/combinedCrystal.png", sep = ""),
    type="cairo",
    units="in",
    width=15,
    height=4,
    pointsize=12,
    res=1000)
combocrystal <- gridExtra::grid.arrange(SEM, FTIR, Hyb, ncol = 3)

print(combocrystal)
dev.off()




SEM <- ggplot2::ggplot(all, aes(x = strain, y = stressSEM, color = temp))+
  geom_line(alpha = .7, size = 1)+
  scale_color_brewer(palette="RdBu", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Temperature',
       title = "Heat Treatment, Quench",
       subtitle = "SEM normalization")+
  theme_minimal()

png(filename=paste(path,"/ssSEMTemp.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
print(SEM)

dev.off()


FTIR <- ggplot2::ggplot(all, aes(x = strain, y = stressFTIR, color = temp))+
  geom_line(alpha = .7, size = 1)+
  #geom_point(size = .01)+
  scale_color_brewer(palette="RdBu", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Temperature',
       title = "Heat Treatment, Quench",
       subtitle = "FTIR normalization")+
  theme_minimal()

png(filename=paste(path,"/ssFTIRtemp.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
print(FTIR)

dev.off()


Hyb <- ggplot2::ggplot(all, aes(x = strain, y = stressHyb, color = temp))+
  geom_line(alpha = .7, size = 1)+
  scale_color_brewer(palette="RdBu", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Temperature',
       title = "Heat Treatment, Quench",
       subtitle = "Hyb normalization")+
  theme_minimal()

png(filename=paste(path,"/ssHybtemp.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
print(Hyb)

dev.off()


##combine all the graphs into one figure

png(filename=paste(path,"/combotemp.png", sep = ""),
    type="cairo",
    units="in",
    width=15,
    height=4,
    pointsize=12,
    res=1000)
comboTemp <- gridExtra::grid.arrange(SEM, FTIR, Hyb, ncol = 3)
dev.off()


png(filename=paste(path,"/combotempandcryst.png", sep = ""),
    type="cairo",
    units="in",
    width=15,
    height=8,
    pointsize=12,
    res=1000)

combinedTempandcryst <- gridExtra::grid.arrange(comboTemp, combocrystal, ncol = 1)

dev.off()
}



