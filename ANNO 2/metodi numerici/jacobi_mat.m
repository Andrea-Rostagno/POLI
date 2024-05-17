a1=[ 1, -2, 2; -1, 1, -1; -2, -2, 1 ];
a2 = [ 4, 0, 2/5; 0 5 2/5; 5/2, 2, 1 ];
a3 = [ 2, -1, 1; 2, 2, 2; -1, -1, 2 ];
y=[1 1 1]';
x0=[0 0 0]';
b1=a1*y;
b2=a2*y;
b3=a3*y;
d1=diag(diag(a1));
d2=diag(diag(a2));
d3=diag(diag(a3));
c1=a1-d1;
c2=a2-d2;
c3=a3-d3;
kmax=3;
tol=1.0*10^-7;
for k=1:kmax
    x1=d1\(b1-c1*x0);
    if norm(x1-x0)<= tol*norm(x1)
        return
    end
    x0=x1;

end
x0=[0 0 0]';
for k=1:kmax
    x2=d2\(b2-c2*x0);
    if norm(x2-x0)<= tol*norm(x2)
        return
    end
    x0=x2;

end
x0=[0 0 0]';
for k=1:kmax
    x3=d3\(b3-c3*x0);
    if norm(x3-x0)<= tol*norm(x3)
        return
    end
    x0=x3;

end
x1
x2
x3


