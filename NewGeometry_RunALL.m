%MAKE SURE MAT FILES ARE CORRECT IN EACH!
clear;
close all;
%run('get_symbolic_equation.m');
r_ = 12/2; % radius of injector, 8mm
Al_ = 100; Ar_=125; %Arm left, Arm right lengths, 100mm
type = 'uneven';
%CAD
% dxr_ = 7.17; dxl_=dxr_;
% dyr_=4.14; dyl_=dyr_;
% dym_=8.28; 

dxr_=8.000000; dxl_=12.000000;
dyr_=5.777778; dyl_=4.000000;
dym_=8.280000;

alpha_ = 0.5236; %angle of arms for workspace

    run('addGeometryFast.m');
    run('fast_solver.m');
    %run('fast_solver_zeroOrientation.m');
    run('evaluate_lengths.m');
     %%
    run('output_arrays.m');

   
  