function [Accu,Prec,Rec,red]=red_creation(capas,Ytrain,Xtrain,Y,X)
%Cargar datos

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