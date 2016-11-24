clearvars -except type
close all;


if(strcmp(type,'even'))
    load('new_geometry_even_handle.mat');
    load('even_points.mat');
else
    load('uneven_points.mat');
    load('new_geometry_uneven_handle.mat');
end
l = length(x);

left = [-Al_*sin(alpha_), Al_*cos(alpha_)];
right = [Ar_*sin(alpha_), Ar_*cos(alpha_)];
ml = left(2)/left(1);
mr = right(2)/right(1);
h=1;
for g=1:l
    %if(abs(x(g) -33.75) <= 2), continue; end; %skip an outlier
    if(abs(ml*x(g)-y(g)) <= 5 || abs(mr*x(g)-y(g)) <= 5), continue; end;
    F = @(q)funG(x(g),y(g),q(1),q(2),q(3));
    options = optimset('Display','none','MaxFunEvals',300,'MaxIter',800);
    [val fval exit] = fsolve(F,[1,1,0],options);
    beta_temp = rad2deg(val(3));
    if(beta_temp > 10 || beta_temp < -10), continue; end;
    if(val(1) < 0 || val(2) < 0), continue; end;
    if(max([val(1),val(2),1])/min([val(1),val(2),1]) > 4), continue; end;
    t(1,h) = 1;
    t(2,h) = val(1);
    t(3,h) = val(2);
    x_(h) = x(g);
    y_(h) = y(g);
    beta(h) = rad2deg(val(3));
    %beta(h) = 0;
    fprintf('Fval = [%f,%f,%f]\n%i / %i\nTensions = (%f,%f,%f)\nBeta=%f degrees\n\n',fval(1),fval(2),fval(3),h,l,t(1,h),t(2,h),t(3,h),beta(h));   
    h=h+1;
end
maxT = 200;
for z=1:length(t)
    mT = max(t(:,z));
    ratio = maxT/mT;
    t(:,z) = t(:,z)*ratio;
end
if(strcmp(type,'even')), save('even_arms_newG_beta.mat','t','beta','x_','y_');
else save('uneven_arms_newG_beta.mat','t','beta','x_','y_'); end
