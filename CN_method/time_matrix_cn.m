function [t_new]=time_matrix_cn(t_old,num_grid,s)
% Here,mat_L*t_new=mat_R*t_old
%initializing
mat_R=zeros(num_grid,num_grid);
mat_L=zeros(num_grid,num_grid);


%coefficient of left hand side matrix
a=-s;
b=2*(1+s);
c=-s;

%coefficient of right hand side matrix
a1=s;
b1=2*(1-s);
c1=s;
%matrix mat_L
mat_L=b*diag(ones(num_grid,1))+a*diag(ones(num_grid-1,1),-1)+c*diag(ones(num_grid-1,1),+1);
%matrix mat_R
mat_R=b1*diag(ones(num_grid,1))+a1*diag(ones(num_grid-1,1),-1)+c1*diag(ones(num_grid-1,1),+1);
%inner boundary points for matrix mat_L
mat_L(1,1:2)=[1 0];
%outer boundary points for matrix mat_L
mat_L(num_grid,num_grid-1:num_grid)=[ 0 1];
%inner boundary points for matrix mat_R
mat_R(1,1:2)=[1 0];
%outer boundary points for matrix mat_R
mat_R(num_grid,num_grid-1:num_grid)=[ 0 1];
t_new=(mat_L\mat_R)*t_old';