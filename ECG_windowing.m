clc;
clear;
close all;
load('original_ECG.mat','-mat');
Fs=1000;
x = original;
l=length(x);
ft_x=fftshift(fft(x));
df=Fs/l;
f=-Fs/2:df:Fs/2-df;
mag=abs(ft_x);
%plot(mag);
magft=mag(30);
mag_db=20*log10(magft)

% windowing of signal
td=0.025;
fd=td*Fs;
wi_no= l/fd ;

%hamming window w(n)=0.54?0.46cos(2?n/M?1)0?n?M?1

for i=0:(fd-1)
    ham_w(1,(i+1))= 0.54-0.46*cos(2*pi*i/(fd-1));
end

%hanning window w(n)=0.54?0.46cos(2?n/M?1)0?n?M?1

for i=0:(fd-1)
    han_w(1,(i+1))= 0.5-0.5*cos(2*pi*i/(fd-1));
end 

%bartlett window w(n)= 2n/N 0<=n<=N/2 and 2-2n/N N/2<=n<=N

for i=0:(fd-1)
     bar_w(1,(i+1))= 1-abs((i-(fd-1)/2)/((fd-1)/2));
end 

for i=1:wi_no   
    wd_1(i,:)=x((i-1)*fd+1:fd*i);
    wd_hm(i,:)= ham_w(1,:).*wd_1(i,:);
    wd_hn(i,:)= han_w(1,:).*wd_1(i,:);
    wd_br(i,:)=  bar_w(1,:).*wd_1(i,:);
end


hmfin_f1= reshape(wd_hm',1,[]);
hmfin_f = fft(hmfin_f1);
hnfin_f1= reshape(wd_hn',1,[]);
hnfin_f = fft(hnfin_f1);

brfin_f1= reshape(wd_br',1,[]);
brfin_f = fft(brfin_f1);


figure(1)
hold on;
plot(abs(hmfin_f));

title('hamming window spectrum');

figure(2)
plot(abs(hnfin_f));
title('hanning window spectrum');

figure(3)
plot(abs(brfin_f));
title('bartlet window spectrum');

        
        
    
