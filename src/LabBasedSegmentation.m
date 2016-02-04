clear All
fabric = imread('cimage3.jpg');
%figure(1), imshow(fabric), title('fabric');
load regioncoordinates;
%http://www.mathworks.com/help/images/examples/color-based-segmentation-using-the-l-a-b-color-space.html
nColors = 3;
sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric,region_coordinates(:,1,count),...
                                      region_coordinates(:,2,count));
end

%imshow(sample_regions(:,:,2)),title('sample region for red');
lab_fabric = rgb2lab(fabric);
a = lab_fabric(:,:,2);
b = lab_fabric(:,:,3);
color_markers = zeros([nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end
%the average color of the red sample region in 'a*b*' space 
fprintf('[%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2));

color_labels = 0:nColors-1;
%color_labels[0]=
a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);

for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[~, label] = min(distance,[],3);
label = color_labels(label);
clear distance;

rgb_label = repmat(label,[1 1 3]);
segmented_images = zeros([size(fabric), nColors],'uint8');

for count = 1:nColors
  color = fabric;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
end

figure(1)
for i=1:nColors
    subplot(1,nColors,i),imshow(segmented_images(:,:,:,i)), title(i);
        %[ size(find(segmented_images(:,:,1,i)==0)) i ]
    %end
end

%C = imfuse(RotateColor(segmented_images(:,:,:,1),-10),RotateColor(segmented_images(:,:,:,2),20),'blend','Scaling','joint');
%C = imfuse(C,RotateColor(segmented_images(:,:,:,3),10),'blend','Scaling','joint');
joined_image(1:size(segmented_images,1),1:size(segmented_images,2),1:size(segmented_images,3))=zeros;
% for i=1:nColors
%     for j=1:3
%         for k=1:size(segmented_images,2)
%             %fprintf('%d \n',size(find(segmented_images(l,k,j,:)>240)));
%             for l=1:size(segmented_images,1)
%                 if segmented_images(l,k,j,i)~=0
%                 %    joined_image(l,k,j)=fabric(l,k,j);
%                % else
%                     if joined_image(l,k,j)==0 % && segmented_images(l,k,j,i)~=0
%                         joined_image(l,k,j)=segmented_images(l,k,j,i);
%                     else
%                         joined_image(l,k,j)= ceil((joined_image(l,k,j)+segmented_images(l,k,j,i))/2);
%                         ceil((joined_image(l,k,j)+segmented_images(l,k,j,i))/2);
%                     end
%                 %elseif segmented_images(l,k,j,i)==0 && fabric(l,k,j)~=0
%                 %    joined_image(l,k,j)=fabric(l,k,j);
%                 end
%             end
%         end
%     end
% end



%C =joined_image;
C = imfuse(segmented_images(:,:,:,1),segmented_images(:,:,:,2),'falsecolor','Scaling','joint','ColorChannels',[2 1 2]);
C = imfuse(C,segmented_images(:,:,:,3),'falsecolor','Scaling','joint','ColorChannels',[2 1 2]);

figure(2)
subplot(2,2,1), imshow(fabric), title('Image');
subplot(2,2,2), imshow(C), title('Joined Image');
subplot(2,2,3), imshow(convertToDichromatImage(fabric, 'deutran')), title('CB Original');
subplot(2,2,4), imshow(convertToDichromatImage(C, 'deutran')), title('Result Output');

purple = [119/255 73/255 152/255];
plot_labels = {'k', 'r', 'g', purple, 'm', 'y'};

figure(3)
for count = 1:nColors
  plot(a(label==count-1),b(label==count-1),'.','MarkerEdgeColor', ...
       plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
  hold on;
end

title('Scatterplot of the segmented pixels in ''a*b*'' space');
xlabel('''a*'' values');
ylabel('''b*'' values');