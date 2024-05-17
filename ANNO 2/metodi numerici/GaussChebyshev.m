function t = GaussChebyshev(g,a,b,n)
xC = cos((2*(1:n)-1)/(2*n)*pi);
x = (b-a)/2*xC+(b+a)/2;
y = g(x);
t = pi/n*sum(y);