function  [l,sd,sn] = flystats(time_sleep,mysleeprec);
l[];
sd[];
sn[];

for t= [0:12:96],
   sn = findclosest(t+12);
   sd = findclosest(t);
   l = min(sn:sd) 
end
