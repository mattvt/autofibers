# FTIR Plits
library(RcppFaddeeva)
library(ggplot2)

names(pre) <- c("wn","value")

preCurve1725 <- Voigt(1650:1800, 1726.2, 8.76813, 8.15389)
preCurve1725 <- preCurve1725*0.0471611/max(preCurve1725)
pre1725.df <- data.frame(1650:1800, preCurve1725)
names(pre1725.df) <- c("wn","value")
plot(pre1725.df)

preCurve1736 <- Voigt(1650:1800, 1736, 12.7401, 0)
preCurve1736 <- preCurve1736*0.0471611/max(preCurve1736)
pre1736.df <- data.frame(1650:1800, preCurve1736)
names(pre1736.df) <- c("wn","value")
plot(pre1736.df)

ggplot(data = pre, aes(x = wn, y = value)) +
  geom_point()+
  geom_point(data = pre1725.df)






postCurve <- Voigt(1650:1800, 1726.2, 12.7401, 0)
postCurve <- postCurve*0.0471611/max(postCurve)
post.df <- data.frame(1650:1800, postCurve)
plot(post.df)


#Pre

    #1725
  #    Center: 1726.202878
  #    Area: 0.883607
  #    Height: 0.0471611
  #    FWHM: 13.9132
  #    I.Breadth: 18.7359
  #    GaussianFWHM: 8.76813
  #    LorentzianFWHM: 8.15389
  #    In: @0.F

    #1736
#      Center: 1736
#      Area: 0.406921
#      Height: 0.0300059
#      FWHM: 12.7401
#      I.Breadth: 13.5614
#      GaussianFWHM: 12.7401
#      LorentzianFWHM: 0
#      In: @0.F

#Post

  #1725
      #Center: 1724.762406
      #Area: 0.978594
      #Height: 0.0492795
      #FWHM: 14.8453
      #I.Breadth: 19.858
      #GaussianFWHM: 9.55135
      #LorentzianFWHM: 8.4481
      #In: @1.F

  #1736
    #  Center: 1736
    #  Area: 0.247048
    #  Height: 0.0209495
    #  FWHM: 11.0784
    #  I.Breadth: 11.7926
    #  GaussianFWHM: 11.0784
    #  LorentzianFWHM: 0
    #  In: @1.F

