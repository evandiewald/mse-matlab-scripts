function [time,disp1,disp2] = readf(file_name)
% Reads in the data from a text file
% input: file_name - name of the file
% output: data vectors of time, force, displacement, and velocity

temp = textread(file_name,'','headerlines',21);

time = temp(:,1);
disp1 = temp(:,2)/1000;
disp2 = temp(:,3)/1000;


end 