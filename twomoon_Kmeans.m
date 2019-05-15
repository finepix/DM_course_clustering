clear;clc;close all;
addpath('algorithm');

%% load data and normalization
load data/two_moon.mat
c = length(unique(Y));

%% Clustering using kmeans
res=litekmeans(X,c,'MaxIter',100,'Replicates',10);

%% results measure
res = bestMap(Y,res);
result_Kmeans = ClusteringMeasure(Y,res);
fprintf('Kmeans clustering result: accuracy=%.2f, MIhat=%.2f, purity=%.2f \n',result_Kmeans(1)*100,result_Kmeans(2)*100,result_Kmeans(3)*100);

%% plot

% origin data
la = Y;
fig_twomoon = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
title('Two Moon Data');

% result
la = res;
fig_result = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
title('K-means');
