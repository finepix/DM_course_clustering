clear;clc;close all;
addpath('algorithm');

%% load data and normalization
load data/3circle.mat
c = length(unique(Y));

%% Clustering using kmeans
res=litekmeans(X,c,'MaxIter',100,'Replicates',10);

%% results measure
res = bestMap(Y,res);
result_Kmeans = ClusteringMeasure(Y,res);
fprintf('Kmeans clustering result: accuracy=%.2f, MIhat=%.2f, purity=%.2f \n',result_Kmeans(1)*100,result_Kmeans(2)*100,result_Kmeans(3)*100);

%% plot
% origin data
fig_origin = figure;
for i = 1:size(X,1)
    if Y(i) == 1
        plot(X(i,1),X(i,2),'r+'); 
        hold on
    elseif Y(i) == 2
        plot(X(i,1),X(i,2),'b*');
        hold on
    else
        plot(X(i,1),X(i,2),'go');
        hold on
    end
end
title('Origin Data');

% result
clustering_data = figure;
for i = 1:size(X,1)
    if res(i) == 1
        plot(X(i,1),X(i,2),'r+'); 
        hold on
    elseif res(i) == 2
        plot(X(i,1),X(i,2),'b*');
        hold on
    else
        plot(X(i,1),X(i,2),'go');
        hold on
    end
end
title('k-means');
