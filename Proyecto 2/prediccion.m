function [Accu,Prec,Rec,J,Yg,Wopt]=prediccion(X,Y,grado)


%grado=2;
%Regresion logistica

m=size(X,1);

%Xa=[ones(m,1) X];
%Xa=[ones(m,1) X.^2];
Xa=func_polinomio(X,grado);

W=zeros(size(Xa,2),1);
[J,dJdW]=fun_costo(W,Xa,Y);

options=optimset('GradObj','on','MaxIter',1000);

[Wopt,Jopt]=fminunc(@(W)fun_costo(W,Xa,Y),W,options);

V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg);
%Yg=Yg>=.5;

TP=sum(Y==1&Yg==1);
TN=sum(Y==0&Yg==0);
FP=sum(Y==0&Yg==1);
FN=sum(Y==1&Yg==0);

Accu=(TP+TN)/(TP+TN+FP+FN);
Prec=TP/(TP+FP);
Rec=TP/(TP+FN);
%[Accu Prec Rec]


end