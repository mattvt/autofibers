#' @export
#library(gridExtra)
#library(ggplot2::ggplot2)

SEM <- ggplot2::ggplot(all, aes(x = strain, y = stressSEM, color = temp))+
  geom_line(alpha = .7, size = 1)+
  scale_color_brewer(palette="RdBu", direction=-1)+
  ylab('Stress (GPa)')+
  xlab('Strain')+
  labs(color = 'Temperature',
       title = "Heat Treatment, Quench",
       subtitle = "SEM normalization")+
  theme_minimal()

png(filename="ssSEM.png",
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
SEM

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

png(filename="ssFTIR.png",
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
FTIR

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

png(filename="ssHyb.png",
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1000)

#Plot
Hyb

dev.off()




png(filename="combined.png",
    type="cairo",
    units="in",
    width=15,
    height=4,
    pointsize=12,
    res=1000)
gridExtra::grid.arrange(SEM, FTIR, Hyb, ncol = 3)
dev.off()
