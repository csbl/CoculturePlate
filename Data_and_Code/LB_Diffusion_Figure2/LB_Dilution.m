%% Thomas J. Moutinho Jr.
% Created: January 2017

%% Read Growth Curve Data
clear all
close all
clc

% e: data variable structure --> 9 columns: 
e1 = [];
e2 = [];
e3 = [];

% Read Data from first experiment
a = xlsread('TJM_Ecoli_Dilution_2_1_28_17.xlsx','Sheet1','B6:IX37');
t = xlsread('TJM_Ecoli_Dilution_2_1_28_17.xlsx','Sheet1','B4:IX4')/3600;
% Experiment 1 Data and Time
e1(:,1) = (a(1,:)+a(2,:))./2;
e1(:,2) = (a(9,:)+a(10,:))./2;
e1(:,3) = (a(3,:)+a(4,:))./2;
e1(:,4) = (a(11,:)+a(12,:))./2;
e1(:,5) = (a(5,:)+a(6,:))./2;
e1(:,6) = (a(13,:)+a(14,:))./2;
e1(:,7) = (a(7,:)+a(8,:))./2;
e1(:,8) = (a(15,:)+a(16,:))./2;
e1(:,9) =  (a(17,:)+a(18,:))./2;
e1(:,10) = (a(25,:)+a(26,:))./2;
e1(:,11) = (a(19,:)+a(20,:))./2;
e1(:,12) = (a(27,:)+a(28,:))./2;
e1(:,13) = (a(21,:)+a(22,:))./2;
e1(:,14) = (a(29,:)+a(30,:))./2;
e1(:,15) = (a(23,:)+a(24,:))./2;
e1(:,16) = (a(31,:)+a(32,:))./2;
e1(:,17) = t;

% Read Data from second experiment
a1 = xlsread('TJM_Ecoli_Dilution_3_2_11_17.xlsx','Sheet2','B48:IN63');
a2 = xlsread('TJM_Ecoli_Dilution_4_2_13_17.xlsx','Sheet2','B64:IN79');
a = [a1;a2];
t = (xlsread('TJM_Ecoli_Dilution_3_2_11_17.xlsx','Sheet2','B46:IN46'))/3600;
% Experiment 1 Data and Time
e2(:,1) = (a(1,:)+a(2,:))./2;
e2(:,2) = (a(9,:)+a(10,:))./2;
e2(:,3) = (a(3,:)+a(4,:))./2;
e2(:,4) = (a(11,:)+a(12,:))./2;
e2(:,5) = (a(5,:)+a(6,:))./2;
e2(:,6) = (a(13,:)+a(14,:))./2;
e2(:,7) = (a(7,:)+a(8,:))./2;
e2(:,8) = (a(15,:)+a(16,:))./2;
e2(:,9) =  (a(17,:)+a(18,:))./2;
e2(:,10) = (a(25,:)+a(26,:))./2;
e2(:,11) = (a(19,:)+a(20,:))./2;
e2(:,12) = (a(27,:)+a(28,:))./2;
e2(:,13) = (a(21,:)+a(22,:))./2;
e2(:,14) = (a(29,:)+a(30,:))./2;
e2(:,15) = (a(23,:)+a(24,:))./2;
e2(:,16) = (a(31,:)+a(32,:))./2;
e2(:,17) = t;

% Read Data from third experiment
a = xlsread('TJM_Ecoli_dilution_5_2_20_17.xlsx','Sheet2','B48:IS79');
t = xlsread('TJM_Ecoli_dilution_5_2_20_17.xlsx','Sheet2','B46:IS46')/3600;
% Experiment 1 Data and Time
e3(:,1) = (a(1,:)+a(2,:))./2;
e3(:,2) = (a(9,:)+a(10,:))./2;
e3(:,3) = (a(3,:)+a(4,:))./2;
e3(:,4) = (a(11,:)+a(12,:))./2;
e3(:,5) = (a(5,:)+a(6,:))./2;
e3(:,6) = (a(13,:)+a(14,:))./2;
e3(:,7) = (a(7,:)+a(8,:))./2;
e3(:,8) = (a(15,:)+a(16,:))./2;
e3(:,9) =  (a(17,:)+a(18,:))./2;
e3(:,10) = (a(25,:)+a(26,:))./2;
e3(:,11) = (a(19,:)+a(20,:))./2;
e3(:,12) = (a(27,:)+a(28,:))./2;
e3(:,13) = (a(21,:)+a(22,:))./2;
e3(:,14) = (a(29,:)+a(30,:))./2;
e3(:,15) = (a(23,:)+a(24,:))./2;
e3(:,16) = (a(31,:)+a(32,:))./2;
e3(:,17) = t;

%% Linear interpolatation on equally-spaced intervals of data to compare
e1i = [];
e2i = [];
e3i = [];
n = 400;
min = 0;
max = 24; %MUST BE EDITED if time changes

t = linspace(min, max, n)';
e1i(:,17) = linspace(min, max, n);
e2i(:,17) = linspace(min, max, n);
e3i(:,17) = linspace(min, max, n);
for i = 1:16
    e1i(:,i) = interp1(e1(:,17), e1(:,i), e1i(:,17),'spline');
    e2i(:,i) = interp1(e2(:,17), e2(:,i), e2i(:,17),'spline');
    e3i(:,i) = interp1(e3(:,17), e3(:,i), e3i(:,17),'spline');
end

clear i max min n a e1 e2 e3

%% Avg Min Max Variables
for i = 1:16
W(:,:,i) = [e1i(:,i),e2i(:,i),e3i(:,i)];
W_avg(:,i) = mean(W(:,:,i),2);
W_min(:,i) = min(W(:,:,i),[],2);
W_max(:,i) = max(W(:,:,i),[],2);
end

%% Test plots
for i = 1:16
    figure(i)
    plot(t,W_avg(:,i),t,W_min(:,i),t,W_max(:,i))
end

%% Plot Min Avg Max
close all
% Colorblind-friendly Palette
  % http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
blk = [0,0,0];         %Black
org = [0.9,0.6,0];     %Orange
blu = [0.35,0.7,0.9];  %Sky Blue
gre = [0,0.6,0.5];     %Bluish Green
yel = [0.95,0.9,0.25]; %Yellow
roy = [0,0.45,0.7];    %Royal Blue
red = [0.8,0.4,0];     %Vermillion
pur = [0.8,0.6,0.7];   %Reddish Purple

color = { pur, blk, roy, blk, gre, blk, red, blk, pur, blk, roy, blk, gre, blk, red, blk};
style = {'--', '-','--', '-', '--', '-','--','-', '-', '-', '-', '-', '-', '-', '-', '-'};

for i = 1:16
    figure(1)
    plot_minmax(t,W_avg(:,i),W_min(:,i),W_max(:,i),color{i},style{i})
    hold on
end
h = zeros(16,1);
for i = 1:16
    h(i) = plot(NaN,NaN,'Color',color{i});
end

% title('LB Dilution')
xlim([0,24]);
ylim([.1,1.4]);
xlabel('Time [hours]')
ylabel('OD_6_0_0')
hold off
