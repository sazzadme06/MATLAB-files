%Mohammad Asif Sazzad
%Solving 2nd derivative numerically using 4th order compact finite difference method
clc
clear all

format long

m=[ 50 100 200 300 500 1000];%number of grid points
i=1;
j=1;
Err1=zeros(6,1);
delx=zeros(6,1);
%for generating error curve
%to get plot we have to remove outer for loop
for j=1:6
    
x1=linspace(0,5,m(j));
f=zeros(m(j),1);
fdiff=zeros(m(j),1);
delx(j)=x1(2);
%functional values at the grid points
for i=1:m(j)
    f(i)=tanh(5*x1(i)-5);
fdiff(i)=10*tanh(5*x1(i) - 5)*(5*tanh(5*x1(i) - 5)^2 - 5);
end
figure(j)
%analytical values of the function
 plot(x1,fdiff,'-o');shg
 hold on



%taking the values of derivatives
 df=compact_2nd_4th_order( f,m(j),delx(j));

plot(x1,df,'k-*');
xlabel('x');
ylabel('df/dx');
title('Solution of 1st derivative numerically using 4th order compact finite difference method');
Err=(fdiff-df);%calculating error
Err1(j)=max(abs(Err)); 
end
figure(j+1);
plot(log10(delx),log10(Err1),'-s','LineWidth',2);shg

xlabel('log(\Deltax)');
ylabel('log(Error)');
title('LogLog plot of Error vs \Deltax');

%When ananlytical vs numerical plot is needed
% plot(x1,df,'k-*');
% hold on
% plot(x1,fdiff,'-o');shg

