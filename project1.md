## Project 1 - How does Dams change river hydrology? (Done in R), [Source Code](https://gp86041.github.io/gepuprojects.github.io/project1_files/project1.R)


- Project/Tool Purpose: Discover your dam of interest and how they are changing ur river flow.
- Project/Tool {Input} and [Output]: {USGS Gage Peak Flow Data, NOAA Rain Gage Data} --> [how cumulative rainfall effect river peak flow]
- Example Site Location: Genesee River
- Project Duration: 1926-2015
- **PLEASE note: you would need some minimum R and R Studio knowledge to use this tool.**

### Section 1. Getting Farmiliar with the site

According to [wiki](https://en.wikipedia.org/wiki/Mount_Morris_Dam), Mount Morris Dam was built between 1948 and 1952. Here are some great pictures of this magnificant dam:


<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/Mount_Morris_Dam_pic1.jpg" height="200" width="250">
<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/mt-morris-dam-crossing_pic2.jpg" height="200" width="250">

Here is where everything is. **_Red_** label is the USGS flow gage station. **_Blue_** label is the dam location.

<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1V3AqSlnYUAsSHSV4Pq100ZS-TYQ" width="300" height="300"></iframe>

### Section 2. Getting data input and orgnize them. ###
### If you do not wish to go through this section, you can download data input for [peak flow](https://gp86041.github.io/gepuprojects.github.io/project1_files/project1_genesseall.csv) and [precipitation](https://gp86041.github.io/gepuprojects.github.io/project1_files/project1_climate.csv) directly. Then move on to the next section. ###

**USGS Peak Flow Data**

- I. Head over to the [USGS site](https://nwis.waterdata.usgs.gov/ny/nwis/peak/?site_no=04231600&agency_cd=USGS), and this page displays the annual peakflow (which is a fancy word for the highest flow in a given duration) from 1785 to 2015. 
- II. Download all peakflow data by clicking on the "Tab-separated file" option or click [here](https://nwis.waterdata.usgs.gov/ny/nwis/peak?site_no=04231600&agency_cd=USGS&format=rdb).
- III. Once the data is downloaded, mannully delete all metadata which starts with the symbole "#". You can do this in a text editor or in R Studio directly. Rename your file as 'project1_genesseall'.
- VI. Now, the peakflow data is ready for input, you can import the text file by typing below in R:

```{.r}
peakflow <- read.delim("~/Downloads/project1_genesseall.txt"); ##Remember to change your file path accordingly
View(peakflow)
```

- V. Upon excuting the codes above, you will see something like this (sorry it is shrinked, but hopefully you get the idea):
<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/peakflow_input.png" height="200" width="1300">

- VI. The data we will need is in the columns of "peak_dt" (date) and "peak_va" (peak flow).

**NOAA Precipitation Data (at Rochester Airport)**

- I. Head over to the [NCDC site for daily climate](https://www7.ncdc.noaa.gov/CDO/cdodateoutmod.cmd?p_ndatasetid=10&p_cqueryby=ENTIRE&datasetabbv=GSOD&p_asubqueryitems=99999914768&p_asubqueryitems=72529014768), and follow the instructions on this page to select all of the avalible data from the Rochester Airport, select the option with "Comma Delimited"

- II. Download all weather gage data by clicking on the text file (you will see a similar screen like below:
<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/noaa_data_location.jpg" height="500" width="500">

- III. Once the data is downloaded, you can import the text file by typing below in R:

```{.r}
#install package 'readr' before running the script below
library(readr)
precip <- read_csv("C:/Users/jeffj/Downloads/CDO509327307530.txt") ##Remember to change your file path accordingly
View(CDO509327307530)
```





More to come....

### Mean and Variance Changes in Flow

---
---
[Back to Main Page](https://gp86041.github.io/gepuprojects.github.io/)
