clear all
close all 
clc
%steady state
nx=10;
ny=10;
l=10;
w=l;


x=linspace(0,l,nx);
y=linspace(0,w,ny);

dx=x(3)-x(1);
dy=y(3)-y(2);
%boundary conditions
temp=300*ones(nx,ny);
temp(1,:)=1000;%bottom wall
temp(ny,:)=1000;%top wall
temp(:,1)=400;%left wall
temp(:,nx)=400;%right wall
temp(1,1)=(900+400)/2;
temp(1,end)=(900+800)/2;
temp(end,1)=(400+600)/2;
temp(end,end)=(600+800)/2;

[xx,yy]=meshgrid(x,y);

told=temp;

term1=1/(2*((1/dx^2)+(1/dy^2)));

error=1e+9;
tol=1e-3;

counter=1;
while(error>tol)
for i=2:nx-1
   for j=2:ny-1
      term2=(told(i-1,j)+told(i+1,j))/(dx^2);
      term3=(told(i,j-1)+told(i,j+1))/(dy^2);
      temp(i,j)=term1*(term2+term3);
    
    
   end
end
    error=max(max(abs(told-temp)))
    told=temp;
    counter=counter+1
    [c,h]=contourf(xx,yy,temp);

    colorbar
    colormap(jet)
    clabel(c,h)
    
    
end