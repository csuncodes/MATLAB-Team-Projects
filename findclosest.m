function [value, index]= findclosest(mysleeprec,time_sleep) 
[value, index] = min(abs(mysleeprec-time_sleep))
end
