function [x] = gradienteconiugato(A, b, tol, kmax)
x=pcg(A,b,tol,kmax);
