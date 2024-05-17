% LABORATORIO 7, esercizio 1

choice = input('choice: ');
switch choice
  case 1
    f = @(x) exp(x);
    int = [0,1];
    exact_value = exp(1)-1;
  case 2
    f = @(x) cos(x);
    int = [0,1];
    exact_value = sin(1);
  case 3
    f = @(x) x.^(-4);
    int = [0.01, 1.1];
    exact_value = 1/3*(1e6 - (1.1)^(-3));
  case 4
    f = @(x) sqrt(x);
    int = [0, 1];
    exact_value = 2/3;
  case 5
    f = @(x) sin(99*pi*x);
    int = [0, 1];
    exact_value = 2/(99*pi);
  case 6
    f = @(x) sin(100*pi*x);
    int = [0, 1];
    exact_value = 0;
end

tol = 1.0e-10;
kmax=128;
n=0;
t=1;
while n<kmax && t>=tol
    n=n+2;
    [z,p]=zplege(n);
    x = GaussLegendre(f,int(1),int(2),z,p);
    t=abs(exact_value-x);
end
disp(x)
disp(n)
