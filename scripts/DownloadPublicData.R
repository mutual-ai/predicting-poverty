## DOWNLOAD PUBLIC DATA ##
# Functional and publicly available as of August 2016 #

setwd('predicting-poverty') # Set working directory to where you downloaded the replication folder
rm(list=ls())
library(R.utils)

# Downloads nightlights data (about 400 MB zipped and 750 MB unzipped per year), saves the relevant raster, then deletes unused files locally
dir.create('data/input/Nightlights')
for (year in 2010:2013){
  url <- paste0('http://ngdc.noaa.gov/eog/data/web_data/v4composites/F18', year, '.v4.tar')
  temp <- paste0('data/input/Nightlights/', year)
  dir.create(temp)
  dest <- paste0(temp, '/F18', year, '.v4.tar')
  download.file(url, dest)
  untar(dest, exdir = temp)
  file <- list.files(temp)
  file <- file[substr(file, nchar(file)-27, nchar(file))=='stable_lights.avg_vis.tif.gz']
  tif <- paste0(temp, '/', file)
  file <- substr(file, 1, nchar(file)-3)
  gunzip(tif, paste0(temp, '/', file))
  unlink(paste0(temp, '/', list.files(temp)[list.files(temp)!=file]), recursive = T)
  print(year)
  rm(dest, file, temp, tif, url, year)
}

# Download elevation data from DIVA-GIS
dir.create('data/input/DIVA-GIS')
countries <- c('UGA', 'TZA', 'MWI', 'NGA')
for (country in countries){
  url <- paste0('http://biogeo.ucdavis.edu/data/diva/alt/', country, '_alt.zip')
  temp <- paste0('data/input/DIVA-GIS')
  dest <- paste0(temp, '/', country, '_alt.zip')
  download.file(url, dest)
  unzip(dest, exdir = temp)
  unlink(paste0(temp, '/', country, '_alt.zip'))
  rm(url, temp, dest)
}

unload(R.utils)