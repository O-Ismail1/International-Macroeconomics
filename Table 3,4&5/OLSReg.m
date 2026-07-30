function Reg=OLSReg(y,X);
%function [beta,u,Omega,var_beta,ttest,Rsquared]=OLS(y,X);
[T,K]=size(X);


z=X'*y;
P=X'*X;
beta=P\z;% z/P
%beta=P*y;%numerically the bad way of doing it....
u=y-X*beta;


% you could also compute a Projection matrix and fitted values and then
% compute residuals

Proj=X/(X'*X)*X'; % Projection matrix
y_hat=Proj*y;% Fitted value
u_hat=y-y_hat;% Residuals


%now get the variance of the residuals:
RSS=u'*u;
Omega=[u'*u]./(T-K);
%and  Standard Error of Regression (SER)
%s=sqrt(Omega);


%and the variance of the OLS-estimator, var(vec(beta));

XXI=inv(X'*X);
var_beta=kron(Omega,XXI);

%or Variance Covariance Matrix of the OLS estimator
%Omega_beta=Omega*inv(X'*X);


betadiag=zeros(size(beta));
betadiag(:)=sqrt(diag(var_beta));

ttest=beta./betadiag;



for l=1:size(y,2);
    y_mean=mean(y(:,l));
    y=y-y_mean;

    Rsquared(l,1)=1- ([RSS(l,l)]/[y(:,l)'*y(:,l)]);
    %Rsquared(l,1)= 1 - [(1-Rsquared(l,1))*((T-1)/(T-K))];
   
end;



Reg.b=beta;
Reg.u=u;
%%Reg.Omega=Omega;
Reg.tstat=ttest;
Reg.Rsquared=Rsquared;
%Reg.var_b=var_beta;
%Reg.yhat=y_hat;