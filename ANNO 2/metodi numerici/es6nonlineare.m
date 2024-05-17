d1=4.5;
d2=6;
r1=5;
r2=9;
x0=[30,30]';
nmax=100;
tol=1.0e-10;
f1=d1*cos(x(2))+d2*cos(x(1)+x(2))-r1;
f2=d1*sin(x(2))+d2*sin(x(1)+x(2))-r2;
F=[f1,f2]';
J=[-d2*sin(x(1)+x(2)),-d1*sin(x(2))-d2*sin(x(1)+x(2));...
    d2*cos(x(1)+x(2)),d1*cos(x(2))+d2*cos(x(1)+x(2))];
a=newton_system(@(x) F,@(x) J,x0,nmax,tol);
disp(a)
