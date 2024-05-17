n=[5,10,15];
for k=1:length(n)
    z=linspace(-5,5);
    x=linspace(-5,5,n(k));
    f=@(x) 1./(1+x.^2);
    y=f(x);
    s=spline(x,y,z);
    hold on
    plot(z,s);
end
hold off