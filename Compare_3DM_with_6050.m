close all;
clear;
clc;

load('./data/Static_3DM.mat');
load('./data/loitor_mpu6050.mat');

time_loitor = loitor_mpu6050(:,1);
gyro_loitor = loitor_mpu6050(:,5:end);
gyro_loitor = gyro_loitor*pi/180;
acc_loitor  = loitor_mpu6050(:,2:4);

time = Static_3DM(:,1);
gyro = Static_3DM(:,5:end);
acc  = Static_3DM(:,2:4);

figure(1);
subplot(3,1,1),plot(time_loitor,gyro_loitor(:,1),'r.');hold on;plot(time,gyro(:,1),'b.');title('gyroscope x');xlabel('time:s');ylabel('angular veoclity:rad/s');legend('loitor','3DM');
subplot(3,1,2),plot(time_loitor,gyro_loitor(:,2),'r.');hold on;plot(time,gyro(:,2),'b.');title('gyroscope y');xlabel('time:s');ylabel('angular veoclity:rad/s');legend('loitor','3DM');
subplot(3,1,3),plot(time_loitor,gyro_loitor(:,3),'r.');hold on;plot(time,gyro(:,3),'b.');title('gyroscope z');xlabel('time:s');ylabel('angular veoclity:rad/s');legend('loitor','3DM');

figure(2);
subplot(3,1,1),plot(time_loitor,acc_loitor(:,1),'r.');hold on;plot(time,acc(:,1),'b.');title('accelerometer x');xlabel('time:s');ylabel('Acceleration:m^2/s');legend('loitor','3DM');
subplot(3,1,2),plot(time_loitor,acc_loitor(:,2),'r.');hold on;plot(time,acc(:,2),'b.');title('accelerometer y');xlabel('time:s');ylabel('Acceleration:m^2/s');legend('loitor','3DM');
subplot(3,1,3),plot(time_loitor,acc_loitor(:,3),'r.');hold on;plot(time,acc(:,3),'b.');title('accelerometer z');xlabel('time:s');ylabel('Acceleration:m^2/s');legend('loitor','3DM');

figure(5);
discrete_value = unique(gyro_loitor(:,1));
count = hist(gyro_loitor(:,1),discrete_value);
percetage = count/size(gyro_loitor,1);
plot(discrete_value,percetage,'ro');
hold on;
discrete_value = unique(gyro(:,1));
count = hist(gyro(:,1),discrete_value);
percetage = count/size(gyro,1);
plot(discrete_value,percetage,'b*');