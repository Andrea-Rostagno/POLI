%metodo gradiente coniugato pcg tramite precondizionamento di ichol
n=100;
A = sparse(gallery('toeppd',n,n,linspace(0,1,n),linspace(0,2*pi,n)));
%A = delsq(numgrid('S',sqrt(n))); 
b = sum(A,2);
x0=zeros(n,1);
y=ones(n,1);
kmax=1000;
tol = 0.00001;
[xgs,kgs]=gauss_seidel(A,b,x0,tol,kmax)
[xgrad,kgrad]=gradiente(A,b,x0,tol,kmax)
[xgradcon]=gradienteconiugato(A,b,tol,kmax)
[xprecond]=precondizionamento(A,b)




