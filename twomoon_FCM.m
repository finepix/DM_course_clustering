clear;clc;close all;
addpath('algorithm');

%% load data and normalization
load data/two_moon.mat
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
la = Y;
fig_twomoon = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
title('Two Moon Data');

%% result
% fig_clustering = figure;
la = res;
fig_fcm = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;

% plot fcm centers
plot(centers(1,1),centers(1,2),'x','MarkerSize',15,'LineWidth',3)
plot(centers(2,1),centers(2,2),'x','MarkerSize',15,'LineWidth',3)

% draw text by threshold
U_max = max(U, [], 1);
threshold = 0.6;            % 0.9
for i = 1:size(X,1)
    
    if U_max(i) < threshold
        text(X(i,1)+0.003, X(i,2)-0.01, num2str(i));
        pause(0.02);
    end
end
title(['FCM,threshold=', num2str(threshold)]);
