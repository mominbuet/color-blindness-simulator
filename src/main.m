img = imread('cimage16.jpg');
img = im2double(img);
imgChanged=imsharpen(img,'Radius',2,'Amount',1);


imgChanged=decorrstretch(imgChanged, 'Tol', 0.01);
imgAdjusted=imadjust(imgChanged,stretchlim(imgAdjusted),[]);
%imgAdjusted = imadjust(imgAdjusted,[.5 0 0; 1 .5 1],[]);
%imgAdjusted = imadjust(img_changed,stretchlim(img_changed));

imgOut = convertToDichromatImage(img, 'deutran');
imgOutConverted=convertToDichromatImage(imgAdjusted, 'deutran');
%figure,imshow(imgOut, []);
%title('Dichromacy deutran');

%imgdouble = rgb2xyz(imgAdjusted);
%imshow(imgdouble)
%j=imgdouble(:,:,1);
%k=imgdouble(:,:,2);
%l=imgdouble(:,:,3);

%scatterPlot(imgAdjusted);
showHistogram(img);
showHistogram(imgAdjusted);
figure
subplot(2,2,1), imshow(img, [])
title('Original Image')
subplot(2,2,2), imshow(imgOut, [])
title('Dichromacy deutran')
subplot(2,2,3), imshow(imgAdjusted, [])
title('Converted Image')
subplot(2,2,4), imshow(imgOutConverted, [])
title('Converted Image to Dichromacy deutran')
%subplot(1,4,3), imshow(k, [])
%subplot(1,4,4), imshow(l, [])
%figure,imshow(img, []);
%title('Dichromacy deutran');
%subplot(1,3,3), imshow(imgdouble, [])
%[imgOut] = convertToDichromatImage(img, 'protan');

%figure,imshow(imgOut, []);
%title('Dichromacy protan');


%[imgOut] = convertToMonochromatic(img);

%figure,imshow(imgOut, []);
%title('Monocromacy');