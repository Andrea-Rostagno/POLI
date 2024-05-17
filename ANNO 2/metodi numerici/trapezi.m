function t = trapezi(f,a,b,m)
x = linspace(a,b,m+1);
y = f(x);
t = (b-a)/(2*m)*(y(1)+2*sum(y(2:m))+y(m+1));