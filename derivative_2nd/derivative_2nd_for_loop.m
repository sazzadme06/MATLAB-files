%Mohammad Asif Sazzad
%Solving 2nd order derivative numerically using for loop method
tic
clc
clear all

num=[ 10 50 100 300 500 1000];%number of grid points
for i=1:6
x=linspace(0,2*pi,num(i));
df=derivative_2nd( x,num(i) );%taking the calculated value of the 2nd order derivative
figure(i);
plot(x,df,'k-*');
hold on
grid on
sum=0;
%analytical solution
syms x1 f1 z1
f1= sin(x1);
z1=diff(f1,2);
anaval=subs(z1,x);

plot(x,anaval,'r--o');
xlabel('x');
ylabel('df/dx');
title('First derivative of function sin(x)');
legend('Numerical','Analytical');

%error calculation
Err=(anaval'-df);


Err1(i)=max(abs(Err));
deltax(i)=x(2);
end
figure(7)
plot(log10(deltax),log10(Err1),'-s');shg
xlabel('log(\Deltax)');
ylabel('log(Error)');
title('LogLog plot of Error vs \Deltax');
toc