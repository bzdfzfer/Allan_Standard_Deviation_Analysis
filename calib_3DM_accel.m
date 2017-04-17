close all;
clear;
clc;

load('./data/Static_3DM.mat');
Static_3DM = Static_3DM(3600*200*2+1:end-1800*200,:);
[Num,dim] = size(Static_3DM);
time = Static_3DM(:,1);
ax = Static_3DM(:,2);
ay = Static_3DM(:,3);
az = Static_3DM(:,4);

fs = 200;
pts = 400;

figure(1);

subplot(2,3,1);
omega = ax;
[T1,sigma1] = allan(omega , fs ,pts ); 
T1 = T1(20:end);
sigma1 = sigma1(20:end);sigmax = sigma1; 
loglog(T1,sigma1);
hold on;
[bx,Tt] = curvefitting(T1,sigma1,2);
loglog(T1,sum(Tt*bx,2),'r');
arw = Tt(:,1)*bx(1);loglog(T1,arw,'g');text(1,bx(1),[' \leftarrow ARW:' num2str(bx(1))]);
biasIn = Tt(:,2)*bx(2);loglog(T1,biasIn,'g');text(200,bx(2),[' \leftarrow Bias Instability:' num2str(bx(2))]);
title('Accel X');grid on; legend('accelerator','curve fitting','VRW & bias (in)stability');

subplot(2,3,2);
omega = ay;
[T1,sigma1] = allan(omega , fs ,pts );
T1 = T1(20:end);
sigma1 = sigma1(20:end);sigmay = sigma1;
loglog(T1,sigma1);
hold on;
[by,Tt] = curvefitting(T1,sigma1,2);
loglog(T1,sum(Tt*by,2),'r');
arw = Tt(:,1)*by(1);loglog(T1,arw,'g');text(1,by(1),[' \leftarrow ARW:' num2str(by(1))]);
biasIn = Tt(:,2)*by(2);loglog(T1,biasIn,'g');text(200,by(2),[' \leftarrow Bias Instability:' num2str(by(2))]);
title('Accel Y');grid on; legend('accelerator','curve fitting','VRW & bias (in)stability');

subplot(2,3,3);
omega = az;
[T1,sigma1] = allan(omega , fs ,pts );
T1 = T1(20:end);
sigma1 = sigma1(20:end);sigmaz = sigma1;
loglog(T1,sigma1);
hold on;
[bz,Tt] = curvefitting(T1,sigma1,2);
loglog(T1,sum(Tt*bz,2),'r');
arw = Tt(:,1)*bz(1);loglog(T1,arw,'g');text(1,bz(1),[' \leftarrow ARW:' num2str(bz(1))]);
biasIn = Tt(:,2)*bz(2);loglog(T1,biasIn,'g');text(200,bz(2),[' \leftarrow Bias Instability:' num2str(bz(2))]);
title('Accel Z');grid on; legend('accelerator','curve fitting','VRW & bias (in)stability');

subplot(2,1,2);
loglog(T1, sigmax,T1,sigmay, T1, sigmaz);
hold on;

B = [bx,by,bz]';
B = rms(B);
loglog(T1,sum(Tt*B',2),'r','LineWidth',2);
loglog(T1,Tt(:,1)*B(1),'g','LineWidth',2);
loglog(T1,Tt(:,2)*B(2),'g','LineWidth',2);
title('Accel');grid on; legend('accelerator','curve fitting(RMS)','VRW & bias (in)stability(RMS)');

%% evaluation result: 
% Accels:                                           datasheet:
% in-run bias stability : 0.022214 mg                        0.04 mg
% angular random walk:    62.488   ug/sqrt(Hz)               80   ug/¡ÌHz

