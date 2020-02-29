clear all;
clc;
load('inputECG.mat');
signal=inputECG;
subplot(4,1,1);
plot(signal);
t=1000;
for i=1:t
  y(i,:) = signal + 150*randn(size(signal));
end
subplot(4,1,2);
plot(y(9,:));

y1=y(1,:);
for i=2:t
    y1=y1+y(i,:);
end
y1=y1/t;
subplot(4,1,3);
plot(y1);
n=0;
d=0;
for i=1:3600
    n=n+(signal(i)-y1(i))^2;
    d=signal(i)^2; 
end
prd=sqrt(n/d)
B = 1/2*ones(2,1);
y2 = filter(B,1,signal);
subplot(4,1,4);
plot(y2);