function [ df ] = compact_1st_4th_order( f,m,delx)

% Here,P*df=Q*f
df=zeros(m,1);
%coefficient of the derivative terms to generate the matrix P 
a1=1/4;
b1=1;
c1=1/4;
%coefficient of the matrix Q
a=-3/4;
b=0;
c=3/4;

%matrix P
P=b1*diag(ones(m,1))+a1*diag(ones(m-1,1),-1)+c1*diag(ones(m-1,1),+1);
%matrix Q
Q=b*diag(ones(m,1))+a*diag(ones(m-1,1),-1)+c*diag(ones(m-1,1),+1);
%inner boundary points for matrix P
P(1,1:3)=[1 0 0];
%outer boundary points for matrix P
P(m,m-2:m)=[0 0 1];
%inner boundary points for matrix Q
Q(1,1:4)=[-11/6 3 -3/2 1/3];
%outer boundary points for matrix Q
Q(m,m-3:m)=[-1/3 3/2 -3 11/6];
Q=Q/delx;
%calculated derivatives
df=(P\Q)*f;
%df=(Q/P)*f;