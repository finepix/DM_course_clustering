clear;clc;close all;
addpath('algorithm');

%% load data and normalization
load data/two_moon.mat
c = length(unique(Y));
n = size(X, 1);

% reshuffle X
num0 = n/2;
index_1 = randperm(num0);
X1 = X(index_1, :);
index_2 = randperm(num0) + num0;
X2 = X(index_2, :);

X = [X1 ; X2];

clear num0 index_1 index_2
%% construct graph by KNN

% construct
options = [];
options.NeighborMode = 'KNN';
options.WeightMode = 'HeatKernel';
options.k = 7;
A = constructW(X,options);
A = full(A);

%% plot before Ncut
% view on matrix A
imagesc(A);
title('Affinity Matrix');
colorbar
pause(0.5);

% plot KNN graph
la = Y;
fig_twomoon = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;

for i = 1:size(A, 1)
    for j =1:size(A, 2)
        if A(i, j) > 0
%             plot(X(i, :), X(j, :));
            plot([X(i, 1) X(j, 1)], [X(i, 2) X(j, 2)]);
            pause(0.0001);
        end
    end
end

title('KNN Graph');


%% Ncut

D = diag(sum(A));
nRepeat = 10;
Ini = zeros(n, nRepeat);
for jj = 1 : nRepeat
    Ini(:, jj) = randsrc(n, 1, 1:c);
end;

fprintf('Normalized Cut\n');
Dd = diag(D);
Dn = spdiags(sqrt(1./Dd),0,n,n);
An = Dn*A*Dn;
An = (An+An')/2;
[Fng, D] = eig1(full(An), c, 1, 1);
% Fng = Fng./repmat(sqrt(sum(Fng.^2,2)),1,c);  %optional
% res = tuneKmeans(Fng, Ini);

%% results measure
% post processing for result by K-means
res=litekmeans(Fng,c,'MaxIter',100,'Replicates',10);

res = bestMap(Y,res);
result_NCut = ClusteringMeasure(Y, res);
fprintf('NCut clustering result: accuracy=%.2f, MIhat=%.2f, purity=%.2f \n',result_NCut(1)*100,result_NCut(2)*100,result_NCut(3)*100);

%% plot result
% indicate matrix 
fig_F = figure;
imagesc(Fng);
title('Indicate Matrix');
colorbar
pause(0.4);

% result 
la = res;
fig_Ncut = figure; 
plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
title('Two Moon Data');
title('Ncut');