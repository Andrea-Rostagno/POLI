function yq= my_spline(x,y,xq)
if not(length(y) == length(x)+2)
    error('hai sbagliato');
end
h=x(2)-x(1);
D1= y(1); Dend=y(end);
y=y(2:end-1);
rapp_inc_y=(y(2:end)-y(1:end-1))/h;
diag_princ= h*[2;4*ones(length(x)-2,1);2];
diag_lat=h*ones(length(x)-1,1);
b= [6*(rapp_inc_y(1)-D1);...
    6*(rapp_inc_y(2:end)-rapp_inc_y(1:end-1));...
    6*(Dend-rapp_inc_y(end))];

M=gauss_tridiag_nopiv(diag_princ,diag_lat,b);
c=rapp_inc_y + h/6*(M(1:end-1)-M(2:end));
d= y(1:end-1) - h^2/6*M(1:end-1);

yq= zeros(size(xq));
for k=1:length(xq)
    i=1;
    while xq(k)> x(i+1) && i<= length(x)
        i=i+1;
    end
end
yq(k)=


