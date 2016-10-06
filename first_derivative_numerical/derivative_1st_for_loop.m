%Mohammad Asif Sazzad
%Solving 1st order derivative numerically using for loop method
tic
clc
clear all
num=100;%change the number of grid points
x=linspace(0,2*pi,num);
df=derivative_1st( x,num );%taking the calculated value of the 1st order derivative
plot(x,df,'k-*');
hold on
grid on
sum=0;
%analytical solution
syms x1 f1 z1
f1= sin(x1);
z1=diff(f1);
anaval=subs(z1,x);
plot(x,anaval,'r--o');
xlabel('x');
ylabel('df/dx');
title('First derivative of function sin(x)');
legend('Numerical','Analytical');

%error calculation
Err=(anaval'-df);
for ii=1:length(Err)
    sum=sum+Err(ii)^2;
end

Err1=sqrt(sum/ii)
deltax=x(2)

toc