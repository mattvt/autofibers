###   plot the derivitive of each plot and color by temp
#' @export
sequentialSS <- function(all, path = getwd(), name = "new"){

width <- length(unique(all$temp)) + 3


  library(ggplot2)
  library(gridExtra)

  ################################
##### ym vs strain in a row ###
################################

gg <- ggplot2::ggplot(all, aes(x = strain, y = ym))+
  geom_line(size = 1.5)+
  xlab('Strain')+
  ylab('dStress (GPa)')+
  scale_x_continuous(breaks = pretty(all$strain, n = 2))+
    labs(title = "Derivitive of stress with respect to strain",
         subtitle = "",
         color = 'Temp (C)')+
    theme_minimal()+
    theme(legend.position='none', panel.spacing.x=unit(1.2, "lines"))+
    facet_grid(. ~ temp, space = "free")

################################
##### Stress Strain in a row ###
################################

gg2 <- ggplot2::ggplot(all, aes(x = strain, y = stressFTIR))+
  geom_line(size = 1.5)+
  xlab('Strain')+
  ylab('Stress (GPa)')+
  scale_x_continuous(breaks = pretty(all$strain, n = 2))+
  labs(title = paste("Stress vs Strain for each Temp: ", name, sep = ""),
       subtitle = "",
       color = 'Temperature')+
  theme_minimal()+
  theme(legend.position='none', panel.spacing.x=unit(1.2, "lines"))+
  facet_grid(. ~ temp, space = "free")

###################
#Combine the two###
###################

png(filename=paste(path,"/SequentialSS_", name, ".png", sep = ""),
    type="cairo",
    units="in",
      width=width,
      height=5,
      pointsize=12,
      res=1000)

  ggcombo <- gridExtra::grid.arrange(gg2, gg, ncol = 1)
  dev.off()
}

