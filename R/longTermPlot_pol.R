#long Term polarized crystallinity plot
library(ggplot2)
combinedAll


plot2 <- ggplot(combinedAll, aes(x = as.numeric(Day), y = Crystallinity*100, color = Temp))+

  geom_line(aes(x =as.numeric(Day), y = Mean*100, group = interaction(Temp, pol)),
             alpha = .8, size = 0.3)+
  geom_errorbar(aes(ymin=Mean*100-sd*100, ymax=Mean*100+sd*100),
             size = .3 ,width=1, position=position_dodge(1.25)) +
  geom_point(aes(group=factor(Temp), shape = as.factor(pol)), size = 2.25,
             alpha = .6, position = position_dodge(width = 1.25))+
  xlab("Time (days)")+
  ylab("% Crystallinity")+
  scale_shape_discrete(name = "Polarization")+
  ggtitle("Long Term changes in Crystallinity")+
  scale_x_continuous(breaks = c(0, 3, 7))+
  scale_color_discrete(h.start = 150, direction = -1)+
 # scale_y_continuous(breaks = seq(.52, .64, .02))+
  theme_minimal(base_size = 13)


png(filename=paste(getwd(),"/LTpol.png", sep = ""),
    type="cairo",
    units="in",
    width=6,
    height=6,
    pointsize=12,
    res=500)

plot2
dev.off()

