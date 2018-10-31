clc;
clear all;
close all;

data=xlsread('Datos_Proyecto2','datos');
%%
Y=data(2:end,end);
X=data(2:end,1:end-1);

%%

X=X(:,[1,2,3,4,5,6,9,10]);
X=X(:,[1,2,3,4,7,8]);
temp=bsxfun(@minus,X,mean(X));
X=bsxfun(@rdivide,temp,std(X));
covariance=cov(X);
%%
grado=3;
[Accu,Prec,Rec,J,Yg,Wopt]=prediccion(X,Y,grado);
[Accu Prec Rec]
%%
figure(1)
bar(Wopt)
%%
newdata=xlsread('Datos_Proyecto2','Prediccion');
Xnew=newdata(:,[1,2,3,4,9,10]);
temp=bsxfun(@minus,Xnew,mean(Xnew));
Xnew=bsxfun(@rdivide,temp,std(Xnew));
Xa=func_polinomio(Xnew,grado);
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg)