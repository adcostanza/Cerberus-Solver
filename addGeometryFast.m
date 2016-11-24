load('funM.mat');
funG = @(injx,injy,t1,t2,theta)funM(Al_,Ar_,alpha_,dxl_,dyr_,dyl_,dym_,dyr_,injx,injy,r_,t1,t2,theta);

s0 = @(injx,injy,theta)sl0M(Al_,alpha_,dxl_,dyl_,injx,injy,r_,theta);
s1 = @(injx,injy,theta)sl1M(dym_,injx,injy,theta);
s2 = @(injx,injy,theta)sl2M(Al_,alpha_,dxr_,dyr_,injx,injy,r_,theta);

if(strcmp(type,'even'))
    save('new_geometry_even_handle.mat','funG','Al_','Ar_','alpha_', 's0','s1','s2');
else
    save('new_geometry_uneven_handle.mat','funG','Al_','Ar_','alpha_', 's0','s1','s2');
end
