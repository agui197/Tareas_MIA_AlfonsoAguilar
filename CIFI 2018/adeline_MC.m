function [Wmc,J]=adeline_MC(X,Y,k)
Xa=func_polinomio(X,k);
Wmc=inv(Xa'*Xa)*Xa'*Y; 
Yg_mc=Xa*Wmc;
E=Y-Yg_mc;
J=E'*E/(2*m);
end
