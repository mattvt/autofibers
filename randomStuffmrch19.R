library(ggplot2)

all1 <- all[!(all$temp == 48 & all$condition == "quench"),]
all <- all1

quench1 <- quench[!(quench$temp == 48 & quench$condition == "quench"),]
qunech <- quench1



ggplot(all, aes(x = as.numeric(temp),y = UTS_FTIR, colour = condition))+
  geom_point()+
  geom_line(size = 2)



ggplot(all, aes(x = index, y = stressFTIR, colour = condition))+
  geom_point()+
  geom_line(size = 2)

####PCA
minusSS <- all
minusSS <- unique(subset(minusSS, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
minusSS<- na.omit(minusSS)
minusSScond <- subset(minusSS, select = c(Perc_Cryst, amor_or, cryst_or, tot_or))
#minusSScond$temp <- minusSScond$temp


library(ggbiplot)

pca <- prcomp(minusSScond, scale = TRUE, center = FALSE)
pca.values <- data.frame(pca$x, Condition = minusSS$condition, temp <- minusSS$temp, UTS <- minusSS$UTS_FTIR)
pca.loadings <- data.frame(Variables = rownames(pca$rotation), pca$rotation)
#ggbiplot(data.pca)


gg <- ggplot(pca.values,aes(x=PC1,y=PC2, color = Condition))+
  geom_segment(data = pca.loadings, aes(x = 0, y = 0, xend = (PC1*3),
      yend = (PC2*3)), arrow = arrow(length = unit(1/2, "picas")),
      color = "black", size = 1, alpha = .3) +
  geom_point(aes(size=UTS), alpha = .5)+
  geom_text(aes(label = as.character(temp)), hjust=-.5,vjust=1)+
  annotate("text", x = (pca.loadings$PC1*3.5), y = (pca.loadings$PC2*3.5),
           label = pca.loadings$Variables)+
  ggtitle(label = "PC1 vs PC2 of Annealed and Quenched Samples")+
         # subtitle = "PCA computed using Percent Crystallinity, and amorphous, crystal, and total Orientation")+
  scale_size(range = c(1, 10))+
  theme_minimal()
  gg

png(filename=paste(getwd(),"/quenchVsAnnealPCA.png", sep = ""),
    type="cairo",
    units="in",
    width=8,
    height=8,
    pointsize=12,
    res=1000)

gg

dev.off()

library(cluster)

aa <- autoplot(data.pca, loadings = TRUE, loadings.label = TRUE,
         data = minusSS, colour = 'condition')
gg <- gg + aa



####### correlation Matrices
library(corrplot)
library(dplyr)
all$temp <- as.numeric(all$temp)
numeric <- all
numeric <- select_if(numeric, is.numeric)
numeric <- unique(subset(numeric, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
numeric <- subset(numeric, select = c(temp, UTS_FTIR, ymMax, tot_or, cryst_or, amor_or, Perc_Cryst))
numeric<- na.omit(numeric)
colnames(numeric) <- c("Temp", "UTS", "YM", "Tot. Or.", "Cryst. Or.", "Amor. Or.", "Crystal %")
corrplot(cor(numeric),
         method = "color",
         tl.col = "black",
         order = "original",
        # title = "All Correlation Matrix",
         sig.level = TRUE,
        tl.cex = 1.5)

quench$temp <- as.numeric(quench$temp)
numeric <- quench
numeric <- select_if(numeric, is.numeric)
numeric <- unique(subset(numeric, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
numeric <- subset(numeric, select = c(temp, UTS_FTIR, ymMax, tot_or, cryst_or, amor_or, Perc_Cryst))
numeric <- na.omit(numeric)
colnames(numeric) <- c("Temp", "UTS", "YM", "Tot. Or.", "Cryst. Or.", "Amor. Or.", "Crystal %")
quench.cor <- cor(numeric)
corrplot(quench.cor,
         method = "color",
         tl.col = "black",
         order = "original",
         # title = "All Correlation Matrix",
         sig.level = TRUE,
         tl.cex = 1.5)

anneal$temp <- as.numeric(anneal$temp)
numeric <- anneal
numeric <- select_if(numeric, is.numeric)
numeric <- unique(subset(numeric, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
numeric <- subset(numeric, select = c(temp, UTS_FTIR, ymMax, tot_or, cryst_or, amor_or, Perc_Cryst))
numeric <- na.omit(numeric)
colnames(numeric) <- c("Temp", "UTS", "YM", "Tot. Or.", "Cryst. Or.", "Amor. Or.", "Crystal %")
anneal.cor <- cor(numeric)
corrplot(anneal.cor,
         method = "color",
         tl.col = "black",
         order = "original",
         # title = "All Correlation Matrix",
         sig.level = TRUE,
         tl.cex = 1.5)

diff.cor <- anneal.cor-quench.cor
corrplot(diff.cor,
         method = "color",
         tl.col = "black",
         order = "original",
         # title = "All Correlation Matrix",
         sig.level = TRUE,
         tl.cex = 1.5)

test <- corr.test(numeric)
corrplot(test$p, method = "number", col = "black")
