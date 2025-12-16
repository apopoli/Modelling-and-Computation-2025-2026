function visualizeFieldContour(phi, p, t, Ex, Ey)
    % Visualizes the scalar field (phi) as contour lines and the vector field (Ex, Ey)
    %
    % Inputs:
    %   phi - Nodal values of the scalar field (e.g., electric potential)
    %   p   - Nodal coordinates (num_nodes x 2 matrix)
    %   t   - Triangulation matrix (num_elements x 3 matrix)
    %   Ex  - x-component of the vector field (e.g., electric field)
    %   Ey  - y-component of the vector field (e.g., electric field)

    figure;
    
    % Create a grid for contour plotting
    % You can increase grid density by increasing nx and ny
    nx = 100;  % Number of grid points in x-direction
    ny = 100;  % Number of grid points in y-direction
    xq = linspace(min(p(:,1)), max(p(:,1)), nx);
    yq = linspace(min(p(:,2)), max(p(:,2)), ny);
    [Xq, Yq] = meshgrid(xq, yq);
    
    % Interpolate the potential values over the grid
    phi_grid = griddata(p(:,1), p(:,2), phi, Xq, Yq, 'linear');
    
    % Plot the contour lines (iso-lines of the scalar field)
    contour(Xq, Yq, phi_grid, 20, 'LineWidth', 1.5);  % 20 iso-lines
    hold on;

    % Plot the vector field (electric field) using quiver
    quiver(p(:, 1), p(:, 2), Ex, Ey, 'r', 'LineWidth', 1);

    % Set axis properties for better visualization
    axis equal;
    grid on;
    
    % Add labels and title
    xlabel('X');
    ylabel('Y');
end