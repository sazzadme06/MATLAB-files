%Project ADI%
%MOHAMMAD ASIF SAZZAD

clc 
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initializing the values
%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_min = 0;x_max=2;%length of x in meter
y_min=0; y_max=1; %length of y in meter
nx = 80;ny=30;%number of divisions in x and y
alpha=0.2;%time and value of alpha
k_time=90;%number of time loop
 dx = (x_max-x_min)/nx; %value of dx
 dy = (y_max-y_min)/ny; %value of dy
 dt=0.01;%time step
 
 dx1 = dx*dx; dy1=dy*dy;
 
 xx=x_min:dx:x_max;%%vector of the x values
 yy=y_min:dy:y_max;%%vector of the y values
 nx=nx+1;%adding one to cover nx points
 ny=ny+1;%%adding one to cover ny points
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%declaring the 2D and 3D matrices
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
 t_storex=zeros(ny,nx,k_time);%3d matrix to save time data for x direction
 t_storey=zeros(ny,nx,k_time);%3d matrix to save time data for y direction
 T_old=zeros(ny,nx);
   s1= alpha*dt/dx1;%calcualting Sx
   s2= alpha*dt/dy1;%calcualting Sy
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%setting boundary condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
      T_old(1,:)= 200;
      T_old(1,1)=0;
      T_old(1,nx)=0;
      T_x=T_old;%taking the initial value
           

   for k=1:k_time
 
     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %---------- Big loop for time t --------------
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

b_vec=zeros(nx,1);
b_vec(1,1)=0;
b_vec(nx,1)=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------x sweep--------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=2:ny-1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%creating left hand side matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%coefficient of left hand side matrix
a=s1/2;
b=-(1+s1);
c=s1/2;

%matrix mat_A
mat_A=b*diag(ones(nx,1))+a*diag(ones(nx-1,1),-1)+c*diag(ones(nx-1,1),+1);

%inner boundary points for matrix mat_A
mat_A(1,1:2)=[1 0];

%outer boundary points for matrix mat_A
mat_A(nx,nx-1:nx)=[ 0 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%right hand side vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%coefficient of right hand side vector
d=-s2/2;
e=-(1-s2);
f=-s2/2;

%%%%%%%%%%%%%%%%%
%loop for x sweep
%%%%%%%%%%%%%%%%%
for i=2:nx-1
     b_vec(i)=d*T_x(j-1,i)+e*T_x(j,i)+f*T_x(j+1,i);

end

% Solve the diagonal matrix.
ut = mat_A\b_vec;                          
     T_x(j,:)=ut;
     
end

%storing the values in 3D matrix

t_storex(:,:,k)=T_x;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------y sweep--------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%declaring the vector

  b_vecy=zeros(ny,1);
  b_vecy(1,1)=200;
  b_vecy(ny,1)=0;
  T_y=zeros(ny,nx);
  
%setting boundary condition
     T_y(1,:)=200;
     
     
%%%%%%%%%%%%%%%%%
%loop for x sweep
%%%%%%%%%%%%%%%%%  

     
for i=2:nx-1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%creating left hand side matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%coefficient of left hand side matrix
a1=s2/2;
b1=-(1+s2);
c1=s2/2;
%matrix mat_A
mat_B=b1*diag(ones(ny,1))+a1*diag(ones(ny-1,1),-1)+c1*diag(ones(ny-1,1),+1);
%inner boundary points for matrix mat_A
mat_B(1,1:2)=[1 0];
%outer boundary points for matrix mat_A
mat_B(ny,ny-1:ny)=[ 0 1];
% 
%right hand side vector
d1=-s1/2;
e1=-(1-s1);
f1=-s1/2;
for j=2:ny-1
     b_vecy(j)=d*T_x(j,i-1)+e*T_x(j,i)+f*T_x(j,i+1);
 % %Solving for next step
     
end

 % Solve the diagonal matrix.
 
ut = mat_B\b_vecy;                         
     T_y(:,i)=ut;
     
end
t_storey(:,:,k)=T_y;
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------x_y plot-------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
 figure(1);  
   pcolor(T_y);shading interp
 

 
 
 desiredy=3;%pulling the desired x_t plane
 
 xt=zeros(nx,k_time);
 T_x2D=t_storex(desiredy,:,:);% pulling the desired plane
       

     for i=1:nx
         for k=1:k_time
         xt(i,k)=T_x2D(1,i,k);
         end
     end
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------x_t plot-------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
pcolor(xt');shading interp


 

 desiredx=3;%pulling the desired y_t plane
 
 yt=zeros(ny,k_time);
 T_y2D=t_storex(:,desiredx,:);% pulling the desired plane
 
       

     for j=1:ny
         for k=1:k_time
         yt(j,k)=T_y2D(j,1,k);
         end
     end
     
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------y_t plot-------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 figure(3);
 pcolor(yt');shading interp
