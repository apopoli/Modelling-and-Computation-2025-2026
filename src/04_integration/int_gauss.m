function [int] = int_gauss(f,a,b,n)
%int_gauss Computes a definite integral with gauss quadrature
%   f: handle to function to be integrated
%   a,b: boundaries of the integration interval
%   n: number of gauss points to be used

switch n
    case 1
        w = 2;
        tau = 0;
    case 2
        w = [1 1];
        tau = [-1/sqrt(3) 1/sqrt(3)];
    case 3
        w = [5/9 8/9 5/9];
        tau = [-sqrt(3/5) 0 sqrt(3/5)];
end

m = (b-a)/2;
q = (a+b)/2;

% could be rewritten as a for loop based on number of gauss points
int = sum(w .* m .* f(m.*tau + q));

end