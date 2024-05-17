function [x,n,ier] = tangenti(f,fd,x0,nmax,tol)
ier = 0;
for n = 1:nmax
    x = x0-f(x0)/fd(x0);
    if abs(x-x0) <= tol
        ier = 1;
        break
    end
x0 = x;
end