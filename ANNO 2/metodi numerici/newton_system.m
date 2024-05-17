function [x,ier] = newton_system(F,J,x,nmax,tol)
ier = 0;
for n = 1:nmax 
    h = -J(x)\F(x);
    x = x + h;
if norm(h) <= tol
ier = 1;
break
end
end