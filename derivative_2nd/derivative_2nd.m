function [ df ] = derivative_2nd( x, num)

delx=x(2)-x(1);
f=sin(x);
df=zeros(num,1);
AA=[1 1 1 1 1 1;0,1,2,3,4,5;0,1,4,9,16,25;0,1,8,27,64,125;0,1,16,81,256,625;0,1,32,243,1024,3125];
AB=[1 1 1 1 1 1 1;0 -1 1 -2 2 -3 3;0 1 1 4 4 9 9;0 -1 1 -8 8 -27 27;0 1 1 16 16 81 81; 0 -1 1 -32 32 -243 243; 0 1 1 64 64 729 729];
bb=[0 0 2 0 0 0];
ab=[0 0 2 0 0 0 0];
bb=bb';

%Central difference
Coeff1=AA\bb;
Coeff2=zeros(6,1);
j=1;
Coeff3=AB\ab';

for i=6:-1:1
    Coeff2(j)=Coeff1(i);
    j=j+1;
end

for i=4:1:num-3
   df(i)=(Coeff3(1)*f(i)+Coeff3(2)*f(i-1)+Coeff3(3)*f(i+1)+Coeff3(4)*f(i-2)+Coeff3(5)*f(i+2)+Coeff3(6)*f(i-3)+Coeff3(7)*f(i+3))/delx^2;
end
%forward difference
for i=1:3
    df(i)=dot(Coeff1,f(i:i+5))/delx^2;
end
%Backward difference
for i=num-2:num
    df(i)=dot(Coeff2,f(i-5:i))/delx^2;

end
end