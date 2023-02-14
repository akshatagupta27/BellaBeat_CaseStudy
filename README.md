# BellaBeat_CaseStudy
BellaBeat Data Analysis Case Study, a part of Google Data Analytics Capstone Project.

## Introduction
Urška Sršen and Sando Mur founded Bellabeat, a high-tech company that manufactures health-focused smart products. Sršen used her background as an artist to develop beautifully designed technology that informs and inspires women around the world. Collecting data on activity, sleep, stress, and reproductive health has allowed Bellabeat to empower women with knowledge about their own health and habits. Since it was founded in 2013, Bellabeat has grown rapidly and quickly positioned itself as a tech-driven wellness company for women. 
By 2016, Bellabeat had opened offices around the world and launched multiple products. Bellabeat products became available through a growing number of online retailers in addition to their own e-commerce channel on their website. The company has invested in traditional advertising media, such as radio, out-of-home billboards, print, and television, but focuses on digital marketing extensively. Bellabeat invests year-round in Google Search, maintaining active Facebook and Instagram pages, and consistently engages consumers on Twitter. Additionally, Bellabeat runs video ads on Youtube and display ads on the Google Display Network to support campaigns around key marketing dates. 
Sršen knows that an analysis of Bellabeat’s available consumer data would reveal more opportunities for growth. She has asked the marketing analytics team to focus on a Bellabeat product and analyze smart device usage data in order to gain insight into how people are already using their smart devices. Then, using this information, she would like high-level recommendations for how these trends can inform Bellabeat marketing strategy. 

## Scenario
You are a junior data analyst working on the marketing analyst team at Bellabeat, a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. You have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. The insights you discover will then help guide marketing strategy for the company. You will present your analysis to the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy.

## Ask
   ### 1.1 Business Task
    Analyze smart device usage data in order to gain insight into how consumers use non-Bellabeat smart devices.
    Select one Bellabeat product to apply these insights.
    
   ### 1.2 Deliverables
        1. A clear summary of the business task.
        2. A description of all data sources used.
        3. Documentation of any cleaning or manipulation of data.
        4. A summary of analysis.
        5. Supporting visualizations and key findings.
        6. High-level content recommendations based on the analysis.
        
    
   ### 1.3 Key Stakeholders
        1. Urška Sršen: Bellabeat’s cofounder and Chief Creative Officer
        2. Sando Mur: Mathematician, Bellabeat’s cofounder and key member of the Bellabeat executive team
        3. Bellabeat marketing analytics team: A team of data analysts guiding Bellabeat's marketing strategy.
        
## Prepare
   1. Data is available on FitBit Fitness Tracker Data (CC0: Public Domain, dataset made available through Mobius): This Kaggle data set contains personal fitness           tracker from thirty fitbit users. Thirty eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for                 physical activity, heart rate, and sleep monitoring. It includes information about daily activity, steps, and heart rate that can be used to explore users’             habits. 
   2. There are few Limitation. 
      1.1 Data collected from year 2016. Users' daily activity, fitness and sleeping habits, diet and food consumption may have changed since then, hence data may not           be timely or relevant.
      1.2 Data is not much reliable as there are only 30 respondants.
      1.3 Data is third party so is not orignal and even less cited.
      
