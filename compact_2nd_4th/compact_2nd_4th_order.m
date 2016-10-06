function [ df ] = compact_2nd_4th_order( f,m,delx)

% Here,P*df=Q*f
df=zeros(m,1);
%coefficient of the derivative terms to generate the matrix P 
a1=1/10;
b1=1;
c1=1/10;
%coefficient of the matrix Q
a=6/5;
b=-12/5;
c=6/5;

%matrix P
P=b1*diag(ones(m,1))+a1*diag(ones(m-1,1),-1)+c1*diag(ones(m-1,1),+1);
%matrix Q
Q=b*diag(ones(m,1))+a*diag(ones(m-1,1),-1)+c*diag(ones(m-1,1),+1);
%inner boundary points for matrix P
P(1,1:3)=[1 0 0];
%outer boundary points for matrix P
P(m,m-2:m)=[0 0 1];
%inner boundary points for matrix Q
Q(1,1:5)=[35/12 -26/3 19/2 -14/3 11/12];
%outer boundary points for matrix Q
Q(m,m-4:m)=[ 11/12 -14/3 19/2 -26/3 35/12];
Q=Q/delx^2;
%calculated derivatives
df=(P\Q)*f;
%df=(Q/P)*f;