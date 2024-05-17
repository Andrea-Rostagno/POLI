function [x,k,ier] = gradiente(A, b, x0, tol, kmax)
ier = 0;
r = b-A*x0;
for k = 1:kmax
  s = A*r;
  alpha = r'*r/(r'*s);
  x0 = x0+alpha*r;
  r = r-alpha*s;
  if norm(r) <= tol*norm(b)
    ier = 1;
    break
  end
end
x=x0;