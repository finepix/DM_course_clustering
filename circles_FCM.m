clear;clc;close all;
addpath('algorithm');

%% load data and normalization
load data/3circle.mat
c = length(unique(Y));

%% Clustering using kmeans
[centers, U]=fcm(X,c);

[~, res] = max(U);

%% results measure
res = bestMap(Y,res);
result_Kmeans = ClusteringMeasure(Y,res);
fprintf('FCM clustering result: accuracy=%.2f, MIhat=%.2f, purity=%.2f \n',result_Kmeans(1)*100,result_Kmeans(2)*100,result_Kmeans(3)*100);

%% plot
% origin data
origin_data = figure;
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

%% result
% fig_clustering = figure;
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
plot(centers(1,1),centers(1,2),'x','MarkerSize',15,'LineWidth',3)
plot(centers(2,1),centers(2,2),'x','MarkerSize',15,'LineWidth',3)
plot(centers(3,1),centers(3,2),'x','MarkerSize',15,'LineWidth',3)
U_max = max(U, [], 1);
threshold = 0.95;            % 0.9
for i = 1:size(X,1)
    
    if U_max(i) < threshold
        text(X(i,1)+0.003, X(i,2)-0.01, num2str(i));
        pause(0.02);
    end
end
title(['FCM,threshold=', num2str(threshold)]);
