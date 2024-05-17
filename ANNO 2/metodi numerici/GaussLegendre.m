function t = GaussLegendre(g,a,b,xL,wL)
% xL = vettore colonna contenente i nodi della formula di
% wL = vettore colonna contenente i pesi della formula di
x = (b-a)/2*xL+(b+a)/2;
y = g(x);
t = (b-a)/2*sum(wL.*y);