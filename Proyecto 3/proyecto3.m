clear all;
close all; 
clc;

%Cargar datos
data = xlsread('Historico','Suma','A2:G671');


Y=data(:,7)';
X=data(:,1:6)';

ndat=round(.9*size(Y,2));
Ytrain=Y(:,1:ndat);
Xtrain=X(:,1:ndat);

%Creación de la red neuronal
red=feedforwardnet([2 4 6]);
red.trainFCn='trainscg';
%'trainrp'
red=train(red,Xtrain,Ytrain);

Yg=red(X);
Yg=round(Yg);

TP=sum(Y==1&Yg==1);
TN=sum(Y==0&Yg==0);
FP=sum(Y==0&Yg==1);
FN=sum(Y==1&Yg==0);

Accu=(TP+TN)/(TP+TN+FP+FN);
Prec=TP/(TP+FP);
Rec=TP/(TP+FN);

[Accu Prec Rec] 

data = xlsread('Historico','P2018predecir','A2:G290');

Y=data(:,7)';
X=data(:,1:6)';

Yg=red(X);
Yg=round(Yg);

TP=sum(Y==1&Yg==1);
TN=sum(Y==0&Yg==0);
FP=sum(Y==0&Yg==1);
FN=sum(Y==1&Yg==0);

Accu=(TP+TN)/(TP+TN+FP+FN);
Prec=TP/(TP+FP);
Rec=TP/(TP+FN);

[Accu Prec Rec]