## Process
      1. Tools being used are Microsoft SQL Server Management Studio for preparing and processing data. Tableau Public for Visualization.
      2. Cleaning and Processing Data:
         --Duplicate in DailyActivity
         SELECT Id, ActivityDate, TotalSteps, Count(*)
         FROM dailyActivity
         GROUP BY id, ActivityDate, TotalSteps
         HAVING Count(*) > 1;

         --Date Formatting
         Update dailyActivity
         Set ActivityDate = Convert(date, ActivityDate, 21);

         --Add Day of Week
         Alter Table dailyActivity
         ADD Days nvarchar(50)

         --Add Date Name
         Update dailyActivity
         SET Days = DATENAME(DW, ActivityDate)

         --Date Formatting of dailyIntensities

         Update dailyIntensities
         Set ActivityDate = Convert(date, ActivityDate, 21);

         --Date Formatting of dailyCalories

         Update dailyCalories
         Set ActivityDate = Convert(date, ActivityDate, 21);

         -- Average of Intensities according to Days

         select Days, Avg(VeryActiveDistance) as VeryActiveDistance , 
         Avg(ModeratelyActiveDistance) as ModeratelyActiveDistance, 
         Avg(LightActiveDistance) as LightlyActiveDistance from dailyActivity group by Days

         -- Avg of Calories to Avg Distance
         select ActivityDate, Avg(Calories) as Calories, AVG(TotalSteps) as Steps 
         from dailyActivity Group By ActivityDate

         --Avg of Steps Vs Avg Sleep Minutes Vs Avg Calories

         select dA.ActivityDate, Avg(dA.TotalSteps) as Steps, Avg(dA.Calories) as Calories,
         Avg(sD.TotalMinutesAsleep) as Sleep  from dailyActivity dA inner join 
         sleepDay sD on dA.Id=sD.Id Group BY dA.ActivityDate

## Analyze & Share
   --Steps taken to calories
   
      select ActivityDate, Avg(Calories) as Calories, AVG(TotalSteps) as Steps 
      from dailyActivity Group By ActivityDate
   
      
   ![Steps Vs Calories](https://user-images.githubusercontent.com/56431569/218692447-fd85f386-4bf2-46a6-8792-7e7e75ce649c.png)

      This Shows how the number of steps taken affects the Calorie. As we can see in the chart, Calorie burns according to the Steps taken.
      Average Calorie 2312.2 and Average Steps 7667.
      
   ![Steps, Distance Coorelation (1)](https://user-images.githubusercontent.com/56431569/218687683-7a338175-b6b6-4a7e-9d62-eaf6c9c98b36.png)

      
      Distance and Steps correlation with R-Squared to 0.970047 and P-Value<0.0001

  
  -- Average of Intensities according to Days

      select Days, Avg(VeryActiveDistance) as VeryActiveDistance , 
      Avg(ModeratelyActiveDistance) as ModeratelyActiveDistance, 
      Avg(LightActiveDistance) as LightlyActiveDistance from dailyActivity group by Days
      
  ![Active level per day (1)](https://user-images.githubusercontent.com/56431569/218684898-f1e5c21a-ec71-45c7-b3d8-d028a88f0515.png)
  
      1. Most Active Day is Wednesday.
      2. Least Active day is Saturday.
      
  --Avg of Steps Vs Avg Sleep Minutes Vs Avg Calories

      select dA.ActivityDate, Avg(dA.TotalSteps) as Steps, Avg(dA.Calories) as Calories,
      Avg(sD.TotalMinutesAsleep) as Sleep  from dailyActivity dA inner join 
      sleepDay sD on dA.Id=sD.Id Group BY dA.ActivityDate
      
   ![Sleep Minutes vs Steps Vs Calorie](https://user-images.githubusercontent.com/56431569/218686098-50cd189d-75a4-457f-bfbf-1dc75551234b.png)
      
      1. As shown in the first chart steps and calorie are directly proportionate. 
      2. Here is the relation between steps, sleep and calorie.
      
      
## Act

After performig Ask, prepare, process, Analyze now we Act. Provide recommendations based on Analysis

      1. Trends identified:
         Not all users keelp track of the Sleep.
         Users majorly perform Light Activities or are Sedentary.
         Sleep plays an essential role in the Calorie burned.
         
      2. Recommendations:
         Users should be notified every hour to walk so they are not stationary for a longer period of time.
         Provide users with notification to have atleast 7-8hrs of sleep daily.
         Could provide points on every avtivity they track on application and show how are they performing with respct to other users on application.
         Features to be set to calculate minimum amount of calories to be burnt daily according to age, weight and height.
         
         
         
         
         
# Thank You
      
      
      
      
