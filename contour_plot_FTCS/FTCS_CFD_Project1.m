
%FTCS method

%By Mohammad Asif Sazzad


clc 
clear all
time=30;%in minute
delta_t=20;%time step in second
delta_x=0.015;%spatial grid space
x_thick=0.3;%thickness of the wall
total_time=time*60;%in second
alpha=3*10^(-6);
x=linspace(0,.3,21);
s=s_calculator(alpha,delta_t,delta_x);%calculating s

num_grid=(x_thick/delta_x)+1;
num_time=(total_time/delta_t)+1;
t_old=zeros(1,num_grid);
t_new=zeros(1,num_grid);
t_old(1,1)=300;
t_old(1,num_grid)=300;

t_old(1,2:num_grid-1)=100;
t_new=t_old;
t_store=zeros(num_time,num_grid);
t_store(1,:)=t_old;
for i=2:num_time
    for j=2:num_grid-1
        t_new(1,j)=s*t_old(1,j-1)+(1-2*s)*t_old(1,j)+s*t_old(1,j+1);
      
        
    end
    t_old=t_new;
    
%     plot(x,t_new,'-*');
%         hold on;
    t_store(i,:)=t_old;
end
figure(1);
 [x1,t_total] = meshgrid( min(x):0.015: max(x),  0:20: total_time);
 contourf(x1,t_total,t_store,100,'LineStyle','none');
 % Create xlabel
xlabel('X','FontWeight','bold','FontSize',20);

% Create ylabel
ylabel('time','FontWeight','bold','FontSize',20);

% Create title
title('Contour plot of 1D heat equation along the thickness','FontWeight','bold','FontSize',20);
c=colorbar;
colorbar('peer',c,'FontWeight','bold','FontSize',20);
set(gca,'FontSize',20,'fontWeight','bold')

%------------------------
% 5 min interval plot
%------------------------
figure(2);
time_5min=300/delta_t;
 plot_t=1;
 colorstring = 'kbgryc';
 time_step_legend=[5 10 15 20 25 30];
 for i=1:6
     plot_t=plot_t+time_5min;
     time_index=t_store(plot_t,:);
     plot(x,time_index,'-o','Color', colorstring(i));
     name=['time ',num2str(time_step_legend(i)),' min'];
     
     legend(name);
     hold on;
 end
%  Create xlabel
xlabel('X(m)','FontWeight','bold','FontSize',20);

% Create ylabel
ylabel('time(sec)','FontWeight','bold','FontSize',20);
set(gca,'FontSize',20,'fontWeight','bold');
xlim([0 0.3]);
 