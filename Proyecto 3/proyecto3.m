clear all;
close all; 
clc;

data = xlsread('proyecto 3','DATASET1','A2:N1431');
Ytrain=data(:,end)';
Xtrain=data(:,5:9)';
datatest = xlsread('proyecto 3','PREDICCION','A2:N290');
Y=datatest(:,end)';
X=datatest(:,5:9)';

[Accu,Prec,Rec,red]=red_creation(1,Ytrain,Xtrain,Y,X);

%%
mu=0;
i=1;
while(mu<.8)
    len=randi(6);
    for j=1:len
        array(j)=randi(6);
    end
    [table{i,1},table{i,2},table{i,3},table{i,4}]=red_creation(array,Ytrain,Xtrain,Y,X);
    mu=(table{i,1}+table{i,2}+table{i,3})/3;
    table{i,5}=mu;
    i=i+1
    clear array;
    if isnan(mu)
        mu=0;
    end
end 
[v,i]=max([table{:,5}])
save tabla{i,4}