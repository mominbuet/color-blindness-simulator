whichTypeCB='tritan';%deutran,tritan

figure_no=1;
LimitOfUnknowingness=4;
images={'cimage1.jpg','winnipeg.png','tokyo.jpg','van.jpg'};
CurrentImageIndex=2;
%for ImageIndex=1:size(images,2)
    clear functions
    varlist = {'segmented_images','segmented_images_tmp','he','lab_he','generatedImage'};
    clear(varlist{:})
    he = imread(images{CurrentImageIndex});
%     cform_rgb = makecform('srgb2lab');
%     cform_lab = makecform('lab2srgb');
%     lab_he = applycform(he,cform_rgb);l
    lab_he=rgb2lab(he);
    lab_he_original = lab_he;
    % lab_he = rgb2lab(he);
    % size(lab_he)
    % protan
    LabColorChannelCB=2;
    if strcmp( whichTypeCB,'deutran')==1
        lab_he=ConvertContrast(lab_he,2,1,1);
    else
        LabColorChannelCB=3;
        lab_he=ConvertContrast(lab_he,3,1,1);
    end
    % lab_he=ConvertContrast(lab_he,3,0);
    % size(lab_he)
    
    % figure(figure_no)
    % subplot(1,2,1), imshow(he), title('Original');
    % subplot(1,2,2), imshow(applycform(lab_he,cform_lab),[]), title('After Contrast Change');
    % figure_no=figure_no+1;
    
    generatedImage{LimitOfUnknowingness,2}=[];
    for DontKnowWhyIteration=1:LimitOfUnknowingness
        clear segmented_images
        clear segmented_images_tmp
        %imshow(lab2rgb(lab_he));
        ab = double(lab_he(:,:,2:3));
        nrows = size(ab,1);
        ncols = size(ab,2);
        ab = reshape(ab,nrows*ncols,2);
        
        nColors = 2+DontKnowWhyIteration;
        % repeat the clustering 3 times to avoid local minima
        [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
            'Replicates',4);
        pixel_labels = reshape(cluster_idx,nrows,ncols);
        %figure
        %imshow(pixel_labels,[]), title('image labeled by cluster index');
        segmented_images = cell(1,nColors);
        rgb_label = repmat(pixel_labels,[1 1 3]);
        
        for k = 1:nColors
            color = he;
            color(rgb_label ~= k) = 0;
            segmented_images{k} = color;
        end
        
        % figure(1)
        % for i=1:nColors
        %     subplot(1,nColors,i),imshow(segmented_images{i}), title(sprintf('Original Cluster %d',i));
        % end
        segmented_images_tmp=segmented_images;
        clear postive_values;
        postive_values(nColors)=zeros;
        for i=1:nColors
            postive_values(i)=size(find(segmented_images{i}>0),1);
        end
        clear Index;
        [Value,Index] = sort(postive_values);
%         Index
        for i=1:nColors
            
            %[min_value1, index1] = min(postive_values);
            lab_segmented_images = segmented_images{Index(i)};
            %         if i~=nColors %optimize this later as only two are changed
%             if i==Index(2) && i~=nColors
                %                if strcmp( whichTypeCB,'deutran')==1
%                 segmented_images{Index(i)}=lab2rgb(ConvertContrast(rgb2lab(segmented_images{Index(i)}),LabColorChannelCB,1,Index(i)/nColors));
                %  
            if(i==Index(1))
                lab_segmented_images= IncreaseDecreaseChannel(lab_segmented_images(:,:,1),1);%Decrease L channel
                segmented_images{Index(i)}(:,:,1)=lab_segmented_images;
                %segmented_images{Index(i)}=lab2rgb(ConvertContrast(rgb2lab(segmented_images{Index(i)}),LabColorChannelCB,1,Index(i)/nColors));
            elseif(i==nColors)
%                   lab_segmented_images= IncreaseDecreaseChannel(lab_segmented_images(:,:,1),0);%Decrease L channel
%                   segmented_images{Index(i)}(:,:,1)=lab_segmented_images;
            elseif i==Index(2) %&& i~=nColors
                 segmented_images{Index(i)} = RotateColor(segmented_images{Index(i)},5);
            else
                segmented_images{Index(i)}=lab2rgb(ConvertContrast(rgb2lab(segmented_images{Index(i)}),LabColorChannelCB,1,Index(i)/nColors));
            end
            
            %else
