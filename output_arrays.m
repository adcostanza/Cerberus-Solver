clearvars -except type
close all
if(strcmp(type,'even'))
    load('even_arms_newG_solution.mat');
else
    load('uneven_arms_newG_solution.mat');
end

fprintf('\n\ndouble T0 [%i] = {',length(t));
fprintf('%f,',t(1,1:end-1));
fprintf('%f',t(1,end));
fprintf('};\n');

fprintf('double T1 [%i] = {',length(t));
fprintf('%f,',t(2,1:end-1));
fprintf('%f',t(2,end));
fprintf('};\n');

fprintf('double T2 [%i] = {',length(t));
fprintf('%f,',t(3,1:end-1));
fprintf('%f',t(3,end));
fprintf('};\n');

fprintf('double x0 [%i] = {',length(t));
fprintf('%f,',sl0(1:end-1));
fprintf('%f',sl0(end));
fprintf('};\n');

fprintf('double x1 [%i] = {',length(t));
fprintf('%f,',sl1(1:end-1));
fprintf('%f',sl1(end));
fprintf('};\n');

fprintf('double x2 [%i] = {',length(t));
fprintf('%f,',sl2(1:end-1));
fprintf('%f',sl1(end));
fprintf('};\n');

fprintf('double injx [%i] = {',length(t));
fprintf('%f,',x_(1:end-1));
fprintf('%f',x_(end));
fprintf('};\n');

fprintf('double injy [%i] = {',length(t));
fprintf('%f,',y_(1:end-1));
fprintf('%f',y_(end));
fprintf('};\n');

figure;
plot(sl0);
hold on;
plot(sl1,'r');
plot(sl2,'g');