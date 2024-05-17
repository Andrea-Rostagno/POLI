nmax=20;
tol=1.0e-10;
x0=[0.5,-0.5,0.1]';
f1=x(1)^2+2*x(1)*x(2)+x(3);
f2=x(2)^3+x(3)^2;
f3=x(1)*x(3)-1;
F=[f1,f2,f3]';
J=[2*x(1)+2*x(2),2*x(1),1;0,3*x(2)^2,2*x(3);x(3),0,x(1)];
a=newton_system(@(x) F,@(x) J,x0,nmax,tol);
disp(a)

