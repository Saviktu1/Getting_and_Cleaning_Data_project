# Codebook for data.txt file resulted by run_analysis.R script.

## About the original data

Data used is originally from following working paper.

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Detailed description is found by following links in README.md and by downloading the datasets. There are files README.txt and features_info.txt that give comprehensive explanation.

Project_dataset.zip file contains all original data and you can find it in this repository as well.

## About data.txt

Data.txt contains headers describing content of column. Columns are following:

1. Subject - Id for subject ranging between 1 to 30.

2. Activity_names - What is the activity of measurement. Activities are laying, sitting, standing, walking, walking_downstairs and walking_upstairs.

3. Feature - Name of the variable on hand. Variables are following:
	1. fBodyAccJerkMag
	2. fBodyAccJerkX 
	3. fBodyAccJerkY 
	4. fBodyAccJerkZ 
	5. fBodyAccMag 
	6. fBodyAccX       
	7. fBodyAccY 
	8. fBodyAccZ 
	9. fBodyGyroJerkMag
	10. fBodyGyroMag
	11. fBodyGyroX
	12. fBodyGyroY      
	13. fBodyGyroZ
	14. tBodyAccJerkMag
	15. tBodyAccJerkX
	16. tBodyAccJerkY
	17. tBodyAccJerkZ
	18. tBodyAccMag     
	19. tBodyAccX
	20. tBodyAccY
	21. tBodyAccZ
	22. tBodyGyroJerkMag
	23. tBodyGyroJerkX
	24. tBodyGyroJerkY  
	25. tBodyGyroJerkZ
	26. tBodyGyroMag
	27. tBodyGyroX
	28. tBodyGyroY
	29. tBodyGyroZ
	30. tGravityAccMag  
	31. tGravityAccX
	32. tGravityAccY
	33. tGravityAccZ    
   
   Abbreviations are following:
    f = Frequency domain signal
	t = Time domain signal
	Body = Body motion
	Gravity = Gravity motion 
	Acc = Accelerometer
	Gyro = Gyroscope
	Jerk=Jerk signal
	X = X-dimension
	Y = Y-dimension
	Z = Z-dimension
	Mag=Magnitude of three-dimensional signals, X, Y and Z.

4. mean - Average of means for each observation.

5. std - Average of standard deviation for each observation.

