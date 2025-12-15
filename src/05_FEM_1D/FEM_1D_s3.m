function [phi] = FEM_1D_s3(x,p,t,phi_a,phi_b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = length(x);
n_el = n-1;

% initialization of matrices/arrays
K = zeros(n);
rhs = zeros(n,1); % column array

% assemble K and rhs on a per-element basis
for i = 1:n_el
    
    delta = x(i+1)-x(i); % spacing between nodes of the given element

    % coefficient matrix
    % K_el = [p/delta -p/delta
    %     -p/delta p/delta];
    % rhs_el = -[t*delta/2; t*delta/2];

    int_p = int_gauss(p,x(i),x(i+1),3);
    K_el = [1/delta^2*int_p -1/delta^2*int_p
        -1/delta^2*int_p 1/delta^2*int_p];
    
    xk = x(i);
    L_k = @(x) 1-(x-xk)/delta;
    L_times_t = @(x) L_k(x) .* t(x);
    int_1 = int_gauss(L_times_t,x(i),x(i+1),3);
    

    xkp1 = x(i+1);
    L_kp1 = @(x) 1+(x-xkp1)/delta;
    L_times_t = @(x) L_kp1(x) .* t(x);
    int_2 = int_gauss(L_times_t,x(i),x(i+1),3);
    
    rhs_el = -[int_1; int_2];

    K(i:i+1,i:i+1) = K(i:i+1,i:i+1) + K_el;
    rhs(i:i+1) = rhs(i:i+1) + rhs_el;
end

% fix first and last row to account for BCs
K(1,:) = 0; % wiping out row 1
K(1,1) = 1;
rhs(1) = phi_a; % BC value

K(end,:) = 0;
K(end,end) = 1;
rhs(end) = phi_b; % BC value

phi = K\rhs;

end