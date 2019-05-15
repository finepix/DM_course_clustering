close all
figure;

num = 100;


mu = [2 3];             %均值
sigma = [1 0; 0 2];       %协方差矩阵 2x2的
r = mvnrnd(mu,sigma,num);         %100个点生成
plot(r(:,1),r(:,2),'r+');          %红色的+标记
 
hold on;           %两组点放在同一张图上
 
mu = [5 8];                         %把前面的mu就给覆盖掉了
sigma = [ 1 0; 0 2];
r2 = mvnrnd(mu,sigma,num);
plot(r2(:,1),r2(:,2),'b*')        %蓝色的*标记


hold on

mu = [7 0];
sigma = [ 1 0; 0 2];
r3 = mvnrnd(mu,sigma,num);
plot(r3(:,1),r3(:,2),'go')        %蓝色的*标记

X = [r; r2; r3];
for i = 1:size(X,1)
    text(X(i,1)+0.003, X(i,2)-0.01, num2str(i));
end

Y = [ones(num,1); 2*ones(num,1); 3*ones(num,1)];
save data X Y