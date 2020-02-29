clear all;
close all;
clc;
[y,fs] = audioread('science.wav');

subplot(3,1,1);
plot(y);
a1=sqrt(10);
a2=1;
a3=1/sqrt(10);
y1=y+a1*randn(size(y));
y2=y+a2*randn(size(y));
y3=y+a3*randn(size(y));
subplot(3,1,2);
plot(y2);
% z=autocorr(y1);
% Rxx=toeplitz(z);
fs=32000;
f_d = 0.015;
f_size = 500;%round(f_d * fs);
n = length(y);
n_f = floor(n/f_size);  %no. of frames
temp = 0;
temp1=0;
for i = 1 : n_f
   frames(i,:) = y(temp + 1 : temp + f_size);
   temp = temp + f_size;
   x=frames(i,:);
   frames1(i,:) = y1(temp1 + 1 : temp1 + f_size);
   temp1 = temp1 + f_size;
   x1=frames1(i,:);
   z1=xcorr(x1,x1);
   z=z1(f_size:end);
   Rxx=toeplitz(z);
   Rxy1=xcorr(x1,x);
   Rxy=Rxy1(1:f_size);
   h=inv(Rxx)*Rxy';
   x_r=filter(h,1,x1);
   frames2(i,:)=x_r;
end
id=1:n_f;
fr_ws = frames2(id,:);
y_r = reshape(fr_ws',1,[]);
subplot(3,1,3);
plot(y_r);
sound(y_r,fs);

y_o=y(1:length(y_r));
noise=y_o-y_r';
r = snr(y_o,noise)