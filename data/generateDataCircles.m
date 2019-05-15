close all
figure;

num = 100;


mu = [2 3];             %��ֵ
sigma = [1 0; 0 2];       %Э������� 2x2��
r = mvnrnd(mu,sigma,num);         %100��������
plot(r(:,1),r(:,2),'r+');          %��ɫ��+���
 
hold on;           %��������ͬһ��ͼ��
 
mu = [5 8];                         %��ǰ���mu�͸����ǵ���
sigma = [ 1 0; 0 2];
r2 = mvnrnd(mu,sigma,num);
plot(r2(:,1),r2(:,2),'b*')        %��ɫ��*���


hold on

mu = [7 0];
sigma = [ 1 0; 0 2];
r3 = mvnrnd(mu,sigma,num);
plot(r3(:,1),r3(:,2),'go')        %��ɫ��*���

X = [r; r2; r3];
for i = 1:size(X,1)
    text(X(i,1)+0.003, X(i,2)-0.01, num2str(i));
end

Y = [ones(num,1); 2*ones(num,1); 3*ones(num,1)];
save data X Y