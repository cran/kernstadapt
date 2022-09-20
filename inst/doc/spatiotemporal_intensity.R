## ----setup, echo=FALSE, warning=FALSE, message=FALSE--------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>"
)

## ---- message=FALSE-----------------------------------------------------------
#  # Main package
#  library(kernstadapt)
#  
#  # Complementary packages
#  library(spatstat)
#  library(sparr)

## ---- fig.height = 3, fig.align="center", fig.width=9-------------------------
#  data(aegiss, santander, amazon)
#  par(mfrow = c(1,3))
#  
#  plot(aegiss, main = "Aegiss", bg = rainbow(250))
#  plot(santander, main = "Santander", bg = rainbow(250))
#  plot(amazon[sample.int(amazon$n, 5000)], main = "Amazon fires", bg = rainbow(250))

## -----------------------------------------------------------------------------
#  # Cronie and van Lieshout's spatial bandwidth
#  bw.xy.aegiss <- bw.abram(aegiss, h0 = bw.CvL(santander))
#  
#  # Modified Silverman's rule of thumb temporal bandwidth
#  bw.t.aegiss <- bw.abram.temp(aegiss$marks, h0 = bw.nrd(aegiss$marks))
#  
#  # Scott’s isotropic rule of thumb for spatial bandwidth
#  bw.xy.santander <- bw.abram(santander, h0 = bw.scott.iso(santander))
#  
#  # Unbiased cross-validation for temporal bandwidth
#  bw.t.santander <- bw.abram.temp(santander$marks,
#                                  h0 = bw.ucv(as.numeric(santander$marks)))

## -----------------------------------------------------------------------------
#  sapply(list(aegiss, santander, amazon), separability.test)

## -----------------------------------------------------------------------------
#  # Direct estimation, separable case
#  lambda <- dens.direct.sep(X = santander,
#                            dimyx = 128, dimt = 64,
#                            bw.xy = bw.xy.santander,
#                            bw.t = bw.t.santander)

## ---- fig.align="center", fig.height = 5, fig.width=9-------------------------
#  # We select some fixed times for visualisation
#  I <- c(12, 18, 23, 64)
#  
#  # We subset the lists
#  SDS <- lapply(lambda[I], function(x) (abs(x)) ^ (1/6))
#  
#  # Transform to spatial-objects-lists
#  SDS <- as.solist(SDS)
#  
#  # We generate the plots
#  plot(SDS, ncols = 4, equal.ribbon = T, box = F,
#       main = 'Direct estimation, separable case')

## -----------------------------------------------------------------------------
#  # Partition algorithm estimation, separable case
#  lambda <- dens.par.sep(X = santander,
#                         dimyx = 128, dimt = 64,
#                         bw.xy = bw.xy.santander,
#                         bw.t = bw.t.santander,
#                         ngroups.xy = 20, ngroups.t = 10)

## ---- fig.align="center", fig.height = 5, fig.width=9-------------------------
#  # We select some fixed times for visualisation
#  I <- c(12, 18, 23, 64)
#  
#  # We subset the lists
#  SPS <- lapply(lambda[I], function(x) (abs(x)) ^ (1/6))
#  
#  # Transform to spatial-objects-lists
#  SPS <- as.solist(SPS)
#  
#  # We generate the plots
#  plot(SPS, ncols = 4, equal.ribbon = T, box = F,
#       main = 'Partition algorithm estimation, separable case')

## -----------------------------------------------------------------------------
#  #Direct estimation, non-separable case
#  lambda <- dens.direct(aegiss,
#                        dimyx = 32, dimt = 16,
#                        bw.xy = bw.xy.aegiss,
#                        bw.t = bw.t.aegiss,
#                        at = "bins")

## ---- fig.align="center", fig.height = 3, fig.width=9-------------------------
#  # We select some fixed times for visualisation
#  I <- c(2, 5, 8, 16)
#  
#  # We subset the lists
#  NSDA <- lapply(lambda[I], function(x) (abs(x)) ^ (1/6))
#  
#  # Transform to spatial-objects-lists
#  NSDA <- as.solist(NSDA)
#  
#  # We generate the plots
#  plot(NSDA, ncols = 4, equal.ribbon = T, box = F,
#       main = 'Direct estimation, non-separable case')

## -----------------------------------------------------------------------------
#  # Partition algorithm estimation, non-separable case
#  lambda <- dens.par.sep(X = amazon,
#                         dimyx = 128, dimt = 64,
#                         ngroups.xy = 20, ngroups.t = 10)

## ---- fig.align="center", fig.height = 3, fig.width=9-------------------------
#  # We select some fixed times for visualisation
#  I <- c(12, 18, 23, 64)
#  
#  # We subset the lists
#  NSPA <- lapply(lambda[I], function(x) (abs(x)) ^ (1/6))
#  
#  # Transform to spatial-objects-lists
#  NSPA <- as.solist(NSPA)
#  
#  # We generate the plots
#  plot(NSPA, ncols = 4, equal.ribbon = T, box = F,
#       main = 'Partition algorithm estimation, non-separable case')

