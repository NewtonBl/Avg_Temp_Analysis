# Avg_Temp_Analysis
This project utilized daily high and low temperature records from NOAA weather data for Grand Haven, MI. 

The temperature data required some cleaning and tidying as much data was missing, and each row contained two temperature observations, which was corrected by gathering the separate columns "TMAX" and "TMIN" into a single variable as values.

Daily min and max temperatures were grouped by year and month, and the mean for each group was calculated. The monthly means were then plotted, and December averages were marked with points for comparison.

It should be noted that much of the data between August 2016 and August 2018 was missing. There are also other noticable gaps in data throughout the data taken from NOAA. This data is thus not likely reliable for true comparisons, but the underlying code and methods are viable for use with more robust data.
