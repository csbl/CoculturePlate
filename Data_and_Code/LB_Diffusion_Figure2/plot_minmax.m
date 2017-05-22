function [ ] = plot_minmax( t, avg, min, max, color, style)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
X=[t;flipud(t)];                %#create continuous x value array for plotting
Y=[min;flipud(max)];          %#create y values for out and then back
h = fill(X,Y,color);                            %#plot filled area
set(h,'facealpha',.3,'EdgeColor','none')
hold on
plot(t,avg,'Color',color,'LineStyle',style)
hold off
end
