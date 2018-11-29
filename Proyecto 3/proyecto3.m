clear all;
close all; 
clc;

data = xlsread('proyecto 3','DATASET1','A2:N1431');
Ytrain=data(:,end)';
Xtrain=data(:,1:end-1)';
datatest = xlsread('proyecto 3','PREDICCION','A2:N290');
Y=datatest(:,end)';
X=datatest(:,1:end-1)';

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

%% recuperar las medidas del entrenamiento de la mejor red

Yg=table{i,4}(Xtrain);
Yg=round(Yg);

TP=sum(Ytrain==1&Yg==1);
TN=sum(Ytrain==0&Yg==0);
FP=sum(Ytrain==0&Yg==1);
FN=sum(Ytrain==1&Yg==0);

Accu=(TP+TN)/(TP+TN+FP+FN);
Prec=TP/(TP+FP);
Rec=TP/(TP+FN);

[Accu Prec Rec] 