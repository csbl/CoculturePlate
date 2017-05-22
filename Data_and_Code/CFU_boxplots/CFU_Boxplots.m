%% Vertical Membrane Co-culture Plate CFU Boxplots
% Thomas Moutinho Spring 2017
clear all
close all
clc

iso = xlsread('Biomass_data_cfu','Sheet1','C3:F6');
comp = xlsread('Biomass_data_cfu','Sheet1','C10:F17');

iso_avg = mean(iso,2);
comp_temp = mean(comp,2);
for i = 1:4
    comp_avg(i) = (comp_temp(2*i-1)+comp_temp(2*i))/2;
end

x = [iso_avg./2,comp_avg'];
labels = {'Isolated','Competing'};
boxplot(x,labels); %,'PlotStyle','compact');
ylabel('CFUs per mL (x10^8)');
ylim([18 25])
