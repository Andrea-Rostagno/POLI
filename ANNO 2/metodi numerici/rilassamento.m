function [x,k,ier] = rilassamento(A,b,x0,omega,tol,kmax)
if prod(diag(A)) == 0
   x = []; k = []; ier = -1;
   return
end
D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);
for k = 1:kmax
   x = (D+omega*L)\(omega*b+((1-omega)*D-omega*U)*x0);
   if norm(x-x0) <= tol*norm(x)
      ier = 1;
      return
   end
   x0 = x;
end
ier = 0;