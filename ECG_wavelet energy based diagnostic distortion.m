clc;
clear all;
load('original_ECG.mat');
y=original;
[c,l] = wavedec(y,3,'db1');
subplot(4,1,1);
plot(y);
subplot(4,1,2);
plot(c);
for i=1:10000
    z(i)=y(i)+200*sin(2*pi*.5*i/1000);
end
[cn,l] = wavedec(z,3,'db1');
subplot(4,1,4);
plot(cn);
subplot(4,1,3);
plot(z);    

% subplot(4,2,1);
% plot(c);
% subplot(4,2,2);
% plot(cn);
d=0;
dn=0;
n=[0,0,0,0];
n1=[0,0,0,0];
s1=[0,0,0,0];

for i=1:10000
    d=d+c(i)^2;
    dn=dn+cn(i)^2;    
end
for i=1:l(1)
    n(1)=n(1)+c(i)^2;
    n1(1)=n1(1)+cn(i)^2;
    s1(1)=s1(1)+(c(i)-cn(i))^2;
end
for i=l(1)+1:l(1)+l(2)
    n(2)=n(2)+c(i)^2;
    n1(2)=n1(2)+cn(i)^2;
     s1(2)=s1(2)+(c(i)-cn(i))^2;
end
for i=l(1)+1+l(2):l(1)+l(2)+l(3)
    n(3)=n(3)+c(i)^2;
     n1(3)=n1(3)+cn(i)^2;
      s1(3)=s1(3)+(c(i)-cn(i))^2;
end
for i=l(1)+l(2)+l(3)+1:l(1)+l(2)+l(3)+l(4)
    n(4)=n(4)+c(i)^2;
     n1(4)=n1(4)+cn(i)^2;
      s1(4)=s1(4)+(c(i)-cn(i))^2;
end
w=n/d;
wn=n1/dn;
wp=s1./n;
WPRD=sqrt(wp);
WEDD=w.*WPRD;
Fs = 1000;                                                   % Sampling Frequency (Hz)
Fn = Fs/2;                                                  % Nyquist Frequency)
Ws = 0.5/Fn;                                                % Passband Frequency Vector (Normalised)
Wp = 1.5/Fn;                                                % Stopband Frequency Vector (Normalised)
Rp =   0.5;                                                   % Passband Ripple (dB)
Rs = 1.5;                                                   % Stopband Attenuation (dB)
[n,Wp] = ellipord(Wp,Ws,Rp,Rs);                             % Calculate Filter Order
[z1,p,k] = ellip(n,Rp,Rs,Wp,'high');                         % Default Here Is A Lowpass Filter
[sos,g] = zp2sos(z1,p,k);                                    % Use Second-Order-Section Implementation For Stability
yf = filtfilt(sos,g,z);
% subplot(4,2,3);
% plot(yf);% Filter S
[cf,l] = wavedec(z,3,'db1');
% subplot(4,2,4);
% plot(cf);
df=0;
nf=[0,0,0,0];
s2=[0,0,0,0];

for i=1:10000
    df=df+cf(i)^2;
end
for i=1:l(1)
    nf(1)=nf(1)+cf(i)^2;
    s2(1)=s2(1)+(cf(i)-cn(i))^2;
end
for i=l(1)+1:l(1)+l(2)
    nf(2)=nf(2)+cf(i)^2;
     s2(2)=s2(2)+(cf(i)-cn(i))^2;
end
for i=l(1)+1+l(2):l(1)+l(2)+l(3)
    nf(3)=nf(3)+cf(i)^2;
      s2(3)=s2(3)+(cf(i)-cn(i))^2;
end
for i=l(1)+l(2)+l(3)+1:l(1)+l(2)+l(3)+l(4)
    nf(4)=nf(4)+cf(i)^2;
      s2(4)=s2(4)+(cf(i)-cn(i))^2;
end
wf=nf/df;
wpf=s2./nf;
WPRDf=sqrt(wpf);
WEDDf=w.*WPRD;

