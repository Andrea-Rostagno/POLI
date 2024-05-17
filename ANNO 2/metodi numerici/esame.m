%x=linspace(-2,4,7);
%y=exp((-x.^2)/3);
%c=polyfit(x,y,6);
%p=polyval(c,x);
%hold on
%plot(x,y)
%plot(x,p)
%hold off
%%
%n=2000;
%a=diag(5*ones(1,n),0)+diag(2*ones(1,n-5),5)+diag(2*ones(1,n-5),-5);
%b=ones(n,1);
%x=pcg(a,b);
%%
x0=-1;
nmax=5;
tol=0.00000001;
%[x,n,ier]=puntofisso((exp(2*x)-2)/2,x0,nmax,tol);
%%
x=linspace(0,1,5);
y=x.*exp(x);
z=linspace(0,1);
s=interp1(x,y,z);
p=polyval(s,0.14)

