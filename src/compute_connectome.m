function [conn_mat] = compute_connectome(image, atlas, n, avoid_zero)

% Get the ROIs IDs
roi_ids = unique(atlas);
roi_ids(roi_ids==0) = [];
nrois = length(roi_ids);

% Initialize the matrix to store KLS
conn_mat = zeros(nrois, nrois);

% Calculate PDFs using kernel density estimation for each ROI
kpdfs = cell(nrois, 1);
for roi = 1:nrois
    roi_idx = roi_ids(roi);
    roi_data = image(atlas==roi_idx);
    [~, kpdfs{roi}, ~, ~] = kde(roi_data, n);
    if avoid_zero
        kpdfs{roi} = kpdfs{roi} + eps;
    end
end

% Compute KLS
for i = 1:nrois
    for j = 1:nrois
        conn_mat(i, j) = exp(-kl_symmetric(kpdfs{i}, kpdfs{j}));
    end
end

end