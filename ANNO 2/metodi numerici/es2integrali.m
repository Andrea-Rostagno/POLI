tol = 1.0e-10;
kmax=128;
n=0;
t=1;
ic=4;
kpts=0;
endpts=0;
alpha=0;
beta=0;
f=@(x)x.^2.*sin(x.^2);
exact_value=2^(1/4)/16*sqrt(pi*(sqrt(2)+2));
while n<kmax && t>=tol
    n=n+2;
    [d,z]=gaussq(ic,n,alpha,beta,kpts,endpts);
    x = 0.5*GaussLegendre(f,z);%da cambiare
    t=abs(exact_value-x);
end
disp(x)
disp(n)