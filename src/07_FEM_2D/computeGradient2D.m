function [Ex, Ey] = computeGradient2D(phi, p, t)
    % Computes the x and y components of the gradient
    % of a scalar field phi at the nodes of a 2D triangular mesh.
    %
    % Inputs:
    %   phi - Nodal values of the scalar field (vector of length num_nodes)
    %   p   - Coordinates of the nodes (num_nodes x 2 matrix)
    %         p(:,1) are the x-coordinates and p(:,2) are the y-coordinates
    %   t   - Triangulation matrix (num_elements x 3 matrix)
    %         Each row contains indices of the 3 nodes forming a triangle
    %
    % Outputs:
    %   Ex - x component of the gradient at the nodes (vector of length num_nodes)
    %   Ey - y component of the gradient at the nodes (vector of length num_nodes)

    % Extract nodal coordinates
    x = p(:, 1);
    y = p(:, 2);
    
    % Number of elements and nodes
    num_elements = size(t, 1);
    num_nodes = size(p, 1);
    
    % Get the coordinates of the triangle vertices for all elements
    x1 = x(t(:, 1)); x2 = x(t(:, 2)); x3 = x(t(:, 3));
    y1 = y(t(:, 1)); y2 = y(t(:, 2)); y3 = y(t(:, 3));
    
    % Compute the area of each triangle using determinant-based formula
    Area = 0.5 * ((x2 - x1) .* (y3 - y1) - (x3 - x1) .* (y2 - y1));
    
    % Gradients of the shape functions (constant for linear elements)
    dN_dx = [(y2 - y3), (y3 - y1), (y1 - y2)] ./ (2 * Area);
    dN_dy = [(x3 - x2), (x1 - x3), (x2 - x1)] ./ (2 * Area);
    
    % Nodal values of the scalar field for all elements
    phi_e = [phi(t(:, 1)), phi(t(:, 2)), phi(t(:, 3))];
    
    % Compute the gradient of the scalar field in each element
    grad_phi_x = sum(dN_dx .* phi_e, 2);
    grad_phi_y = sum(dN_dy .* phi_e, 2);
    
    % Initialize gradients at the nodes and counters
    Ex = zeros(num_nodes, 1);
    Ey = zeros(num_nodes, 1);
    icount = zeros(num_nodes, 1);
    
    % Accumulate gradient contributions at the nodes
    for i = 1:3
        node_indices = t(:, i);
        Ex = Ex + accumarray(node_indices, grad_phi_x, [num_nodes, 1], @sum, 0);
        Ey = Ey + accumarray(node_indices, grad_phi_y, [num_nodes, 1], @sum, 0);
        icount = icount + accumarray(node_indices, 1, [num_nodes, 1], @sum, 0);
    end
    
    % Average the gradient contributions at each node
    Ex = Ex ./ icount;
    Ey = Ey ./ icount;
end