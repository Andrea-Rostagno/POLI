function t = simpson(f,a,b,m)
x = linspace(a,b,2*m+1);
y = f(x);
t = (b-a)/(6*m)*(y(1)+4*sum(y(2:2:2*m))+...
2*sum(y(3:2:2*m-1))+y(2*m+1));