function [ ConvertedLabImage ] = IncreaseDecreaseChannel( LabImage,sign )
mean_value=mean2(LabImage(:,:));
ConvertedLabImage =zeros(size(LabImage,1),size(LabImage,2));
for i=1:size(LabImage,1)
    for j=1:size(LabImage,2)
        if sign==1
            ConvertedLabImage(i,j)=LabImage(i,j)+mean_value/2;
        else
            ConvertedLabImage(i,j)=LabImage(i,j)-mean_value/2;
        end
    end
end
end

