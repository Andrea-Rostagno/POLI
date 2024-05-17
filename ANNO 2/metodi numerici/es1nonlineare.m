nmax=100;
tol=1.0e-10;
f=@(x)x^3-x-1;
j=@(x)3*x^2-1;
x0=0;
a=newton_system(f,j,x0,nmax,tol);
disp(a)


