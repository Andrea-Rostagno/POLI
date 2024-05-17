function [x] = precondizionamento(A, b)
L=ichol(A);
x0=((L\A)/L')\(L\b);
x=L'\x0;
