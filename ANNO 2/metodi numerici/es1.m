prompt = "quanti numeri vuoi inserire? ";
n = input(prompt);
kmax=n;
for k= 1:kmax
    prompt = "inserire ascissa ";
    x(k) = input(prompt);
    y(k)= sin(x(k));
end
%z=linspace(x(1),x(n),n);
%s=interp1(x,y,z);
prompt = "quale numero vuoi controllare? ";
t = input(prompt);
if x(1)<=t && x(n)>=t
    val1=sin(t);
    val=interp(x,y,t);
    disp(abs(val1-val))
else
disp("numero non compreso nell'intervallo");
end