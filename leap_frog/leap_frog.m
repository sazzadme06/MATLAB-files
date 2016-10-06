



clc 
clear all

format long;


x_min = 0;x_max=1;%length of x in meter
nx = 1000;
u_value=0.25;% value of u
k_time=2400;%number of time loop
dx =(x_max-x_min)/(nx-1); %value of dx

 T_old=zeros(1,nx);
 xx=x_min:dx:x_max;%%vector of the x values
 CFL=.1;
 dt=dx*CFL/u_value;%% calculating delta time
 T_x=T_old;
 T_store=zeros(k_time,nx);
 
 
 
 %%%%%%%%%%%%%%%%%%%%%%%
 %%initial conditons
 %%%%%%%%%%%%%%%%%%%%%%%
 
 
 
 for i=1:nx
     if xx(i)<=0.1;
         T_old(i)=sin(10*pi*xx(i));
        
     else
         T_old(i)=0;
     end
 end


T_store(1,:)=T_old;%% storing the first time step


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FTCS for second time step using periodic boundary condition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for i=2:2
    for j=1:nx
     if j==1
            T_x(1,j)=T_old(1,j)-0.5*CFL*(T_old(1,j+1)-T_old(1,nx));%%%%%periodic boundary
     elseif j<=nx-1 && i==2;
            T_x(1,j)=T_old(1,j)-0.5*CFL*(T_old(1,j+1)-T_old(1,j-1));
            
     else
            T_x(1,j)=T_old(1,j)-0.5*CFL*(T_old(1,1)-T_old(1,j-1));%%%%%periodic boundary
     end
            
    end
    
 T_old=T_x;
 T_store(i,:)=T_x;
end
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Leap frog from 3rd time step using periodic boundary condition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=3:k_time
    for j=1:nx
        
            if j==1 
            T_x(1,j)=T_store(i-2,j)-CFL*(T_old(1,j+1)-T_old(1,nx)); %%%%%periodic boundary
            
            elseif j<=nx-1 
            T_x(1,j)=T_store(i-2,j)-CFL*(T_old(1,j+1)-T_old(1,j-1));
        
            
            else
            T_x(1,j)=T_store(i-2,j)-CFL*(T_old(1,1)-T_old(1,j-1));%%%%%periodic boundary
            end
       
             


    end
    T_old=T_x;
    T_store(i,:)=T_x;
   
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%% interactive plotting 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
  plot(xx,T_x(1,:),'-k','LineWidth',2); 
  drawnow

  shg

   
 end

