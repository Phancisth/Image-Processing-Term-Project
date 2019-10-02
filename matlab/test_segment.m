rgbImage = imread('C:\Users\Dell\OneDrive\Documents\MATLAB\Petals\u6.JPG');

[rows, columns, numberOfColorBands] = size(rgbImage);

set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
[rows, columns, numberOfColorBands] = size(rgbImage);
if numberOfColorBands > 1
  % Convert it to gray scale by taking only the green channel.
  % The green channel will have the highest contrast for these green seeds.
  grayImage = rgbImage(:, :, 2); % Take green channel.
end

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

[pixelCount, grayLevels] = imhist(grayImage);
binaryImage = grayImage > 120;

binaryImage = imclearborder(binaryImage);
binaryImage = imfill(binaryImage, 'holes');
binaryImage = bwareaopen(binaryImage, 500);

maskedRgbImage = bsxfun(@times, rgbImage, cast(binaryImage, class(rgbImage)));

imshow(maskedRgbImage, []);




















