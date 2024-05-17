n=2:20;
figure
xx = linspace(0,1);
plot(xx,sin(pi*xx));
hold on
for i = 1:length(n)

    x=linspace(0,1,n(i));
    y=sin(pi*x);
    p=polyfit(x,y,n(i)-1);
    %plot(xx, polyval(p,xx))
end
hold off
%%
n=[5,10,15,20];
figure
xx = linspace(-5,5);
plot(xx,1./(1+xx.^2))
hold on
for i = 1:length(n)
    for k=1:n(i)
        x(k)=5*cos(((2*k-1)*pi)/(2*(n(i)+1)));
    end
    %x=linspace(-5,5,n(i));
    y=1./(1+x.^2);
    p=polyfit(x,y,n(i)-1);
    plot(xx, polyval(p,xx))
end
hold off