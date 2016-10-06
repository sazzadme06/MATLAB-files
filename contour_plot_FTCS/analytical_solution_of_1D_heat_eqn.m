clc
clear all
time=30;%in minute
delta_t=20;%time step in second
delta_x=0.015;%spatial grid space
x_thick=0.3;%thickness of the wall
total_time=time*60;%in second
alpha=3*10^(-6);
x=linspace(0,0.3,21);
s=s_calculator(alpha,delta_t,delta_x);%calculating s
num_grid=(x_thick/delta_x)+1;
num_time=total_time/delta_t+1;
t_old=zeros(1,num_grid);%vector of old time step
t_new=zeros(1,num_grid);%vector of new time step
t_old(1,1)=300;%replacing the side with temparautre 300 C
t_old(1,num_grid)=300;%replacing the other side with temparautre 300 C
T_initial=100;
T_side=300;

t_new=t_old;
t_store=zeros(num_time,num_grid);
t=0;
b=0;
L=0.3;
t_old(1,1)=300;
t_old(1,num_grid)=300;

t_old(1,2:num_grid-1)=100;
t_new=t_old;
t_store=zeros(91,21);
t_store(1,:)=t_old;
for i=2:num_time
    t=t+delta_t;
    for j=2:num_grid-1
        b=infinite_sum(x(j),t,L,alpha);
        t_new(1,j)=T_side+2*(T_initial-T_side)*b;
    end
    t_old=t_new;
    
    plot(x,t_new,'-*');
        hold on;
    t_store(i,:)=t_old;
    
end

figure(3);
 [x1,t_total] = meshgrid( min(x):0.015: max(x),  0:20: total_time);
 contourf(x1,t_total,t_store,100,'LineStyle','none');
 % Create xlabel
xlabel('X(m)','FontWeight','bold','FontSize',20);

% Create ylabel
ylabel('time(sec)','FontWeight','bold','FontSize',20);
time_5min=300/delta_t;
 plot_t=1;
 colorstring = 'kbgryc';
 figure(2);
 for i=1:6
     plot_t=plot_t+time_5min;
     time_index=t_store(plot_t,:);
     plot(x,time_index,'-o','Color', colorstring(i));
    
     hold on;
 end
legend('Time:5 min','Time:10 min','Time:15 min','Time:20 min','Time:25 min','Time:30 min');

%Create title
title('Contour plot of 1D heat equation along the thickness using analytical solution','FontWeight','bold','FontSize',18);
c=colorbar;
colorbar('peer',c,'FontWeight','bold','FontSize',20);
set(gca,'FontSize',20,'fontWeight','bold')
      