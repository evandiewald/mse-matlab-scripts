function [freq,amp,pha] = readfreq2(filename,minfreq,maxfreq)

% Reads the experimental data to variable a
a = textread(filename,'','headerlines',22); 

% Assigns frequency, magnitude and phase information from the xp data
freq = a(minfreq*40+1:maxfreq*40+1,1);
amp = a(minfreq*40+1:maxfreq*40+1,2);
pha = a(minfreq*40+1:maxfreq*40+1,5);
end