%             if i<nColors/2
%                 lab_segmented_images= IncreaseDecreaseChannel(lab_segmented_images(:,:,1),1);%Increase L channel
%                 segmented_images{Index(i)}(:,:,1)=lab_segmented_images;
%             end
           
            %         else
            %             lab_segmented_images= IncreaseDecreaseChannel(lab_segmented_images(:,:,1),0);%Decrease L channel
            %             segmented_images{Index(i)}(:,:,1)=lab_segmented_images;
            %             segmented_images{Index(i)}=lab2rgb( ConvertContrast(rgb2lab(segmented_images{index1}),2,0));
            %segmented_images{Index(i)}=applycform(ConvertContrast(rgb2lab(segmented_images{Index(i)}),LabColorChannelCB,0),cform_lab);
            %         end
            %     if i==1
            %         segmented_images{Index(i)} = RotateColor(segmented_images{Index(i)},45);
            %     end
        end
        %     size(segmented_images{1})
        % postive_values = postive_values(postive_values~=min_value1);
        % [min_value2, index2] = min(postive_values);
        % lab_segmented_images = segmented_images{index2};
        % lab_segmented_images=IncreaseDecreaseChannel(lab_segmented_images(:,:,1),1);%Increase L channel
        % segmented_images{index2}(:,:,1)=lab_segmented_images;
        
        
        %segmented_images{index} = ConvertContrast(segmented_images{index},2,1);
        %segmented_images{index} = RotateColor(segmented_images{index},-45);
        % postive_values2 = postive_values(postive_values~=min);
        % [min, index2]=min(postive_values2);
        % segmented_images{index2} = ConvertContrast(segmented_images{index2},2,1);
        
        %figure
        %subplot(2,2,1), imshow(segmented_images{1}), title('objects in cluster 1');
        %subplot(2,2,2), imshow(segmented_images{2}), title('objects in cluster 2');
        %subplot(2,2,3), imshow(segmented_images{3}), title('objects in cluster 3');
        %subplot(2,2,4), imshow(he), title('Original Image');
        %imgAdjusted(:,:,1)=segmented_images{1};
        %imgAdjusted1=imadjust(imgAdjusted1,stretchlim(imgAdjusted1),[]);
        %imgAdjusted1 = RotateColor(imgAdjusted1,45);
        
        %imgAdjusted(:,:,2)=segmented_images{2};
        %imgAdjusted2=imadjust(imgAdjusted2,stretchlim(imgAdjusted2),[]);
        %imgAdjusted2 = RotateColor(imgAdjusted2,45);
        
        %imgAdjusted(:,:,3)=segmented_images{3};
        %imgAdjusted3=imadjust(imgAdjusted3,stretchlim(imgAdjusted3),[]);
        %imgAdjusted3 = RotateColor(imgAdjusted3,10);
        
        %%figure for original and change in segmentation
        figure(figure_no)
        fig = gcf;
        for i=1:nColors
            subplot(2,nColors,i),imshow(segmented_images_tmp{i}), title(sprintf('Original %d',i));
        end
        for i=nColors+1:nColors*2
            subplot(2,nColors,i),imshow(segmented_images{i-nColors}), title(sprintf('Transformed %d',i-nColors));
        end
        figure_no=figure_no+1;
        tightfig(fig);
        %%
        
        % options = {'falsecolor','Scaling','joint','ColorChannels',[2 1 2]};
        % if index1==1
        %     C = imfuse(segmented_images{3},segmented_images{2},'falsecolor','Scaling','joint','ColorChannels',[1 2 2]);
        % elseif index1==2
        %     C = imfuse(segmented_images{3},segmented_images{1},'falsecolor','Scaling','joint','ColorChannels',[1 2 2]);
        % elseif index1==3
        %     C = imfuse(segmented_images{1},segmented_images{2},'falsecolor','Scaling','joint','ColorChannels',[1 2 2]);
        % end
        % % C = imfuse(segmented_images{1},segmented_images{2},'falsecolor','Scaling','joint','ColorChannels',[2 1 2]);
        % C = imfuse(C,segmented_images{index1},'falsecolor','Scaling','joint','ColorChannels',[2 1 2]);
        %[rows columns] = find(segmented_images{index1} == 0);
        
        
        %C=JoinImages(segmented_images);
        
        % Join Images function code here
        for i=1:size(segmented_images,1)
            postive_values(i)=size(find(segmented_images{i}(:,:,:)~=0),1);
        end
        [max_value1, index1] = max(postive_values);
        %     fprintf('the main image is %d \n',index1);
        
        C=JoinImages(segmented_images);
        %     for i=1:nColors
        %         C=C+segmented_images{i};
        %     end
        %     C=C-segmented_images{i};
        %     for i=1:size(segmented_images,2)-1
        %         for j=1:size(segmented_images{i},1)
        %             for k=1:size(segmented_images{i},2)
        %                 for l=1:size(segmented_images{i},3)
        %                     if segmented_images{i}(j,k,l)~=0 && C(j,k,l)==0
        %                         C(j,k,l)=segmented_images{i}(j,k,l);
        %                     elseif segmented_images{i}(j,k,l)~=0 && C(j,k,l)~=0
        %                         C(j,k,l)=round((C(j,k,l)+segmented_images{i}(j,k,l))/2);
        %                     end
        %                 end
        %             end
        %         end
        %     end
        %
        generatedImage{DontKnowWhyIteration,1}=C;
        
        % figure(3)
        % imshow(JoinImages(segmented_images),[]);
        distanceOfImages=0;
        % quantitative metric
        % Z = imsubtract(he,C);
        % figure(4)
        % subplot(1,1,1), imshow(Z,[]), title('Quantitative Metric');
        C_lab = rgb2lab(C);
        for i=1:size(lab_he_original,1)
            for j=1:size(lab_he_original,2)
                for k=1:size(lab_he_original,3)
                    difference =(lab_he_original(i,j,k))-(C_lab(i,j,k));
                    %difference
                    distanceOfImages=double(distanceOfImages)+double(difference^2);
                end
            end
        end
        distanceOfImages=sqrt(double(distanceOfImages))/(size(lab_he_original,3)*size(lab_he_original,2)*size(lab_he_original,1));
        generatedImage{DontKnowWhyIteration,2}=distanceOfImages;
        fprintf('distance %f for %d segments\n',distanceOfImages,nColors);
        
        
        % figure(3)
        % subplot(1,2,1), imshow(he), title('Original Image');
        % subplot(1,2,2), imshow(rgb2lab(lab_he)), title('after Contrast Image');
        
        
    end
    
    [minImage minImageIndex]=min(cell2mat(generatedImage(:,2)));
    for i=1:size(generatedImage,1)
        if generatedImage{i,2}==minImage
            C=generatedImage{i,1};
            fprintf('segment case no %d  was effective \n',i);
            break;
        end
    end
    imwrite(C,sprintf('changedtritan%s',images{CurrentImageIndex}));
    figure(figure_no)
    fig=gcf;
    subplot(2,2,1), imshow(he,[]), title('Input Image');
    subplot(2,2,2), imshow(C,[]), title(sprintf('Transformed Image'));
    subplot(2,2,3), imshow(convertToDichromatImage(he,whichTypeCB),[]), title(sprintf('Original Image to %s',whichTypeCB));
    subplot(2,2,4), imshow(convertToDichromatImage(C,whichTypeCB),[]), title(sprintf('Transformed %s Image', whichTypeCB));
    figure_no=figure_no+1;
    tightfig(fig);
% end

% quantitative metric
Z = imsubtract(he,C);
figure(figure_no)
subplot(1,1,1), imshow(Z,[]), title('Subtracted Image');
figure_no=figure_no+1;
imwrite(Z,sprintf('subtract%s',images{CurrentImageIndex}));
% showHistogram(C,figure_no);
% figure_no=figure_no+1;
% showHistogram(he,figure_no);