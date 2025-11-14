function [x,phi] = FDM_1D_s2(geom,BC,t)
<<<<<<< Updated upstream
%FDM_1D_S1 Summary of this function goes here
%   inputs
%       geom: struct containg info on problem geometry
%       BC: struct containg info on boundary conditions
%       t: right-hand-side array (known term of the problem)
%   outputs
%       x: node coordinates
%       phi: uknown function computed at every node

% unpacking the input structures
n = geom.n; % number of nodes
a = geom.a; % left boundary
b = geom.b; % right boundary

L = b-a; % length of domain
dx = L/(n-1); % spacing between nodes 

K = zeros(n); % square matrix with same size as number of nodes
rhs = zeros(n,1); % column array containg the right-hand-side of the problem

% assemble [K]{phi} = {rhs}

% loop for internal nodes
for k=2:n-1
    K(k,k-1) = 1; % left
    K(k,k) = -2; % main diagonal
    K(k,k+1) = 1; % right

    rhs(k) = t*dx^2;
end

% first node
switch BC.a.type
    case('D') % Dirichlet conditions
        K(1,1) = 1; % to enforce Dirichlet BC on node 1
        rhs(1) = BC.a.val; % value of BC at node a
    case('N') % Neummann conditions
        K(1,1) = -1;
        K(1,2) = 1;
        rhs(1) = dx*(dx/2*t-BC.a.val); 
end

% last node
switch BC.b.type
    case('D') % Dirichlet conditions
        K(n,n) = 1; % to enforce Dirichlet BC on node 1
        rhs(n) = BC.b.val; % value of BC at node a
    case('N') % Neummann conditions
        K(n,n) = -1;
        K(n,n-1) = 1;
        rhs(n) = dx*(dx/2*t-BC.b.val); 
end

% solve the linear system
phi = K\rhs;

% compute values of x
k_idx = 1:1:n; % indexes of nodes
x = a + dx*(k_idx-1);

=======
%FDM_1D_s1 Use Finite Difference Method for Poisson's equation in 1D
%   Solves Poisson problem in 1D
%   inputs: geom,BC
%   outputs: x,phi

% collect inputs
a = geom.a;
b = geom.b;
n = geom.n;

x = linspace(a,b,n);
dx = (b-a)/(n-1); % grid spacing

K = zeros(n);
rhs = zeros(n,1);

% cycle on internal nodes
for i=2:n-1
    K(i,i-1) = 1;
    K(i,i) = -2; % main diagonal
    K(i,i+1) = 1;

    rhs(i) = dx^2*t(x(i)); % x(i): coordinates of node at iteration i
end

% boundary conditions
K(1,1) = 1;
rhs(1) = BC.a.val; % value of BC in a

switch BC.b.type
    case('D')
        K(n,n) = 1;
        rhs(n) = BC.b.val; % value of BC in b
    case('N')
        K(n,n-1) = 1;
        K(n,n) = -1;
        rhs(n) = t(x(n))/2*dx^2 - dx*BC.b.val;
end

% ready to solve the system!
phi = K\rhs;

>>>>>>> Stashed changes
end