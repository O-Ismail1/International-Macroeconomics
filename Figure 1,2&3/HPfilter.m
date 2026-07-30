function [g]=HPfilter(y,lambda);
%function [g]=HPfilter(y,lambda);
%
%this function runs a HP-filter on the columns of the matrix y.
%
%lambda is the smoothness parameter. The higher lambda, the smoother 
%will be the trend.
%Typical choices are lambda=1600   for quarterly data
%                 or lambda=50000  to get an almost linear trend.
%
%Ref: Hodrick and Prescott (1983)
%
%copyright: Mathias Hoffmann 
%           European University Institute
%           July 1998
%------------------------------------------------------------------
%

[t,n]=size(y);
tt=t;

A=zeros(tt,tt);
A=A+diag(ones(tt,1)*(1+6*lambda));
A=A+diag(ones(tt-1,1)*(-4*lambda),1);
A=A+diag(ones(tt-1,1)*(-4*lambda),-1);
A=A+diag(ones(tt-2,1)*lambda,2);
A=A+diag(ones(tt-2,1)*lambda,-2);

A=A(3:t-2,:);
B1=zeros(2,t);
B2=zeros(2,t);
B1(1,1:3)=[1+lambda,-2*lambda,lambda];
B1(2,1:4)=[-2*lambda,1+5*lambda,-4*lambda,lambda];

B2(2,t-2:t)=[lambda,-2*lambda,1+lambda];
B2(1,t-3:t)=[lambda,-4*lambda,1+5*lambda,-2*lambda];
A=[B1;A;B2];
size(A);
size(y);
g=A\y;