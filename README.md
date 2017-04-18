# Allan_Standard_Deviation_Analysis
AD Analysis For IMU Stochastic Noise Models
Two functions are offered to:

	calculate the allan variance(allan.m) 
and 

	get the relevant stochastic noise process parameters(curvefitting.m).
	
# Usage:
	
Please refer to calib_6050_gyro.m or any other calib files.

# Note:
the dataset is too big to upload so one can download in the following links:
	[loitor_mpu6050.mat](http://pan.baidu.com/s/1qXEK7Vm)
	[Static_3DM.mat](http://pan.baidu.com/s/1boYhT7L).
	
When finished, put them into the 'data' folder.
(Warning, loitor_mpu6050's gyro output unit is degree/s while the Static_3DM's is rad/s, please be careful when dealing with the unit transformation.)
	
## data format for each line in the .mat file:

	timestamp ax ay az gx gy gz 

