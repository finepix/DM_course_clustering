clear;clc;close all;
addpath('algorithm');

%% load data and normalization
load data/3circle.mat
c = length(unique(Y));

%%
%using euclidean distance measurement
distmat=zeros(size(X,1),size(X,1));

for i=1:size(X,1)
    for j=i:size(X,1)
        distmat(i,j)=sqrt((X(i,1:2)-X(j,1:2))*(X(i,1:2)-X(j,1:2))');
    end
end

for i=1:size(X,1)
    for j=i:size(X,1)
        distmat(j,i)=distmat(i,j);
    end
end

% k_dist=zeros(size(data,1),1);
% figure
% for k=3:5
%     for i=1:size(data,1)
%         tmp=sort(distmat(:,i),'ascend');
%         k_dist(i)=tmp(k);
%     end
%     hold on
%     plot(1:size(data,1),k_dist);
% end
%%
Eps=0.7;
MinPts=5;
Clust = DBSCAN(distmat,Eps,MinPts);

x=X(:,1);
y=X(:,2);
%plot different clusters
figure
for i=1:max(Clust)
    hold on
    scatter(x(Clust==i),y(Clust==i),'filled');
end

%plot the noise
hold on
scatter(x(Clust==0),y(Clust==0),'*')
title('DBSCAN')