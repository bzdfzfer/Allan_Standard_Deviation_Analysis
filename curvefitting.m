function [b,Tt] = curvefitting(T1,sigma1,fitting_type)
X = T1;
Y = sigma1;

L = length(X);
Tt = [];
if fitting_type == 5
    % quantilization || arw || bias instability || rrw || rate slope 
    Tt = zeros(L,5); % 拟合时间序列，单位：秒
    for i=1:L
        Tt(i,1) = 1/X(i);
        Tt(i,2) = 1/sqrt(X(i));
        Tt(i,3) = 1;
        Tt(i,4) = sqrt(X(i));
        Tt(i,5) = X(i);
    end
elseif fitting_type == 3
    % arw bias & instability & rrw
    Tt = zeros(L,3); % 拟合时间序列，单位：秒
    for i=1:L
        Tt(i,1) = 1/sqrt(X(i));
        Tt(i,2) = 1;
        Tt(i,3) = sqrt(X(i));
    end
elseif fitting_type == 2
    %  arw and rrw
    % Tt = zeros(L,2); % 拟合时间序列，单位：秒
    % for i=1:L
    %     Tt(i,1) = 1/sqrt(X(i));
    %     Tt(i,2) = sqrt(X(i));
    % end

    % arw and bias instability
    Tt = zeros(L,2); % 拟合时间序列，单位：秒
    for i=1:L
        Tt(i,1) = 1/sqrt(X(i));
        Tt(i,2) = 1;
    end
end
b = regress(Y,Tt); %调用拟合函数求出拟合结果

% sigma_fit = sum(Tt*b,2);
% hold on;
% loglog(X,sigma_fit,'r');
% 
% arw = Tt(:,1)*b(1);
% loglog(X,arw,'g');
% text(1,b(1),[' \leftarrow ARW:' num2str(b(1))]);
% 
% biasIn = Tt(:,2)*b(2);
% loglog(X,biasIn,'g');
% text(200,b(2),[' \leftarrow Bias Instability:' num2str(b(2))]);
% 
% % rrw = Tt(:,3)*b(3);
% % loglog(X,rrw,'g');
% 
% temp = zeros(5,1);
% temp(1) = b(1)/sqrt(3); %量化噪声
% temp(2) = b(2); %角度随机游走系数 (rad/s.^0.5)
% temp(3) = b(3)/0.6643; % 零偏不稳定性(deg/h)
% temp(4) = b(4)*sqrt(3); %角速率游走系数（deg/s/s.^0.5)
% temp(5) = b(5)*sqrt(2); %随机斜坡(deg/s/s)
