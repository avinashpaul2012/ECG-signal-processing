
clc;
clear;
close all;
data=importdata('original_ECG.mat');
fs=1000;
data=data-mean(data);
data=data/max(abs(data));
N=5*fs;
d=data(1:N);
subplot(311),plot(d);
% BaseLineWander Noise Addition
n=1:N;
blwn=0.1*sin(2*pi*n*0.3/fs);
blwn=blwn/(max(abs(blwn)));
dn=d+blwn;
subplot(312),plot(dn);
% Finding R-Peaks and RR Interval of original ECG
m=max(d);count=0;
for i=2:length(d)-1
    if(d(i)>d(i-1) & d(i)>d(i+1) & d(i)>0.95*m)
        
        count=count+1;
        p(count)=i;
        y(count)=d(i);
    
    end
end
for i=1:length(y)-1
    RR_int(i)=p(i+1)-p(i);
end

% Filtering Noised Signal

fc=0.3;
w=2*pi*fc;
[b,a]=butter(5,(w/fs),'high');
dnf=filter(b,a,dn);
%dnf=dnf-mean(dnf);
subplot(313),plot(dnf);

% Finding R-Peaks and RR Interval of Filtered ECG
mf=max(dnf);countf=0;
for i=2:length(dnf)-1
    if(dnf(i)>dnf(i-1) & dnf(i)>dnf(i+1) & dnf(i)>0.95*mf)
        
        countf=countf+1;
        pf(countf)=i;
        yf(countf)=dnf(i);
    
    end
end
for i=1:length(yf)-1
    RR_intf(i)=pf(i+1)-pf(i);
end

alpha=[y(1:3);RR_int];
beta=[yf(1:3);RR_intf];
D=[0.75 0;0 0.75];
CCD=(alpha-beta)'*D*(alpha-beta)
mean(mean(CCD))