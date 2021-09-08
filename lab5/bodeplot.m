% Tutorial for drawing the bode plot
clear all
close all;


% Construct the transfer function
g = tf([1],[0.8 1 400/10]);

% Set the frequency vector that prescribes the range we need the bode plots
% In the experiments we ran random tests in the range of 0.1 to 20 Hz. Theoretical bode works on rad/s
w = (0.1*2*pi:0.04*2*pi:20*2*pi)'; 

% Obtain the bode amplitude and phase as data points
[amp,pha] = bode(g,w); 

% Plotting the bode plot
figure(4)
% Converting the freq to Hz here so that you 
% directly plot your experimental bode on top of it also, be careful 
% with the dB conversion of the amplitude  
subplot(2,1,1)     
semilogx(w/2/pi,20*log10(amp(1,:)))
ylabel('Magnitude (dB)');
grid on 
% Plot the bode phase.                                                        
subplot(2,1,2)  
semilogx(w/2/pi,pha(1,:))%plot the bode phase in degrees
xlabel('Freq (Hz)');
ylabel('Phase (deg)');
grid on