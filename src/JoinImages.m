function  OutputImage =JoinImages( InputImages )
OutputImage(size(InputImages{1},1),size(InputImages{1},2),size(InputImages{1},3)) = uint8(0);
for i=1:size(InputImages,2)
OutputImage=OutputImage+uint8(InputImages{i});%uint8(InputImages{1})+uint8(InputImages{2})+uint8(InputImages{3})+uint8(InputImages{4});


% clear OutputImage;
% OutputImage(size(InputImages{1},1),size(InputImages{1},2),size(InputImages{1},3))=zeros;
% 

% for i=1:size(InputImages,2)
%     size(InputImages{i})
% end

% clear InputImages;
% OutputImage(size(InputImages{1},1),size(InputImages{1},2),size(InputImages{1},3))=[];
% for i=1:size(InputImages{1},3)
%     OutputImage=OutputImage+InputImages{i};
% end
% for i=1:size(InputImages,1)
%     postive_values(i)=size(find(InputImages{i}(:,:,:)>0),1);
% end
% [max_value1, index1] = sort(postive_values);
%  OutputImage=InputImages{index1(1)};
% % for i=2:size(index1) 
% %     OutputImage=OutputImage+InputImages{index1(i)};
% %     
% % end
% clear max_value1;
% size(OutputImage);

% for i=1:size(InputImages,2)-1
%     for j=1:size(InputImages{i},1)
%         for k=1:size(InputImages{i},2)
%             for l=1:size(InputImages{i},3)
%                 if InputImages{i}(j,k,l)~=0 && OutputImage(j,k,l)==0
%                     OutputImage(j,k,l)=InputImages{i}(j,k,l);
%                 %elseif InputImages{i}(j,k,l)~=0 && OutputImage(j,k,l)~=0
%                 %    OutputImage(j,k,l)=round((OutputImage(j,k,l)+InputImages{i}(j,k,l))/2);
%                 end
%             end
%         end
%     end
% end

end