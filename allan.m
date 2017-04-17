function [T,sigma] = allan(omega,fs,pts)
%inputs:
%       omega = set of measurements(number of row is number of
%       measurements)
%       fs    = frequency of mensurements
%       pts   = number of points to plot in Allan variance
%outputs:
%       T     = Time spans of allan variance points
%       sigma = Allan standard deviation

% figure out how big the output data set is
[N,M] = size(omega);
% determine largest bin size
%max bin size is N/2,N is the data size.
n = 2.^(0:floor(log2(N/2)))'; 
maxN = n(end);

endLogInc = log10(maxN);

% create log spaced vector average factor
m = unique(ceil(logspace(0,endLogInc,pts)))'; 

% t0 = sample interval
t0 = 1/fs;
% T = length of time for each cluster
T = m*t0; 


% integration of samples over time to obtain output angle ¦È
theta = cumsum(omega)/fs; 


% array of dimensions (cluster periods) X (#variables)
sigma2 = zeros(length(T),M);

tic
% loop over the various cluster sizes
for i=1:length(m) 
        % implements the summation in the AV equation
    for k=1:N-2*m(i) 
        sigma2(i,:) = sigma2(i,:) + (theta(k+2*m(i),:) - 2*theta(k+m(i),:) + theta(k,:)).^2;
    end
end
sigma2 = sigma2./repmat((2*T.^2.*(N-2*m)),1,M);
sigma = sqrt(sigma2);
toc 
end