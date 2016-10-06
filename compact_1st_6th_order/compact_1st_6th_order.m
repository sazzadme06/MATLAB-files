function [ df ] = compact_1st_6th_order( f,m,delx)

% Here,P*df=Q*f
%coefficient of the derivative terms to generate the matrix P 
a1=1/3;
b1=1;
c1=1/3;
%coefficient of the matrix Q
a=(-1/36);
b=(-14/18);
c=0;
d=(14/18);
e=(1/36);

%matrix P
P=b1*diag(ones(m,1))+a1*diag(ones(m-1,1),-1)+c1*diag(ones(m-1,1),+1);
%matrix Q
Q=c*diag(ones(m,1))+b*diag(ones(m-1,1),-1)+d*diag(ones(m-1,1),+1)+a*diag(ones(m-2,1),-2)+e*diag(ones(m-2,1),+2);
%inner boundary points for matrix P
P(1,1:2)=[1 0];
%outer boundary points for matrix P
P(m,m-1:m)=[0 1];
%inner boundary points for matrix Q
Q(1,1:6)=[-137/60 5 -5 10/3 -5/4 1/5];
Q(2,1)=0;
Q(2,2:7)=[-137/60 5 -5 10/3 -5/4 1/5];
%outer boundary points for matrix Q
Q(m,m-5:m)=[-1/5 5/4 -10/3 5 -5 137/60];
Q(m-1,m)=0;
Q(m-1,m-6:m-1)=[-1/5 5/4 -10/3 5 -5 137/60];
Q=Q/delx;
%calculated derivatives
df=(P\Q)*f;