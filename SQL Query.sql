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

select Days, Avg(VeryActiveMinutes) as VeryActiveMinutes , 
Avg(FairlyActiveMinutes) as FairlyActiveMinutes, 
Avg(LightlyActiveMinutes) as LightlyActiveMinutes, 
Avg(SedentaryMinutes) as SedentaryMinutes from dailyActivity group by Days

-- Avg of Calories to Avg Distance
select ActivityDate, Avg(Calories) as Calories, AVG(TotalSteps) as Steps 
from dailyActivity Group By ActivityDate

--Avg of Steps Vs Avg Sleep Minutes Vs Avg Calories

select dA.ActivityDate, Avg(dA.TotalSteps) as Steps, Avg(dA.Calories) as Calories,
Avg(sD.TotalMinutesAsleep) as Sleep  from dailyActivity dA inner join 
sleepDay sD on dA.Id=sD.Id Group BY dA.ActivityDate

