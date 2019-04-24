###   plot the derivitive of each plot and color by temp
#' @export
sequenctial_SS_YM <- function(all, path = getwd()){



  library(ggplot2)
  library(gridExtra)

gg <- ggplot2::ggplot(all, aes(x = index, y = ym))+
  geom_line(aes(color = temp), size = 2)+
  scale_color_brewer(palette = "RdBu", direction=-1)+
  xlab('')+
  ylab('dStress/dstrain')+
  scale_x_continuous(breaks = NULL)+
  labs(title = "Derivitive of stress with respect to strain",
       subtitle = "",
       color = 'Temp (C)')+
  theme_minimal()+
  theme(legend.position="none", legend.box = "horizontal")+
  guides(colour = guide_legend(nrow = 1, keywidth=3.20))+
  facet_grid(. ~ temp, scales = "free_x")+


png(filename=paste(path,"/ymAll.png", sep = ""),
    type="cairo",
    units="in",
    width=10,
    height=3,
    pointsize=12,
    res=1000)

print(gg)
dev.off()

################################
##### Stress Strain in a row ###
################################


gg2 <- ggplot2::ggplot(all, aes(x = strain, y = stressSEM))+
  geom_line(aes(color = temp), size = 1.5)+
  scale_color_brewer(palette = "RdBu", direction=-1)+
  xlab('Strain')+
  ylab('Stress (GPa)')+
  scale_x_continuous(breaks = pretty(all$strain, n = 2))+
  labs(title = "Stress vs Strain for each Temp",
       subtitle = "",
       color = 'Temperature')+
  theme_minimal()+
  theme(legend.position='none')+
  facet_grid(. ~ temp, space = "free")+


png(filename=paste(path,"/ssAll.png", sep = ""),
    type="cairo",
    units="in",
    width=10,
    height=2,
    pointsize=12,
    res=1000)

print(gg2)
dev.off()

###################
#Combine the two###
###################

png(filename=paste(path,"/ymAndssSequential.png", sep = ""),
    type="cairo",
    units="in",
    width=10,
    height=5,
    pointsize=12,
    res=1000)

ggcombo <- gridExtra::grid.arrange(gg2, gg, ncol = 1)
print(ggcombo)
dev.off()
}

