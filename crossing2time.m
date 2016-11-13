function [time_sleep,mysleeprec] = crossings2sleep(times,crossings)
active_times = [];
mysleeprec = [];
time_sleep = [];
active = find(crossings);
for i = 1:length(active)
    active_times(end+1) = active(i);
end
for j = 2:length(active_times)
    if (active_times(j)-times(j-1)) >= 0.0833
        mysleeprec(end+1) = (active_times(j)-times(j-1));
        time_sleep(end+1) = (active_times(j)+times(j-1))/2;
    end
end
end
