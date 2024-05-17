a= -5;
b=5;

%f=(variabili) espres della funz
f=@(x) 1./(1+x.^2);

for n=5:4:13

x=linspace(a,b,n+1);
y=f(x);

c=polyfit(x,y,n);

z=linspace(a,b);
p=polyval(c,z);

fz=f(z);

plot(x,y,'ko',z,fz,'r',z,p,'b','LineWidth',3)
err=max(abs(f(z)-p))
pause
end

