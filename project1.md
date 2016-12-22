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
- III. Once the data is downloaded, mannully delete all metadata which starts with the symbole "#". You can do this in a text editor or in R Studio directly.
- VI. Now, the peakflow data is ready for input, you can import the text file by typing below in R:

```{.r}
peakflow <- read.delim("~/Downloads/peakflow.txt"); ##Remember to change your file path accordingly
View(peakflow)
```

- V. Upon excuting the codes above, you will see something like this (sorry it is shrinked, but hopefully you get the idea):
<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/peakflow_input.png" height="200" width="1300">

-    
   
   
   
   
   
   




More to come....

### Mean and Variance Changes in Flow

---
---
[Back to Main Page](https://gp86041.github.io/gepuprojects.github.io/)
