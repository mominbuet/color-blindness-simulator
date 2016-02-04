fabric = imread('peppers.png');
%cform = makecform('srgb2lab');
%lab_fabric = applycform(fabric,cform);
lab_fabric =rgb2lab(fabric);
%imshow(lab_fabric(:,:,2),[0 100])
[i, j, k]=size(lab_fabric(:,:,:));
new_image(i, j, k)=zeros;
theta = 30;
for x=1:i
    for y=1:j
        L=lab_fabric(x,y,1);
        a=lab_fabric(x,y,2);
        b=lab_fabric(x,y,3);
        new_image(x,y,:)=[L a b]*[1 0 0;0 cosd(theta) -sind(theta);0 sind(theta) cosd(theta)]*[cosd(theta) 0 sind(theta);0 1 0;-sind(theta) 0 cosd(theta)]*[cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
        %new_image(x,y,:)=new_image(x,y,:)*;%y axix
        %new_image(x,y,:)=new_image(x,y,:);%z axix
    end
end
new_fabric = lab2rgb(new_image);
figure(1)
subplot(1,2,1),imshow(fabric), title('Original Image');
subplot(1,2,2),imshow(new_fabric), title('Rotated Image');
%figure(1)
%for i=1:3
%subplot(1,3,i),imshow(lab_fabric(:,:,i),[0 100]), title(i);
%end
