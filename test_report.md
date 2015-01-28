Phenology project
========================================================

The objective of this script is to perform an analysis with R in order to investigate if the phenological metrics are affected by the climatic changes. Particularly, is this project the greenup dates for a deciduous forest in Lelystad Netherlands calculated for two different years. Several studies indicated that plant phenology reactes to warmer and wet climate hence, leaf emergence happens earlier, and leaf fall happens later due to milder winters. Based on the above acceptance we will compare two different years expecting that the warmer year results in earliers greenup dates. The end product is in a format that is amenable to simple statistical analysis (histograms and boxplots). Simulteanously a visual comparison could be done among the Vegetation index maps among the several observations.This project is organized by division made between several major tasks: 1) meteorogical KNMI data analysis 2) MODIS remotely sensed data 3) specification of the area of interest 4) calculation of phenological metrics 5) simple statistical analysis and visualization of some results.

Import the required packages:

```r
rm(list=ls()) # clear the workspace

getwd() # make sure the data directory
```

```
## [1] "C:/Git/Project_Geoscripting"
```

```r
# load required packages and functions
library(phenex)
library(sp)
library(raster)
```

```
## 
## Attaching package: 'raster'
## 
## The following object is masked from 'package:phenex':
## 
##     values
```

```r
library(kml)
```

```
## Loading required package: clv
## Loading required package: cluster
## Loading required package: class
## Loading required package: longitudinalData
## Loading required package: rgl
## Loading required package: misc3d
```

```r
library(ggplot2)
library(rgdal)
```

```
## rgdal: version: 0.9-1, (SVN revision 518)
## Geospatial Data Abstraction Library extensions to R successfully loaded
## Loaded GDAL runtime: GDAL 1.11.1, released 2014/09/24
## Path to GDAL shared files: C:/Users/nikos/Documents/R/win-library/3.1/rgdal/gdal
## GDAL does not use iconv for recoding strings.
## Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: C:/Users/nikos/Documents/R/win-library/3.1/rgdal/proj
```

```r
library(googleVis)
```

```
## 
## Welcome to googleVis version 0.5.8
## 
## Please read the Google API Terms of Use
## before you start using the package:
## https://developers.google.com/terms/
## 
## Note, the plot method of googleVis will by default use
## the standard browser to display its output.
## 
## See the googleVis package vignettes for more details,
## or visit http://github.com/mages/googleVis.
## 
## To suppress this message use:
## suppressPackageStartupMessages(library(googleVis))
```

```r
source('R/modisSubset.R')
source('R/getDate.R')
source('R/modisRaster.R')
source('R/df2raster.R')
source('R/DOYstack.R')
source('R/asMap.R')
source('R/getROI.R')
source('R/getPhenology.R')
```

Download for Lelystad flux tower the NDVI band for 2013 and 2014 by using the  ModisSubset function. The reliability is selected as TRUE in order to perform a cloud  cleaning.


```r
ndvi_clear13 <- modisSubset("Lelystad", "NDVI", 2013, rel = TRUE) 
ndvi_clear14 <- modisSubset("Lelystad", "NDVI", 2014, rel = TRUE) 
```

Create raster stacks from the subset MODIS data

```r
stack_2013 <- modisRaster(ndvi_clear13,"Lelystad")
stack_2014 <- modisRaster(ndvi_clear14,"Lelystad")
```

Get observation dates for the selected subsets

```r
DOY2013<- getDate("Lelystad", "NDVI", 2013)
DOY2014<- getDate("Lelystad", "NDVI", 2014)
```

Gives DOY as name in stack's layers

```r
stack2013 <- DOYstack(stack_2013, DOY2013)
stack2014 <- DOYstack(stack_2014, DOY2014)
```

plot an example by looking the names

```r
a<-asMap(stack2013$X1)
```

