function [x,n,ier] = puntofisso(g,x0,nmax,tol)
ier = 0;
for n = 1:nmax
  x = g(x0);
  if abs(x-x0) <= tol
     ier = 1;
     break
  end
x0 = x;
end