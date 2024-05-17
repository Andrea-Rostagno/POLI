function [x,n,ier] = secanti(f,x0,x1,nmax,tol)
ier = 0;
for n = 1:nmax
    x = x1-f(x1)*(x1-x0)/(f(x1)-f(x0));
    if abs(x-x1) <= tol
        ier = 1;
        break
    end
x0 = x1;
x1 = x;
end