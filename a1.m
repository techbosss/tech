clc; clear; close all;

% Load the mammogram image
img = imread('C:\breast cancer code\breast cancer image\mammogram.jpg'); 

%%
% Resize the image (optional)
img = imresize(img, [512, 512]);

% Apply a median filter to reduce noise
img = medfilt2(img, [3, 3]);

% Enhance contrast (optional)
img = histeq(img);
% Apply segmentation (e.g., thresholding)
threshold = graythresh(img);
bw = imbinarize(img, threshold);
% Calculate the area of the segmented region
stats = regionprops(bw, 'Area');
area = stats.Area;
% Define a threshold for suspicious area
suspiciousThreshold = 2000;

% Classify the mammogram
if area > suspiciousThreshold
    disp('Suspicious: Possible cancer detected.');
else
    disp('Normal: No cancer detected.');
end
% Display the segmented region
figure;
imshow(bw);
title('Segmented Region');

% Display the classification result
if area > suspiciousThreshold
    text = 'Suspicious: Possible cancer detected';
else
    text = 'Normal: No cancer detected';
end

figure;
imshow(img);
title('Original Mammogram');
text(10, 30, text, 'Color', 'red', 'FontSize', 14);
