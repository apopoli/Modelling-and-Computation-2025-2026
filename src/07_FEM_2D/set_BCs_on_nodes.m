function BCval_p = set_BCs_on_nodes(msh, BC)
    % Extract boundary edge info from msh structure
    edges = msh.LINES(:, 1:2); % Node indices of boundary edges
    tags = msh.LINES(:, 3);    % Edge tags
    
    % Initialize storage for boundary conditions
    node_indices = unique(edges(:)); % Unique nodes involved in boundary edges
    BCval_p = zeros(length(node_indices), 3); % [NodeIndex, BC_Type, BC_Val]
    
    % Loop over each node and determine the boundary condition
    for i = 1:length(node_indices)
        node = node_indices(i);
        
        % Find all edges involving this node
        rows = find(edges(:,1) == node | edges(:,2) == node);
        node_tags = tags(rows); % Tags for the edges involving this node
        
        % Check for Dirichlet conditions (priority)
        dirichlet_mask = ismember(node_tags, BC.D.tag);
        if any(dirichlet_mask)
            % If Dirichlet exists, take the first matching value
            edge_tag = node_tags(dirichlet_mask);
            BC_val = BC.D.val(BC.D.tag == edge_tag(1));
            BC_type = 2; % Dirichlet
        else
            % Otherwise, check for Neumann conditions
            neumann_mask = ismember(node_tags, BC.N.tag);
            if any(neumann_mask)
                edge_tag = node_tags(neumann_mask);
                BC_val = BC.N.val(BC.N.tag == edge_tag(1));
                BC_type = 1; % Neumann
            else
                % No boundary condition found for this node (default to zero Neumann)
                BC_val = 0;
                BC_type = 1;
            end
        end
        
        % Store result in BCval_p
        BCval_p(i, :) = [node, BC_type, BC_val];
    end
end
