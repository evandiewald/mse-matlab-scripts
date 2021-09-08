function [time,force,disp1,disp2] = readfull(file_name)
% Reads in the data from a text file
% input: file_name - name of the file
% output: data vectors of time, force, displacement, and velocity

temp = textread(file_name,'','headerlines',22);

time = temp(:,1);
force = temp(:,2);
disp1 = temp(:,3)/1000;
disp2 = temp(:,4)/1000;


end 