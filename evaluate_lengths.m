clearvars -except type
if(strcmp(type,'even'))
    load('new_geometry_even_handle.mat');
    load('even_arms_newG_beta.mat');
else
    load('new_geometry_uneven_handle.mat');
    load('uneven_arms_newG_beta.mat');
end



close all;
    sl0 = s0(x_,y_,deg2rad(beta));   
    sl1 = s1(x_,y_,deg2rad(beta));   
    sl2 = s2(x_,y_,deg2rad(beta));

 if(strcmp(type,'even'))
    save('even_arms_newG_solution.mat','t','sl0','sl1','sl2','x_','y_');
else
    save('uneven_arms_newG_solution.mat','t','sl0','sl1','sl2','x_','y_');
end