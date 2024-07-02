function [conn_mats] = compute_multi_connectome(image_dir, atlas_path, n, avoid_zero, outdir)

% Get list of image files in the directory
image_files = dir(fullfile(image_dir, '*.nii'));
num_subjects = length(image_files);

% Initialize a cell array to store the connectivity matrices for each subject
conn_mats = cell(num_subjects, 1);

% Load the atlas once
atlas = load_nii(atlas_path); 
atlas = atlas.img;

% Iterate over each subject
for subj = 1:num_subjects
    % Load the subject's image
    image_path = fullfile(image_dir, image_files(subj).name);
    image = load_nii(image_path); 
    image = image.img;
    
    % Initialize the matrix to store KLS
    conn_mat = compute_connectome(image, atlas, n, avoid_zero);
    conn_mats{subj} = conn_mat;
    
    % Construct the output filename
    [~, name, ~] = fileparts(image_files(subj).name);
    filename = fullfile(outdir, [name, '.csv']);
    
    % Save the connectivity matrix to a CSV file
    csvwrite(filename, conn_mat);
end