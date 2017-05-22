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
a = xlsread('TJM_PABC_1_1_21_17.xlsx','Sheet1','B6:PB37');
t = xlsread('TJM_PABC_1_1_21_17.xlsx','Sheet1','B4:PB4')/3600;
% Experiment 1 Data and Time
e1(:,1) = (a(1,:)+a(2,:)+a(17,:)+a(18,:))./4;   %PAcc
e1(:,2) = (a(9,:)+a(10,:)+a(25,:)+a(26,:))./4;  %BCcc
e1(:,3) = (a(5,:)+a(6,:))./2;   %PAiso
e1(:,4) = (a(13,:)+a(14,:))./2; %PAiso control
e1(:,5) = (a(7,:)+a(8,:))./2; %BCiso
e1(:,6) = (a(15,:)+a(16,:))./2; %BCiso control
e1(:,7) = (a(21,:)+a(22,:)+a(29,:)+a(30,:))./4; %PAcomp
e1(:,8) = (a(23,:)+a(24,:)+a(31,:)+a(32,:))./4; %BCcomp
e1(:,9) = t;

% Read Data from second experiment
a = xlsread('TJM_PABC_2_1_23_17.xlsx','Sheet1','B6:JG37');
t = (xlsread('TJM_PABC_2_1_23_17.xlsx','Sheet1','B4:JG4'))/3600;
% Experiment 1 Data and Time
e2(:,1) = (a(1,:)+a(2,:)+a(17,:)+a(18,:))./4;   %PAcc
e2(:,2) = (a(9,:)+a(10,:)+a(25,:)+a(26,:))./4;  %BCcc
e2(:,3) = (a(5,:)+a(6,:))./2;   %PAiso
e2(:,4) = (a(13,:)+a(14,:))./2; %PAiso control
e2(:,5) = (a(7,:)+a(8,:))./2; %BCiso
e2(:,6) = (a(15,:)+a(16,:))./2; %BCiso control
e2(:,7) = (a(21,:)+a(22,:)+a(29,:)+a(30,:))./4; %PAcomp
e2(:,8) = (a(23,:)+a(24,:)+a(31,:)+a(32,:))./4; %BCcomp
e2(:,9) = t;

% Read Data from third experiment
a = xlsread('TJM_PABC_3_2_5_17.xlsx','Sheet2','B48:IK79');
t = (xlsread('TJM_PABC_3_2_5_17.xlsx','Sheet2','B46:IK46'))/3600;
% Experiment 1 Data and Time
e3(:,1) = (a(1,:)+a(2,:)+a(17,:)+a(18,:))./4;   %PAcc
e3(:,2) = (a(9,:)+a(10,:)+a(25,:)+a(26,:))./4;  %BCcc
e3(:,3) = (a(5,:)+a(6,:))./2;   %PAiso
e3(:,4) = (a(13,:)+a(14,:))./2; %PAiso control
e3(:,5) = (a(7,:)+a(8,:))./2; %BCiso
e3(:,6) = (a(15,:)+a(16,:))./2; %BCiso control
e3(:,7) = (a(21,:)+a(22,:)+a(29,:)+a(30,:))./4; %PAcomp
e3(:,8) = (a(23,:)+a(24,:)+a(31,:)+a(32,:))./4; %BCcomp
e3(:,9) = t;

%% Linear interpolatation on equally-spaced intervals of data to compare
e1i = [];
e2i = [];
e3i = [];
n = 400;
min = 0;
max = 24; %MUST BE EDITED

t = linspace(min, max, n)';
e1i(:,9) = linspace(min, max, n);
e2i(:,9) = linspace(min, max, n);
e3i(:,9) = linspace(min, max, n);
for i = 1:8
    e1i(:,i) = interp1(e1(:,9), e1(:,i), e1i(:,9),'spline');
    e2i(:,i) = interp1(e2(:,9), e2(:,i), e2i(:,9),'spline');
    e3i(:,i) = interp1(e3(:,9), e3(:,i), e3i(:,9),'spline');
end

clear i max min n a e1 e2 e3

%% Avg Min Max Variables
for i = 1:8
W(:,:,i) = [e1i(:,i),e2i(:,i),e3i(:,i)];
W_avg(:,i) = mean(W(:,:,i),2);
W_min(:,i) = min(W(:,:,i),[],2);
W_max(:,i) = max(W(:,:,i),[],2);
end

%% Test plots
for i = 1:8
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

color = {pur, pur, roy, blk, red, blk, roy, red};
style = {'-', '--','-', '-', '-', '-','--','--'};

for i = 1:8
    figure(1)
    plot_minmax(t,W_avg(:,i),W_min(:,i),W_max(:,i),color{i},style{i})
    hold on
end
h = zeros(8,1);
for i = 1:8
    h(i) = plot(NaN,NaN,'Color',color{i});
end
% legend(h, 'PAcc','BCcc','PAiso','PAcontrol','BCiso','BCcontrol','PAcomp','BCcomp','location','northwest');
% title('PA in Coculture with BC')
xlim([0,24]);
ylim([0.1,1.8]);
xlabel('Time [hours]')
ylabel('OD_6_0_0')
hold off
