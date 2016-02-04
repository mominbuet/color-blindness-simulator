function  Rotated  = RotateColor( image,theta )
%ROTATECOLOR Summary of this function goes here
%   Detailed explanation goes here

lab_image =rgb2lab(image);
%imshow(lab_fabric(:,:,2),[0 100])
[i, j, k]=size(lab_image(:,:,:));
new_image(i, j, k)=zeros;
for x=1:i
    for y=1:j
        L=lab_image(x,y,1);
        a=lab_image(x,y,2);
        b=lab_image(x,y,3);
        if x>0 && y>0
            %size([cosd(theta) 0 sind(theta);0 1 0;-sind(theta) 0 cosd(theta)])%*rotz(theta);        rotationMatrix
            %size([cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1])
            rotationMatrix=([cosd(theta) 0 sind(theta);0 1 0;-sind(theta) 0 cosd(theta)])*([cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1]);
            %*[cosd(theta) - sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
            new_image(x,y,:) =[L a b]*rotationMatrix;
            
        else
            new_image(x,y,:) =[L a b];
        end
        
        %new_image(x,y,:) = tmp*[cosd(theta) - sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
    end
end
Rotated = lab2rgb(new_image);
end

