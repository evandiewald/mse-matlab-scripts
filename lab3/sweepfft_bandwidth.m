clear
close all
clc

%% Reading file and plotting

%reading file
[time,force]=readf('Exp_1_3_force.txt');

% fft of force signal
fft_force=fft(force);
fft_value=abs(fft_force); %absolute value
freq_axis=[0:1/time(end):(length(time)-1)*1/time(end)]; %creating frequency vector

% plot time force
figure(1);
plot(time,force)
xlabel('Time (s)')
ylabel('Amplitude')

%% FFT plot and peak amplitude determination

figure(2);
plot(freq_axis,fft_value)
xlim([0 15])
hold on
xlabel('frequency (Hz)')
ylabel('Amplitude')
title('FFT of sine-sweep')

% Select region for max value (preferably a flat region)
xx=ginput(2);
indx=find(freq_axis>xx(1,1) & freq_axis<xx(2,1));
plot(freq_axis(indx),fft_value(indx),'r')

% peak amplitude or flat region
peak_amplitude = mean(fft_value(indx));

% amplitude at bandwidth 
amplitude_at_bandwidth = 0.707*peak_amplitude;


%% Finding lower bound of bandwidth, select region
yy=ginput(2);
indx_lower = find(freq_axis>yy(1,1) & freq_axis<yy(2,1));
plot(freq_axis(indx_lower),fft_value(indx_lower),'color','k','Linewidth',2)

tmp = abs(fft_value(indx_lower)-amplitude_at_bandwidth);
[val1 idx1] = min(tmp); %index of closest value

%amplitude of fft at lower bound of bandwidth
lower_amp = fft_value(indx_lower(1)+idx1-1); 

%frequency at lower bound of bandwidth
lower_freq = freq_axis(indx_lower(1)+idx1-1);

%plot lower bound
plot(lower_freq,lower_amp,'*r','Linewidth',5)

if abs(lower_amp/amplitude_at_bandwidth)<0.8  || abs(lower_amp/amplitude_at_bandwidth)>1.2
    disp('POSSIBILITY OF AN ERROR IN CALCULATION')
    disp('TRY SELECTING A WIDER REGION FOR LOWER BOUND')
end

%% Finding upper bound of bandwidth, select region
zz=ginput(2);
indx_upper = find(freq_axis>zz(1,1) & freq_axis<zz(2,1));
plot(freq_axis(indx_upper),fft_value(indx_upper),'color','m','Linewidth',2)

tmp = abs(fft_value(indx_upper)-amplitude_at_bandwidth);
[val2 idx2] = min(tmp); %index of closest value

%amplitude of fft at lower bound of bandwidth
upper_amp = fft_value(indx_upper(1)+idx2-1);

%frequency at lower bound of bandwidth
upper_freq = freq_axis(indx_upper(1)+idx2-1);

%plot upper bound
plot(upper_freq,upper_amp,'*r','Linewidth',5)

if abs(upper_amp/amplitude_at_bandwidth)<0.8  || abs(upper_amp/amplitude_at_bandwidth)>1.2
    disp('POSSIBILITY OF AN ERROR IN CALCULATION')
    disp('TRY SELECTING A WIDER REGION FOR UPPER BOUND')
end

%% Bandwidth calculation
disp(['Bandwidth of this signal is from ' num2str(lower_freq) ' Hz to ' num2str(upper_freq) ' Hz'])


%% Plot of FFt in decibels
figure(3);
plot(freq_axis,20*log10(fft_value))
xlim([0 15])
hold on
xlabel('frequency (Hz)')
ylabel('Amplitude (dB)')
grid on
plot(lower_freq,20*log10(lower_amp),'*r','Linewidth',5)
plot(upper_freq,20*log10(upper_amp),'*r','Linewidth',5)
