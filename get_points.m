clear all;
close all;
n = 10;

  ng = triangle_grid_count ( n );

  r = 12/2; % radius of injector, 8mm
Al = 100; Ar=100; %Arm left, Arm right lengths, 100mm
dx0 = 7.17; dy0=4.14; dy1=8.28; %dimensions of injector, assuming symmetric left and right sides
alpha = radtodeg(0.5236); %angle of arms for workspace


%calculate coordinates of left and right base centers
bl = [-Al*sind(alpha);Al*cosd(alpha)]; %left base coordinate
br = [Ar*sind(alpha);Ar*cosd(alpha)]; %right base coordinate

  t = [ ...
    0.0, 0.0;
    bl(1), bl(2);
    br(1), br(2)]';
 tg = triangle_grid ( n, t );

 
 xinj = [fliplr(tg(1,:))];
 yinj = [fliplr(tg(2,:))];
 figure;
 s=size(xinj);
 scatter(xinj,yinj,[],1:s(2),'filled');

 
 ml = bl(2)/bl(1);
 mr = br(2)/br(1);
 
 s=size(xinj);
len = s(2);
a=1;
oldx=[];
oldy=[];
b=1;
k=1;
for z = 1:len
    if(~isempty(oldy))
        oldy
        if b>k
            k=k+1;
            b=1;
                  
        end
        injx(b,k) = xinj(z);
        injy(b,k) = yinj(z);
        oldy=yinj(z);
        b=b+1;
    else
        injx(b,k) = xinj(z);
        injy(b,k) = yinj(z);
        b=b+1;
        oldy=yinj(z);
        
    end
end

s = size(injx);
clear xinj yinj;
h=1;
xinj = [];
yinj = [];
hitzero = false;
for k=1:s(2)
    if mod(k,2) == 0 %even number
        xinj = [xinj; fliplr(injx(1:k,k)')'];
        yinj = [yinj; fliplr(injy(1:k,k)')'];
    else
        xinj = [xinj; injx(1:k,k)];
        yinj = [yinj; injy(1:k,k)];
    end
    h=h+1;
       
end

%load('points_even_2_4_15.mat')

 xinj = xinj';
 yinj = yinj';
 
 figure;
 s=size(xinj);
 scatter(xinj,yinj,[],'blue','filled');
 axis equal
colorbar;
hold on;
%plot what is already known and accept injector location
plot(0,0,'.k','MarkerSize',50);
circle(bl(1),bl(2),r);
circle(br(1),br(2),r);
hold on;
plot([0,bl(1)],[0,bl(2)],'k','LineWidth',3);
hold on;
plot([0,br(1)],[0,br(2)],'k','LineWidth',3);
colorbar;
ylabel('y (mm)');
xlabel('x (mm)');
title('Orientation of injector in workspace (Color in degrees)');
injx=xinj;
injy=yinj;
s=size(injx);
len = s(2);
a=1;
x = injx;
y = injy;
save('uneven_points.mat','x','y');