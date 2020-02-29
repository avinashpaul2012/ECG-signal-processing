clc
clear
fs=1000;
load('original_ECG.mat')
%The reason for taking window length as 1400 is in total 10000 samples of
%original there are 8 r peaks to cover atlest one peak we have taken 1400
%length.

output=original(1612:3011);
dft=fft(output);

i=0:(length(output))-1;
fo=i*fs/length(output);

%plotting
figure(1)
subplot(2,1,1)
plot(fo,20*log10(abs(dft)))
subplot(2,1,2)
plot(fo,(180/pi)*angle(dft))
mag=20*log10(abs(dft(3)))
phase=(180/pi)*angle(dft(3))