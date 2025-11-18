function [int] = int_adt(f,a,b,n,tol)
%INT_ADT Summary of this function goes here
%   Detailed explanation goes here

I_1 = int_gauss(f,a,b,n);

mp = (a+b)/2;
I_2 = int_gauss(f,a,mp,n) + int_gauss(f,mp,b,n);

err = abs(I_1-I_2);

if err < tol
    int = I_2;
else
    I_L = int_adt(f,a,mp,n,tol);
    I_R = int_adt(f,mp,b,n,tol);

    int = I_L + I_R;
end

end