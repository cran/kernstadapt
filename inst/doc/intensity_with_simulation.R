## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>"
)

## ----setup, echo=FALSE, warning=FALSE, message=FALSE--------------------------
#  library(kernstadapt)
#  library(ggplot2)
#  library(stpp)
#  library(sparr)

## -----------------------------------------------------------------------------
#  # Number of points coming from a Poisson distribution with mean 1000
#  N <- rpois(1, 1000)

## -----------------------------------------------------------------------------
#  logGaussianPP <- rlgcp(npoints = N, nx = 128, ny = 128, nt = 64,
#                         separable = F, model = "gneiting", scale = c(0.5, 0.8),
#                         param = c(1, 1, .1, 0.1, 1, 2), var.grf = 2, mean.grf = 1)

## ---- fig.height = 4.5, fig.align="center"------------------------------------
#  # Spatstat format
#  XX <- ppp(x = logGaussianPP$xyt[, 1], y = logGaussianPP$xyt[, 2],
#            marks = logGaussianPP$xyt[, 3], window = owin())
#  
#  # Set the color scheme
#  colmap <- colourmap(rainbow(512), range = range(marks(XX)))
#  sy <- symbolmap(pch = 21, bg = colmap, range = range(marks(XX)))
#  
#  # Plotting
#  plot(XX, symap = sy, 'log-Gaussian Cox point pattern')

## -----------------------------------------------------------------------------
#  # Global bandwidths
#  bwS0 <- OS(XX) # The spatial bandwidth will be the oversmoothing version
#  bwt0 <- bw.SJ(XX$marks) # We employ Sheather & Jones's bandwidth for time
#  
#  # Spatial and temporal bandwidths based on pilot estimations
#  bwS <- bw.abram(unmark(XX), h0 = bwS0)
#  bwt <- bw.abram.temp(t = XX$marks, h0 = bwt0)

## -----------------------------------------------------------------------------
#  # Fixed bandwidth estimate (non-separable)
#  classic.dens <- spattemp.density(pp = unmark(XX), tt = XX$marks,
#                                   sres = 128, tres = 64,
#                                   lambda = bwt0, h = bwS0,
#                                   sedge = "uniform")

## -----------------------------------------------------------------------------
#  # In this case we use 8 groups for space and 4 for time
#  adapt.dens <- dens.par(X = XX,
#                         dimt = 64,
#                         bw.xy = bwS, bw.t = bwt,
#                         ngroups.xy = 8, ngroups.t = 4,
#                         at = "bins")

## ---- fig.align="center"------------------------------------------------------
#  # We select some fixed times for visualisation
#  I <- c(13, 17, 21, 31, 50)
#  
#  # We subset the lists
#  CN <- as.imlist(classic.dens$z[I])
#  AN <- as.imlist(adapt.dens[I])
#  
#  # We generate the plots
#  plot.imlist(CN, ncols = 5, main = 'Classic fixed-bandwidth estimate')
#  plot.imlist(AN, ncols = 5, main = 'Adaptive non-separable estimate')

## -----------------------------------------------------------------------------
#  # Loading dataset
#  data("amazon")

## ---- fig.height = 4.5, fig.align="center"------------------------------------
#  # Extract a sample of 5000 data points
#  AmazonReduced <- amazon[sample.int(amazon$n, 5000)]
#  
#  # Set the color scheme
#  colmap <- colourmap(rainbow(512), range = range(marks(AmazonReduced)))
#  sy <- symbolmap(pch = 21, bg = colmap, range = range(marks(AmazonReduced)))
#  
#  # Plotting
#  plot(AmazonReduced, symap = sy, 'Sample of Amazonia fires')

## -----------------------------------------------------------------------------
#  separability.test(X = amazon, nperm = 1500)

## -----------------------------------------------------------------------------
#  # Global bandwidths
#  bwS0 <- OS(amazon) # The spatial bandwidth will be the oversmoothing version
#  bwt0 <- bw.nrd(amazon$marks) # We employ Scott bandwidth for time
#  
#  # Spatial and temporal bandwidths based on pilot estimations
#  bwS <- bw.abram(amazon, h0 = bwS0)
#  bwt <- bw.abram.temp(t = amazon$marks, h0 = bwt0)

## -----------------------------------------------------------------------------
#  # Fixed bandwidth estimate (non-separable)
#  # This could be time consuming
#  classic.dens <- spattemp.density(pp = unmark(amazon), h = bwS0, tt = amazon$marks,
#                                   sres = 64, tres = 64,
#                                   lambda = bwt0,
#                                   sedge = "uniform")

## -----------------------------------------------------------------------------
#  # In this case we let the algorithm to choose the numbers of groups
#  # It could be time consuming
#  adapt.dens <- dens.par(X = amazon,
#                         dimyx = 64, dimt = 64,
#                         bw.xy = bwS, bw.t = bwt,
#                         at = "bins")

## ---- fig.align="center"------------------------------------------------------
#  # We select some fixed times for visualisation
#  I <- c(12, 18, 23, 31, 55)
#  
#  # We subset the lists
#  CN <- as.imlist(classic.dens$z[I])
#  AN <- as.imlist(adapt.dens[I])
#  
#  # We generate the plots
#  plot.imlist(CN, ncols = 5, main = 'Classic fixed-bandwidth estimate')
#  plot.imlist(AN, ncols = 5, main = 'Adaptive non-separable estimate')

## ---- eval = FALSE------------------------------------------------------------
#  animation::saveVideo(
#    for(i in 1:length(adapt.dens)){
#      plot(adapt.dens[[i]], main = paste("Time",i))
#    },
#    video.name="amazon.mp4", other.opts = '-b:v 1M -pix_fmt yuv420p',
#    ani.width = 640, ani.height = 640, interval = 1 / 12)
#  

