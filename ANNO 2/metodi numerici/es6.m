x= 0:3;
y=[1,4,8,16];
t=exp(x);
p=polyfit(t,y,length(x)-1);
xx= linspace(0,3);
plot(xx,polyval(p,exp(xx)));