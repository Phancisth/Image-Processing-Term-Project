% Specify the folder where the files live.
myFolder = 'E:\OneDrive\MUICT Year 4 Semester 1\Digital Image Processing\image-processing-project\useful';

% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
   
    % Now do whatever you want with this file name,
    % such as reading it in as an image array with imread()
    imageArray = imread(fullFileName);
    %imshow(imageArray);  % Display image.
    drawnow; % Force display to update immediately.

    global image;
    global rgbImage;
    global filename;
    global excel;
    excel = 'E:\OneDrive\MUICT Year 4 Semester 1\Digital Image Processing\image-processing-project\test_me.xlsx';

    tab = xlsread(excel);
    [rr, cc0] = size(tab);
    rgbImage = imageArray;

    %....................................................................................
    
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
    %....................................................................................
    
    
    
    
    % ............................ Calculate Features
     mred=mean(mean(maskedRgbImage(:,:,1)))/100;
     mgreen=mean(mean(maskedRgbImage(:,:,2)))/100;  % Error when train an rice image %
     mblue=mean(mean(maskedRgbImage(:,:,3)))/100;
     gray=rgb2gray(maskedRgbImage); mgray=mean(mean(gray))/100;
     glcm=graycomatrix(gray,'O', [0,1]);
     S=graycoprops(glcm);
     homo=S.Homogeneity;
     cont=S.Contrast*10;
     energy=S.Energy;
     corr=S.Correlation;
     rngfil=rangefilt(maskedRgbImage);  
     entro=entropy(rngfil)/10;
     
    % ............................... calculate Excel Cell
     cell1=cat(2,'A',num2str(rr+2));
     cell2=cat(2,'B',num2str(rr+2));
     cell3=cat(2,'C',num2str(rr+2));
     cell4=cat(2,'D',num2str(rr+2));
     cell5=cat(2,'E',num2str(rr+2));
     cell6=cat(2,'F',num2str(rr+2));
     cell7=cat(2,'G',num2str(rr+2));
     cell8=cat(2,'H',num2str(rr+2));
     cell9=cat(2,'I',num2str(rr+2));
     cell10=cat(2,'J',num2str(rr+2));

    % .................................. Write Excel Data
     xlswrite(excel,{baseFileName},1,cell1);
     xlswrite(excel, mred,1,cell2);
     xlswrite(excel, mgreen,1,cell3);
     xlswrite(excel, mblue,1,cell4);
     xlswrite(excel, mgray,1,cell5);
     xlswrite(excel, entro,1,cell6);
     xlswrite(excel, energy,1,cell7);
     xlswrite(excel, corr,1,cell8);
     xlswrite(excel, cont,1,cell9);
     xlswrite(excel, homo,1,cell10);
 
   
end
system('taskkill /F /IM EXCEL.EXE');