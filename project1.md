## Project 1 - How does Dams change river hydrology? (Done in R), [Source Code](https://gp86041.github.io/gepuprojects.github.io/project1_files/project1.R)


- Project/Tool Purpose: Discover your dam of interest and how they are changing ur river flow.
- Project/Tool {Input} and [Output]: {USGS Gage Peak Flow Data, NOAA Rain Gage Data} --> [how cumulative rainfall effect river peak flow]
- Example Site Location: Genesee River
- Project Duration: 1926-2015
- **PLEASE note: you would need some minimum R and R Studio knowledge to use this tool.**

---


----------


### Section 1. Getting Farmiliar with the site

According to [wiki](https://en.wikipedia.org/wiki/Mount_Morris_Dam), Mount Morris Dam was built between 1948 and 1952. Here are some great pictures of this magnificant dam:


<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/Mount_Morris_Dam_pic1.jpg" height="200" width="250">
<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/mt-morris-dam-crossing_pic2.jpg" height="200" width="250">

Here is where everything is. **_Red_** label is the USGS flow gage station. **_Blue_** label is the dam location.

<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1V3AqSlnYUAsSHSV4Pq100ZS-TYQ" width="300" height="300"></iframe>

---


----------


### Section 2. Getting data input. ###
### If you do not wish to go through this section, you can download data input for [peak flow](https://gp86041.github.io/gepuprojects.github.io/project1_files/project1_genesseall.csv) and [precipitation](https://gp86041.github.io/gepuprojects.github.io/project1_files/project1_climate.csv) directly. Then move on to Section 4. ###

**USGS Peak Flow Data**

- I. Head over to the [USGS site](https://nwis.waterdata.usgs.gov/ny/nwis/peak/?site_no=04231600&agency_cd=USGS), and this page displays the annual peakflow (which is a fancy word for the highest flow in a given duration) from 1785 to 2015. 
- II. Download all peakflow data by clicking on the "Tab-separated file" option or click [here](https://nwis.waterdata.usgs.gov/ny/nwis/peak?site_no=04231600&agency_cd=USGS&format=rdb).
- III. Once the data is downloaded, mannully delete all metadata which starts with the symbole "#". You can do this in a text editor or in R Studio directly. Rename your file as '**project1_genesseall**'.
- VI. Now, the peakflow data is ready for input, you can import the text file by typing below in R:

```{.r}
genesseallm <- read.delim("~/Downloads/project1_genesseall.txt"); ##Remember to change your file path accordingly
##here we rename out peakflow data as "genesseallm"
View(peakflow)
```

- V. Upon excuting the codes above, you will see something like this (sorry it is shrinked, but hopefully you get the idea):
<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/peakflow_input.png" height="200" width="1300">

- VI. The data we will need is in the columns of "**peak_dt**" (date) and "**peak_va**" (peak flow).

**NOAA Precipitation Data (at Rochester Airport)**

- I. Head over to the [NCDC site for daily climate](https://www7.ncdc.noaa.gov/CDO/cdodateoutmod.cmd?p_ndatasetid=10&p_cqueryby=ENTIRE&datasetabbv=GSOD&p_asubqueryitems=99999914768&p_asubqueryitems=72529014768), and follow the instructions on this page to select all of the avalible data from the Rochester Airport, select the option with "Comma Delimited". 
- II. Download all weather gage data by clicking on the text file (you will see a similar screen like below (click on image to zoom in):

<img src="https://gp86041.github.io/gepuprojects.github.io/project1_files/location.jpg" height="300" width="400">

- III. Once the data is downloaded,  rename your file as '**project1_climate**'. You can import the text file by typing below in R:

```{.r}
#install package 'readr' before running the script below
library(readr)
climate <- read_csv("C:/Users/jeffj/Downloads/project1_climate.txt") ##Remember to change your file path accordingly
##here we rename out peakflow data as "climate"
View(project1_climatel)
```
- V. Upon excuting the codes above, you will be able to import the gage data from the airport.

- VI. The data we will need is in the columns of "**YEARMODA**" (date) and "**PRCP**" (precipitation in inches).

Now you are ready to organize the data.

---


----------


### Section 3. Data organization

Here we are going to organize our data before the analysis.

- I. Once you have both of your peakflow and precipitation data ready, let's start organizing the data by cleaning them up a bit. 
- II. For the **climate** data, there are two tasks which need to be done:
	- II.I extract only "**YEARMODA**" (date) and "**PRCP**" (precipitation) columns.
	- II.II remove the last "G" symbol in the **PRCP** column, and then replace all 99.9 values with 0 values (replace with 0 instead of null because it will be easier for later correlation analysis).
```{.r}
#II.I
climate<-data.frame(climate$YEARMODA, climate$PRCP)
#II.II
climate$PRCP<-substr(climate$PRCP, 1, 4) 
#here we ignore the last letter for records in the PRCP column
climate$PRCP([climate$PRCP==99.9])<-0
#replace all 99.9 values with 0 values
```

- III. For the **geneseeallm** data, you would need to extract only the columns of "**peak_dt**" (date) and "**peak_va**" (peak flow).

```{.r}
#III
geneseeallm<-data.frame(geneseeallm$peak_dt, geneseeallm$peak_va)
```

-------


----------


### Section 4. Building analysis functions (two functions total).

####**Function 1.**
First, we are going to build our correlation function between cumulative rainfall and annual peak flow step-by-step.

- I. Cumulative precipitation using moving sum function.

```{.r}
movsum<-function(x){
  filter(x,rep(1,nn),sides=1)
}
```

Here we used **filter** function, it applies a moving sum function over a time series. For example, if you have a list of data like 1,1,1,1,1,1,1,1,1, you want to apply a moving sum at a window of 3 records, and you only care about all data past the record of interest. **x** is the number of observations before the data you would want to sum up. You can write it below:

```{.r}
filter(rep(1,9),rep(1,3),side=1)
```

This will transform the original data from 1,1,1,1,1,1,1,1,1 to NA,NA,3,3,3,3,3,3,3. Hope you get what I mean here.

- II. Alright, after building the moving sum function, we can start applying the movesum function to the precip data.

```{.r}
test<-data.frame(climate[,1],as.numeric(movsum(climate[,2])))
```

**test** is the first stage "data holder" of the function, for holding the data after applying the movesum function. **test** data has two columns, the first column is the time of the precipitation from the original precip record. The second column is the data output from the original precip.

- III. Match the cumulative summed data with the peak flow data and getting rid of NA values. 

```{.r}
test2<-data.frame(genesseall,test[match(genesseall[,1],climate[,1]),2])

test2[is.na(test2)]<-0
```

**test2** is the second data holder to combine the peakflow data and the move summed data, this combination was done through using the **match** function, as well as using the **[]**. For NA values, we replaced them with 0s. Moving sum can not be carried out with NA values.

- IV. Conducting correlation test. 

```{.r}
test3<-cor(test2, method="spearman")
```

**test3** is the third data holder for storing results from the correlation test. We did assume that either the peakflow or cumulative rainfall is non-normal distribution. Thus, we used the spearman correlation.

- IV. Print results. 

```{.r}
print(test3[2,3])
```

Since **test3** hold the results of the correlations, we can then extract the value of how many days was cumulated and the correlation values.  

- IV. Combine all components of **function 1**. 

```{.r}
tf<-function(nn){
movsum<-function(x){
  filter(x,rep(1,nn),sides=1)
}

test<-data.frame(climate[,1],
            as.numeric(movsum(climate[,2])))


test2<-data.frame(genesseall,
                  test[match(genesseall[,1],climate[,1]),2])

test2[is.na(test2)]<-0

test3<-cor(test2,method="spearman")
#test3<-rcorr(as.matrix(test2), type="spearman")$P[2,3]

#print(test2)
print(test3[2,3])
}
```
You will notice that **function 1** has another function inside of it to calculate the move sum. This not only save spaces, but also combines them into one powerful correlation function. 


----------


####Function 2.



More to come....

### Mean and Variance Changes in Flow

---
---
[Back to Main Page](https://gp86041.github.io/gepuprojects.github.io/)
