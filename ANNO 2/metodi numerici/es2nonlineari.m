nmax=100;
tol=1.0e-10;
g=@(x) -sqrt(exp(x)/2);
x0=0;
[x,n]=puntofisso(g,x0,nmax,tol);
disp([x,n])
f=@(x) exp(x) - 2*x^2;
%r=fzero(f,x0);
f1=@(x) x^3+4*x^2-10;
x00=1;
g1=@(x)(2*x^3+4*x^2+10)/(3*x^2+8*x);
[x1,n1]=puntofisso(g1,x00,nmax,tol);
disp([x1,n1])
%r=fzero(f1,x00);