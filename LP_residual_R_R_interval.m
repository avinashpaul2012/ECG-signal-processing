clc;
clear all;
close all;
Fs=360;
load('C:\Users\hp\Desktop\biomedical_assignment\assignment6\ecgSignal.mat');

y=ecgSignal;
%y_n=y/max(y);
y_n=(y-mean(y))/max(y);
y=y_n;
a = lpc(y,3);
est_y = filter([0 -a(2:end)],1,y);
a1 = lpc(y,2);
est_y1 = filter([0 -a1(2:end)],1,y);
figure(1);
plot(1:3600,y,1:3600,est_y);
grid
title('Comparison of original signal and LPC estimate');
xlabel('Sample Number')
ylabel('Normalised Amplitude')
legend('Original signal','LPC estimate with order 3')

figure(2);
subplot(3,1,1);
plot(y);
title('original signal');
xlabel('sample Number');
ylabel('Normalised Amplitude');
subplot(3,1,2);
plot(est_y);
title('predicted signal');
xlabel('sample Number');
ylabel('Normalised Amplitude');
subplot(3,1,3);
e=y-est_y;
e1=y-est_y1;
s=sum(e.^2)
s1=sum(e1.^2)

plot(e);
title('LP residual');
xlabel('sample Number');
ylabel('Normalised Amplitude');


