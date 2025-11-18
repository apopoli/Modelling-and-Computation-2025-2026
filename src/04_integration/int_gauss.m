function [int] = int_gauss(f,a,b)
%int_gauss Computes a definite integral with gauss quadrature
%   f: handle to function to be integrated
%   a,b: boundaries of the integration interval

% assume: n = 1 % 1 gauss point
% w = 2 (weight)
% tau = 0

w = 2;
m = (b-a)/2;
q = (a+b)/2;

int = w * m * f(m*tau + q);

end