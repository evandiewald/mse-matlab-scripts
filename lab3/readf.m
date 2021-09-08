function [time,force]=readf(filename)

a=textread(filename,'','headerlines',21);
time=a(:,1);
force=a(:,2);

end