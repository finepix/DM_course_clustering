%% clear and clc
clear; clc; close all;

%% generate two moon data

num0 = 200;
X = twomoon_gen(num0);
Y = [ones(num0,1); 2*ones(num0,1)];
save two_moon.mat X Y

%% plot
la = Y;
fig_twomoon = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
