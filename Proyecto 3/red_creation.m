function [Accu,Prec,Rec,red]=red_creation(capas)
%Cargar datos
data = xlsread('proyecto 3','DATASET1','A2:N1431');


Ytrain=data(:,end)';
Xtrain=data(:,1:end-1)';


%Creación de la red neuronal
red=feedforwardnet(capas);
red.trainFCn='trainscg';
%'trainrp'
red=train(red,Xtrain,Ytrain);

Yg=red(Xtrain);
Yg=round(Yg);

TP=sum(Ytrain==1&Yg==1);
TN=sum(Ytrain==0&Yg==0);
FP=sum(Ytrain==0&Yg==1);
FN=sum(Ytrain==1&Yg==0);

Accu=(TP+TN)/(TP+TN+FP+FN);
Prec=TP/(TP+FP);
Rec=TP/(TP+FN);

[Accu Prec Rec] 

datatest = xlsread('proyecto 3','PREDICCION','A2:N290');

Y=datatest(:,end)';
X=datatest(:,1:end-1)';

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

end