for i=1:100
    for j= 1:100
        a(i,j)=max(i,j);


    end



end
b=a'*a;
r=chol(b);
r(52,64)