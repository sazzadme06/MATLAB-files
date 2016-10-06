%Mohammad Asif Sazzad
%Solving 1st derivative numerically using 4th order compact finite difference method
clc
clear all

format long

m=[50 100 200 300 500 1000];%number of grid points
i=1;
j=1;
Err1=zeros(6,1);
delx=zeros(6,1);

for j=1:6
    
x1=linspace(0,5,m(j));
f=zeros(m(j),1);
delx(j)=x1(2);
%functional values at the grid points
for i=1:m(j)
    f(i)=tanh(20*x1(i)-20);

end
figure(j)
%analytical values of the function
fdiff=20-20*tanh(20*x1 - 20).^2;
 plot(x1,fdiff,'-o');shg
 hold on


%taking the values of derivatives
df=compact_1st_4th_order( f,m(j),delx(j));
plot(x1,df,'k-*');
xlabel('x');
ylabel('df/dx');
title('Solution of 1st derivative numerically using 4th order compact finite difference method');
Err=(fdiff'-df);%calculating error
Err1(j)=max(abs(Err)); 
end
figure(j+1)
%error curve
plot(log10(delx),log10(Err1),'-s','LineWidth',2);shg

xlabel('log(\Deltax)');
ylabel('log(Error)');
title('LogLog plot of Error vs \Deltax');


