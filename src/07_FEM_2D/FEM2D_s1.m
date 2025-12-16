function [phi] = FEM2D_s1(msh,p,t,BC)
%FEM2D_s1 Solves Poisson equation on a triangular mesh
%   msh: structure with mesh info from GMSH
%   p: coefficient in nabla * (p nabla phi) = t
%   t: forcing term in in nabla * (p nabla phi) = t
%   BC: structure with info on boundary conditions

% importing mesh info
T = msh.TRIANGLES(:,1:3); % connectivity matrix
x = msh.POS(:,1); % x-coordinate of nodes
y = msh.POS(:,2); % y-coordinate of nodes

% get number of nodes and elements
nnodes = msh.nbNod; % number of nodes
nel = size(msh.TRIANGLES,1); % number of triangles (elements)

% Initialize [K] and [rhs]
K = zeros(nnodes); % size: nnodes x nnodes
rhs = zeros(nnodes,1); % size: nnodes x 1

% assembly of [K] and [rhs] 
for i=1:nel % cycle on all elements
    
    i_vert = T(i,:); % row i of connectrivity matrix

    PV = [ones(3,1) x(i_vert) y(i_vert)];
    inv_PV = inv(PV); % inverse of matrix PV
    grad_L = inv_PV(2:3,:);

    S = 1/2 * det(PV);
    
    % build element matrix K_el
    K_el = p * (grad_L' * grad_L) * S;

    % build right-hand-side array rhs_el
    rhs_el = ones(3,1) * t * S;

    K(i_vert,i_vert) = K(i_vert,i_vert) + K_el;

    rhs(i_vert) = rhs(i_vert) + rhs_el;
end

% Boundary conditions
BCval_p = set_BCs_on_nodes(msh, BC); % set BCs on nodes based on edges

for i=1:size(BCval_p,1)
    i_node =  BCval_p(i,1); % node index
    BC_type =  BCval_p(i,2); % BC type 2: Dirichlet | 1: Neumann
    BC_val =  BCval_p(i,3); % BC value

    switch(BC_type)
        case(2) % dirichlet BC
            K(i_node,:) = 0; % clean row of matrix K
            K(i_node,i_node) = 1;
            rhs(i_node) = BC_val;
        case(1) % Neumann BC
            % if zero neumann BC: do nothing!!!
    end
end

phi = K\rhs; % solve!

end