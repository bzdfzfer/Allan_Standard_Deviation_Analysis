clear;
close all;
clc;

eps_file_path = './results/loitor_gyroscope.eps';
%   [result,msg] = eps2pdf(epsFile,fullGsPath,orientation)
fullGsPath = 'C:\Program Files\gs\gs9.21\bin\gswin64.exe';
orientation = 0;
[result,msg] = eps2pdf(eps_file_path,fullGsPath,orientation);
eps_file_path = './results/loitor_accelerometer.eps';
[result,msg] = eps2pdf(eps_file_path,fullGsPath,orientation);