function [ df ] = derivative_1st( x, num)

delx=x(2)-x(1);
f=sin(x);
df=zeros(num,1);
%Central difference
for i=3:1:num-2
    df(i)=(-2/3*f(i-1)+2/3*f(i+1)+1/12*f(i-2)-1/12*f(i+2))/delx;
end
%forward difference
for i=1:2
    df(i)=(-2.0833*f(i)+4*f(i+1)-3*f(i+2)+4/3*f(i+3)-1/4*f(i+4))/delx;
end
%Backward difference
for i=num-1:num
   df(i)=(2.0833*f(i)-4*f(i-1)+3*f(i-2)-4/3*f(i-3)+1/4*f(i-4))/delx;
end

end

