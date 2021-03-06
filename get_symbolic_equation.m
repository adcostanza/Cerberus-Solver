clear all;
syms r Al Ar dxl dyl dyr dxr dym alpha theta t1 t2 injx injy;

inj = [injx;injy];


%calculate coordinates of left and right base centers
bl = [-Al*sin(alpha);Al*cos(alpha)]; %left base coordinate
br = [Ar*sin(alpha);Ar*cos(alpha)]; %right base coordinate

%calculate h vectors to knot from injector center
h0 = [-dxl;dyl]; %left string h vector
h1 = [0;-dym]; % middle
h2=[dxr;dyr]; % right

%create rotation matrix from injector coord frame to base
 %orientation of injector
Rot = [cos(theta),-sin(theta);sin(theta), cos(theta)];

%calculate h vectors in base coordinate space
h0b = (Rot*h0);
h1b = (Rot*h1);
h2b = (Rot*h2);

%calculate knot locations in base coordinate frame
k0 = inj+h0b; %left
k1 = inj+h1b; %middle
k2 = inj+h2b; %right

%calculate l0, r0 vector from knot to center of bases
l0 = bl-k0;
l2 = br-k2;
l1=-k1; %no tangent point for middle, this is the actual S vector

%calculate tangent angle
kappal = acos(r/norm(l0));
kappar = acos(r/norm(l2));

omegal = atan(abs(l0(1)/l0(2)));
omegar = atan(abs(l2(1)/l2(2)));

gammal = abs(pi()-abs(kappal)-abs(omegal));
gammar = abs(pi()-abs(kappar)-abs(omegar));

rltan = [sin(gammal); cos(gammal)];
rrtan = [-sin(gammar); cos(gammar)];

rltan = r*rltan/norm(rltan);
rrtan = r*rrtan/norm(rrtan);

%calculate rperp on each base, its the fixed location that the string will
%never reach and we add the angle between it and the rtan vectors. it is
%perpendicular to the arm
rlperp = cross([bl;0],[0;0;-1]); %arbitrary magnitude in correct direciton
rrperp = cross([br;0],[0;0;1]); %arbitrary magnitude in correct direction

rlperp = r*rlperp/sqrt(power(rlperp(1),2)+power(rlperp(2),2)); %make length of radius
rrperp = r*rrperp/sqrt(power(rrperp(1),2)+power(rrperp(2),2)); %make magnitude radius

rrperp = rrperp(1:2); %remove z component
rlperp = rlperp(1:2); %remove z component

%get angle of string around pulleys

rrperpsq = sqrt(power(rrperp(1),2)+power(rrperp(2),2));
rrtansq = sqrt(power(rrtan(1),2)+power(rrtan(2),2));
ralpha = acos(dot(rrperp,rrtan)/rrperpsq/rrtansq);


rlperpsq = sqrt(power(rlperp(1),2)+power(rlperp(2),2));
rltansq = sqrt(power(rltan(1),2)+power(rltan(2),2));
lalpha = acos(dot(rlperp,rltan)/rlperpsq/rltansq);

%calculate tangent points on bases
ltan = bl+rltan;
rtan = br+rrtan;

%calculate string vectors S
s0 = ltan-k0;
s2 = rtan-k2;
s1 = l1;

%create unit vectors
s0u = s0/sqrt(power(s0(1),2)+power(s0(2),2));
s1u = s1/sqrt(power(s1(1),2)+power(s1(2),2));
s2u = s2/sqrt(power(s2(1),2)+power(s2(2),2));

Sjac = [s0u,s1u,s2u];

%calculate bottom part of statics jacobian
q0 = s0u(1)*h0b(2)-s0u(2)*h0b(1);
q1 = s1u(1)*h1b(2)-s1u(2)*h1b(1);
q2 = s2u(1)*h2b(2)-s2u(2)*h2b(1);

Sjac = [Sjac; q0,q1,q2];
fun = Sjac * [1;t1;t2];

sl0 = norm(s0) + lalpha*r;
sl1 = norm(s1);
sl2 = norm(s2) + ralpha*r;

save('fun.mat','Sjac','sl0','sl1','sl2');

funM = matlabFunction(fun);
sl0M = matlabFunction(sl0);
sl1M = matlabFunction(sl1);
sl2M = matlabFunction(sl2);

save('funM.mat','funM','sl0M','sl1M','sl2M');