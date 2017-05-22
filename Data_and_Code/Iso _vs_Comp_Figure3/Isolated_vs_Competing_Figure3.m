%% Thomas J. Moutinho Jr.
% Created: January 2017

%% Read Growth Curve Data
clear all
close all
clc

e1 = [];
e2 = [];
e3 = [];

% Read Data from first experiment
a = xlsread('TJM_LB_PBS_CON_1_11_22_16.xlsx','Sheet2','B48:HG79');
t = (xlsread('TJM_LB_PBS_CON_1_11_22_16.xlsx','Sheet2','B46:HG46'))/3600;
% Experiment 1 Data and Time
e1(:,1) = (a(1,:)+a(2,:))./2;   %100com
e1(:,2) = (a(9,:)+a(10,:))./2;  %100com
e1(:,3) = (a(3,:)+a(4,:))./2;   %50com
e1(:,4) = (a(11,:)+a(12,:))./2; %50com
e1(:,5) = (a(17,:)+a(18,:))./2; %100iso
e1(:,6) = (a(25,:)+a(26,:))./2; %100iso control
e1(:,7) = (a(19,:)+a(20,:))./2; %50iso
e1(:,8) = (a(27,:)+a(28,:))./2; %50iso control
e1(:,9) = t;

% Read Data from second and third experiment
a = xlsread('TJM_LB_PBS_CON_2_11_23_16.xlsx','Sheet2','B48:GA79');
t = (xlsread('TJM_LB_PBS_CON_2_11_23_16.xlsx','Sheet2','B46:GA46'))/3600;
% Experiment 2 Data and Time
e2(:,1) = (a(1,:)+a(2,:))./2;
e2(:,2) = (a(9,:)+a(10,:))./2;
e2(:,3) = (a(5,:)+a(6,:))./2;
e2(:,4) = (a(13,:)+a(14,:))./2;
e2(:,5) = (a(17,:)+a(18,:))./2;
e2(:,6) = (a(25,:)+a(26,:))./2;
e2(:,7) = (a(21,:)+a(22,:))./2;
e2(:,8) = (a(29,:)+a(30,:))./2;
e2(:,9) = t;
% Experiment 3 Data and Time
e3(:,1) = (a(3,:)+a(4,:))./2;
e3(:,2) = (a(11,:)+a(12,:))./2;
e3(:,3) = (a(7,:)+a(8,:))./2;
e3(:,4) = (a(15,:)+a(16,:))./2;
e3(:,5) = (a(19,:)+a(20,:))./2;
e3(:,6) = (a(27,:)+a(28,:))./2;
e3(:,7) = (a(23,:)+a(24,:))./2;
e3(:,8) = (a(31,:)+a(32,:))./2;
e3(:,9) = t;

%% Linear interpolatation on equally-spaced intervals of data to compare
e1i = [];
e2i = [];
e3i = [];
n = 400;
min = 0;
max = 17.8; %MUST BE EDITED

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
%1: 100com
%2: 100com
%3: 50com
%4: 50com
%5: 100iso
%6: 100iso control
%7: 50iso
%8: 50iso control

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

% color = ['r';'r';'b';'b';'k';'g';'k';'m'];
color = { roy, roy, pur, pur, blk, gre, blk, red};
style = {'--','--','--','--', '-', '-', '-', '-'};

for i = 1:8
    figure(1)
    plot_minmax(t,W_avg(:,i),W_min(:,i),W_max(:,i),color{i},style{i})
    hold on
end
h = zeros(8, 1);
for i = 1:8
    h(i) = plot(NaN,NaN,'Color',color{i});
end
% legend(h, 'Com100','Com100','com50','com50','iso100 control','iso100','iso50 control','iso50','location','northwest');
% title('Assessment of Nutrient Density with E. coli')
xlim([0,17]);
ylim([0.1,1.8]);
xlabel('Time [hours]')
ylabel('OD_6_0_0')
hold off
