function [ConvertedLabImage] = ConvertContrast( LabImageChannelMain,whichChannel, mainChannel,multiplicationFactor )
ConvertedLabImage=LabImageChannelMain;
LabImageChannel = LabImageChannelMain(:,:,whichChannel);
%ConvertedLabImage = LabImageChannel;
positive_indices=find(LabImageChannel>0);
negetive_indices =find(LabImageChannel<0);
if size(negetive_indices)>0
    negetive_values(length(negetive_indices))=zeros;
    for i=1:length(negetive_indices)
        negetive_values(i)=LabImageChannel(negetive_indices(i));
    end
end
if size(positive_indices)>0
    positive_values(length(positive_indices))=zeros;
    for i=1:length(positive_indices)
        positive_values(i)=LabImageChannel(positive_indices(i));
    end
end
color_ratio=1;
if size(negetive_indices)>0 & size(positive_indices)>0
    if mainChannel~=1 %trouble with && :(
        color_ratio=length(positive_values)/length(negetive_values);
    end
end
color_ratio = abs(color_ratio)*multiplicationFactor;
%fprintf('positive values %d, negetive values %d total size %d ratio %d \n',size(positive_indices),size(negetive_indices),size(LabImageChannel),color_ratio);
if size(negetive_indices)>0
    mean_negetive_value=mean2(negetive_values);
else
    mean_negetive_value=0;
end
if size(positive_indices)>0
    mean_positive_value=mean2(positive_values);
else
    mean_positive_value=0;
end
% fprintf('mean_positive_value %d, mean_negetive_value %d \n',mean_positive_value,mean_negetive_value);
for i=1:size(LabImageChannel,1)
    for j=1:size(LabImageChannel,2)
        if LabImageChannel(i,j)>0
            %             if mainChannel==1
            ConvertedLabImage(i,j,whichChannel)=LabImageChannel(i,j)+mean_positive_value*color_ratio;
            %             else
            %                 ConvertedLabImage(i,j,whichChannel)=LabImageChannel(i,j)+mean_positive_value;
            %             end
        else %no point of this one now
            %if mainChannel==1
            ConvertedLabImage(i,j,whichChannel)=LabImageChannel(i,j)+mean_negetive_value*color_ratio;
            %             else
            %                 ConvertedLabImage(i,j,whichChannel)=LabImageChannel(i,j)-mean_negetive_value;
            %             end
        end
    end
end
end