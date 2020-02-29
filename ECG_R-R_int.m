clc;
clear ;
close all;
%data=importdata('givenECG3.mat');
data=importdata('C:\Users\hp\Desktop\biomedical_assignment\assignment6\ecgSignal.mat');
count=0;
m=max(data);
% counting number of R Peaks
for i=2:length(data)-1
    if(data(i)>data(i-1) & data(i)>data(i+1) & data(i)>0.95*m)
        
        count=count+1;
        p(count)=i;
        y(count)=data(i);
    
    end
end
subplot(2,1,1);

plot(data); hold on;
plot(p,y,'o','MarkerFaceColor','r');
for i=1:length(y)-1
    RR_int(i)=p(i+1)-p(i);
end
subplot(2,1,2);
plot(RR_int);
R_int=mean(RR_int);
fs=360;
heart_rate=(60*fs)/R_int;
hrt_rate=(60*fs)./RR_int;
mean_hrt_rate=mean(hrt_rate)
std_hrt_rate=std(hrt_rate)