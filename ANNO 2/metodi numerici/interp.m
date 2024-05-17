function p = interp(x,a,z)
n = length(x)-1;
p = a(n+1)*ones(1,length(z));
for k = n:-1:1
 p = p.*(z-x(k))+a(k);
end