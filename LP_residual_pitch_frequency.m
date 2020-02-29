
clc;
clear all;
close all;
[y,fs] = audioread('science.wav');
%y=y(1:90000);

% for i=1:length(y)-1
%     y(i+1)=y(i+1)-.95*y(i);  % pre emphasis
% end
y_f=y(25001:26000);
figure;

% for k=1:1000
% y1(k)=sin(2*pi*500*k/4000)+sin(2*pi*100*k/4000);
% end
% y_f=y1;

w=hamming(1000);
y_w=y_f.*w;
subplot(3,1,1);
plot(y_f);
title('framed signal');
xlabel('Sample Number');
ylabel('Amplitude');
a=lpc(y_w,10);
a1=lpc(y_w,12);
a2=lpc(y_w,8);


est_y = filter([0 -a(2:end)],1,y_w);
est_y1 = filter([0 -a(2:end)],1,y_f);
subplot(3,1,2);
plot(est_y1);
title('estimated signal');
xlabel('Sample Number');
ylabel('Amplitude');
e=y_f-est_y1;
subplot(3,1,3);
plot(e);
title('error signal');
xlabel('Sample Number');
ylabel('Amplitude');
[h,w] = freqz(1,a,1000);
count=0;
h11=20*log10(abs(h));
for i=2:length(h)-1
    if(h11(i)>h11(i-1) & h11(i)>h11(i+1))
        count=count+1;
        p(count)=w(i)*360;
        z(count)=h11(i);
    end
end
disp('Formant Frequency(rad/samples)')
Formant_Frequency=p
[h1,w] = freqz(1,a1,1000);
[h2,w] = freqz(1,a2,1000);
figure(2);
plot(w/pi,20*log10(abs(h)));
hold on;
plot(w/pi,20*log10(abs(h1)));
hold on;
plot(w/pi,20*log10(abs(h2)));
hold on;
y_fft=fft(est_y);
y_fft=y_fft(1:500);
w=w(1:500);
w=2*w;
plot(w/pi,20*log10(abs(y_fft)));
title('Comarison of LP spectrum of different order and FFT spectrum');
xlabel('normalised frequency')
ylabel('20 log(abs(response)) in db')
legend('LP spectrum of order 10','LP spectrum with order 12','LP spectrum with order 8','FFT spectrum')


