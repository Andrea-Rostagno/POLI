function [x,k,ier] = jacobi(A,b,x0,tol,kmax)
if prod(diag(A)) == 0
  x = []; k = []; ier = -1;
  return
end
D = diag(diag(A));
C = A-D;
for k = 1:kmax
  x = D\(b-C*x0);
  if norm(x-x0) <= tol*norm(x)
    ier = 1;
    return
  end
  x0 = x;
end
ier = 0;
