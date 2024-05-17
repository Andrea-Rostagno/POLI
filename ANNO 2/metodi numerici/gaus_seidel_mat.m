a1=[ 1, -2, 2; -1, 1, -1; -2, -2, 1 ];
a2 = [ 4, 0, 2/5; 0 5 2/5; 5/2, 2, 1 ];
a3 = [ 2, -1, 1; 2, 2, 2; -1, -1, 2 ];
y=[1 1 1]';
x0=[0 0 0]';
b1=a1*y;
b2=a2*y;
b3=a3*y;
d1=tril(a1);
d2=tril(a2);
d3=tril(a2);
c1=a1-d1;
c2=a2-d2;
c3=a3-d3;
kmax=100;
tol=1.0*10^-7;
ier=0;
rho1=max(abs(eig(eye(3)- inv(d1)*a1)));
for k=1:kmax
    x1=d1\(b1-c1*x0);
    if norm(x1-x0)<= tol*norm(x1)
        ier=1;
        return
    end
    x0=x1;

end



