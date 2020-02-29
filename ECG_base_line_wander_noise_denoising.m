clc;
load('givenECG3.mat');
y=givenECG3;
subplot(4,1,1);
plot(y);
for i=1:3600
y(i)=y(i)+200*sin(2*pi*.5*i/360)+20*sin(2*pi*50*i/360);
end
subplot(4,1,2);
plot(y);
fc=40;
fs=360;
[b,a] = butter(6,fc/(fs/2));
x=filter(b,a,y);
y1=y(21:end);
x1=x(21:end);
subplot(4,1,3);
plot(x1);


[b1,a1] = butter(3,[0.00005 0.01],'stop');;
x2=filter(b1,a1,x1);
y3=y1(201:end);
x3=x2(201:end);
subplot(4,1,4);
plot(x3);
n=0;
d=0;
for i=1:3380
    n=n+(y3(i)-x3(i))^2;
    d=d+y3(i)^2;
end
PRD=sqrt(n/d)
    
    