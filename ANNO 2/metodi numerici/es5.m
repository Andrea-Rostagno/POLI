f=@(x) (1-x.^2).^(5/2);
k=[2,3,4,5];
for j=1:length(k)
    n=2^k(j);
    for i=0:2^n
        x(i+1)=-1+2*i/n;
        y=f(x);
        z=linspace(x(1),x(length(x)));
        s=spline(x,y,z);
        hold on
        plot(z,s);
    end
end
hold off