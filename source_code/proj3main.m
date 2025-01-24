function proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)

%file handling and filtering
dir_list = dir(dirstring);
dir_list = dir_list(~ismember({dir_list.name}, {'.', '..', '.DS_Store'}));
[height, width, ~] = size(imread(fullfile(dirstring, dir_list(1).name)));

images = zeros(height, width, maxframenum);

%conversion to grayscalee
for i=1:maxframenum
    currentimg = imread(fullfile(dirstring, dir_list(i).name));
    currentimg1 = rgb2gray(currentimg);
    images(:,:,i) = currentimg1;
end


%start running algorithms here

B = images(:,:,1);
final_images = zeros(height, width, maxframenum); % Initialize as binary mask

B2 = images(:,:,1);
final_images2 = zeros(height, width, maxframenum); % Initialize as binary mask

B3 = images(:,:,1);
final_images3 = zeros(height, width, maxframenum); % Initialize as binary mask

B4 = images(:,:,1);
H = 0;
M = zeros(height, width, maxframenum); % Initialize as binary mask
final_H = zeros(height, width, maxframenum);


for i=1:maxframenum
    image = images(:,:,i);

    % Perform differencing of base and current frame
    diff = abs(double(B) - double(image));
    diff2 = abs(double(B2) - double(image));
    diff3 = abs(double(B3) - double(image));
    diff4 = abs((B4) - (image));

    %perform thresholding
    final_images(:,:,i) = imbinarize(diff, abs_diff_threshold);
    final_images2(:,:,i) = imbinarize(diff2, abs_diff_threshold);
    final_images3(:,:,i) = imbinarize(diff3, abs_diff_threshold);
    M(:,:,i) = imbinarize(diff4, abs_diff_threshold);

    B2 = image;
    B3 = alpha_parameter*image + (1-alpha_parameter)*B3;
   
    % case for Persistent frame differencing
    tmp = max(H-gamma_parameter, 0);
    H = max(255*M(:,:,i), tmp);
    final_H(:,:,i) = H;
    
    B4 = image;


end

outimage = [final_images(:,:,100) final_images2(:,:,100); final_images3(:,:,100) final_H(:,:,100)/255];
imshow(outimage);

% The following is for saving images

%{

path = '/Users/rodrigoolaya/documents/classes/classes_sp24/cmpen454/454_projects/454_proj3/output_images/Deer';

for i=1:maxframenum
    filename = sprintf('%s_%04d.png', 'output_image', i); % Output image filename with leading zeros
    filepath = fullfile(path, filename); % Full path to save the image
    outimage = [final_images(:,:,i) final_images2(:,:,i); final_images3(:,:,i) final_H(:,:,i)/255];
    imwrite(outimage, filepath);
end

%}