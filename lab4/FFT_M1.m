%% FFT Content - Method 1

% This method uses all of the data

close all; clear all; clc;

[t,disp1,disp2]=readf('L4R_E3_T1.txt');

y1 = disp1;
y2 = disp2;

% CAR 1 FFT
figure(1)
plot(t,y1)

T=30; %seconds
Fs=1000; %Sampling Rate

t_vector= 0:1/Fs:T-1/Fs;
freq_vector= 0:1/T:Fs-1/T;

figure(2)
hold on;
plot(freq_vector,abs(fft(y1)/(length(y1)/2)))
xlim([0 10])


% CAR 2 FFT
figure(3)
plot(t,y2)

T=30; %seconds
Fs=1000; %Sampling Rate

t_vector= 0:1/Fs:T-1/Fs;
freq_vector= 0:1/T:Fs-1/T;

figure(2)
hold on;
plot(freq_vector,abs(fft(y2)/(length(y2)/2)))
xlim([0 6])
legend({'Car 1','Car 2'});
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Method 1: Frequency Content for Exp 3 - Test 1');