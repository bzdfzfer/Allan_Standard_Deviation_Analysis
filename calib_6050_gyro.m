close all;
clear;
clc;

load('./data/loitor_mpu6050.mat');

loitor_mpu6050 = loitor_mpu6050(3600*200*2+1:end-1800*200,:);
[Num,dim] = size(loitor_mpu6050);
time = loitor_mpu6050(:,1);

gx = loitor_mpu6050(:,5);
gy = loitor_mpu6050(:,6);
gz = loitor_mpu6050(:,7);

fs = 200;
pts = 400;
fitting_type = 3;
figure(1);

subplot(2,3,1);
omega = gx;
[T1,sigma1] = allan(omega , fs ,pts ); 
T1 = T1(20:end);
sigma1 = sigma1(20:end);sigmax = sigma1; 
loglog(T1,sigma1);
hold on;
[bx,Tt] = curvefitting(T1,sigma1,fitting_type);
loglog(T1,sum(Tt*bx,2),'r');
arw = Tt(:,1)*bx(1);loglog(T1,arw,'g');text(1,bx(1),[' \leftarrow ARW:' num2str(bx(1))]);
biasIn = Tt(:,2)*bx(2);loglog(T1,biasIn,'g');text(200,bx(2),[' \leftarrow Bias Instability:' num2str(bx(2))]);
rrw = Tt(:,3)*bx(3);loglog(T1,rrw,'g');
title('Gyro X');grid on; legend('angular velocity','curve fitting','ARW & bias (in)stability');

subplot(2,3,2);
omega = gy;
[T1,sigma1] = allan(omega , fs ,pts );
T1 = T1(20:end);
sigma1 = sigma1(20:end);sigmay = sigma1;
loglog(T1,sigma1);
hold on;
[by,Tt] = curvefitting(T1,sigma1,fitting_type);
loglog(T1,sum(Tt*by,2),'r');
arw = Tt(:,1)*by(1);loglog(T1,arw,'g');text(1,by(1),[' \leftarrow ARW:' num2str(by(1))]);
biasIn = Tt(:,2)*by(2);loglog(T1,biasIn,'g');text(200,by(2),[' \leftarrow Bias Instability:' num2str(by(2))]);
rrw = Tt(:,3)*by(3);loglog(T1,rrw,'g');
title('Gyro Y');grid on; legend('angular velocity','curve fitting','ARW & bias (in)stability');

subplot(2,3,3);
omega = gz;
[T1,sigma1] = allan(omega , fs ,pts );
T1 = T1(20:end);
sigma1 = sigma1(20:end);sigmaz = sigma1;
loglog(T1,sigma1);
hold on;
[bz,Tt] = curvefitting(T1,sigma1,fitting_type);
loglog(T1,sum(Tt*bz,2),'r');
arw = Tt(:,1)*bz(1);loglog(T1,arw,'g');text(1,bz(1),[' \leftarrow ARW:' num2str(bz(1))]);
biasIn = Tt(:,2)*bz(2);loglog(T1,biasIn,'g');text(200,bz(2),[' \leftarrow Bias Instability:' num2str(bz(2))]);
rrw = Tt(:,3)*bz(3);loglog(T1,rrw,'g');
 title('Gyro Z');grid on; legend('angular velocity','curve fitting','ARW & bias (in)stability');

subplot(2,1,2);
loglog(T1, sigmax,T1,sigmay, T1, sigmaz);
hold on;

B = [bx,by,bz]';
% B = [bx,by]';
B = rms(B);
loglog(T1,sum(Tt*B',2),'r','LineWidth',2);
loglog(T1,Tt(:,1)*B(1),'g','LineWidth',2);
loglog(T1,Tt(:,2)*B(2),'g','LineWidth',2);
loglog(T1,Tt(:,3)*B(3),'g','LineWidth',2);
title('Gyro');grid on; legend('angular velocity','curve fitting(RMS)','ARW & bias (in)stability(RMS)');
