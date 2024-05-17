function [v,i] = taylor_exp(x,tol)
%input:
% tol: tolleranza prefissa
%v: valore del polinomio calcolato in x con tolleranza tol
%i: gradodel polinomio
% x: punto in cui si vuole valutare il polinomio di taylor
v=0;
i=0;
termine_sviluppo=1;
while termine_sviluppo>=tol
    v=v+termine_sviluppo;
    i=i+1

    termine_sviluppo=x^i/factorial(i)

end