
n=100;
x=linspace(-pi,pi,n);
%plot(x,sin(x),x,cos(x));
%%
n=100;
x=linspace(0.1,100,n);
f = sqrt((100.*(1-0.01.*x.^2).^2+0.02.*x.^2)./((1-x.^2).^2+0.1.*x.^2));
%plot(x,f)
%semilogy(x,f);
%loglog(x,f);
%%
n=100;
x1=linspace(-2,-0.001,n);
x2=linspace(0,2*pi*0.999,n);
x3=linspace(2*pi,8,n);
y1=exp(-1.*(x1.^2));
%plot(x1,y1,x2,cos(8.*x2),x3,1);
%%
n=100000;
x=linspace(0.01,2,n);
f = x.*sin(1./x);
%plot(x,f);
%semilogx(x,f);
%loglog(x,f);
%%
N=100;
x=zeros(1,N);
z=zeros(1,N);
x(1)=2;
z(1)=2;
for n=2:N
    x(n)= 2^(n-1/2)*sqrt(1-sqrt(1-4^(1-n)*x(n-1)^2));
    z(n)= z(n-1)*sqrt(2/(1+sqrt(1-4^(1-n)*z(n-1)^2)));
end
%plot(1:N,abs(x-pi),1:N,abs(z-pi));
%loglog(1:N,abs(x-pi),1:N,abs(z-pi));
%%
n=15;
h=zeros(1,n);
d=zeros(1,n);
err=zeros(1,n);
for i=1:15
    h(i)=10^-i;
    d(i)=(exp(1+h(i))-exp(1))/h(i);
    err(i)= abs(exp(1)-d(i));
end
loglog(h,err);






















