tritanimages={'changedtritancimage1.jpg','changedtritanwinnipeg.png','changedtritantokyo.jpg','changedtritanvan.jpg'};
deutranimages={'changedcimage1.jpg','changedwinnipeg.png','changedtokyo.jpg','changedvan.jpg'};
originalimages={'cimage1.jpg','winnipeg.png','tokyo.jpg','van.jpg'};
subtractimages={'subtractcimage1.jpg','subtractwinnipeg.png','subtracttokyo.jpg','subtractvan.jpg'};
% plots(size(images),2)=zeros;

% figure(1)
% fig = gcf;
% for ImageIndex=1:size(images,2)
%     plots(ImageIndex) = subplot(1,size(images,2),ImageIndex);
% %     tmp_image = imresize(imread(images{ImageIndex}),5);
%     imshow(imread(images{ImageIndex}),[]);%, text(1,1,images{ImageIndex});
% %      set(gca,'Position',[0 0 1 1])
% %     p = get(plots(ImageIndex), 'pos');
% %     p(3) = p(3) + 0.05;
% %     set(plots(ImageIndex), 'Position',  [ImageIndex*.1 .5 1 1]);
%     %text(5, 0.4, images{ImageIndex});
% end
% print -deps -r300 -s joined.eps
% tightfig(fig);

labels={'L Channel', 'a Channel','b channel'};
% Lab_original = rgb2lab(imread('tokyo.jpg'));
% Lab_changed = rgb2lab(imread('changedtokyo.jpg'));
figure_no=1;
% figure(figure_no)
% fig = gcf;
% for imageIndex=1:length(subtractimages)
%     subplot(1,length(subtractimages),imageIndex),imshow(imread(subtractimages{imageIndex}),[]),title(sprintf('Image %d',imageIndex));
% end
% tightfig(fig);
% figure_no=figure_no+1;

figure(figure_no)
fig = gcf;
index=1;
% for channel=1:3
imageIndex=4;
% for imageIndex=1:length(originalimages)
    for channelIndex=1:3
        tmp_original =imread(originalimages{imageIndex});
        tmp = rgb2lab(tmp_original);
        subplot(3,3,index),imshow(tmp(:,:,channelIndex),[]);
%         set(gca, 'Position', [0.5, 0.5, 0.5, 0.5]);
        index=index+1;
        tmp2 = convertToDichromatImage(tmp_original,'deutran');
        tmp2 = rgb2lab(tmp2);
        subplot(3,3,index),imshow(tmp2(:,:,channelIndex),[]);
%         set(gca, 'Position', [0.5, 0.5, 0.5, 0.5]);
        index=index+1;
        tmp3 = convertToDichromatImage(tmp_original,'tritan');
        tmp3 = rgb2lab(tmp3);
        subplot(3,3,index),imshow(tmp3(:,:,channelIndex),[]);
%         set(gca, 'Position', [0.5, 0.5, 0.5, 0.5]);
        index=index+1;
    end
    tightfig;
% end
% 
% channel=3;
%     for imageIndex=1:length(originalimages)
%         tmp =imread(originalimages{imageIndex});
%         tmp = rgb2lab(tmp);
%         subplot(3,4,index),imshow(tmp(:,:,channel),[]);%, text(1,1,images{ImageIndex});
%         index=index+1;
%     end
%     for imageIndex=1:length(originalimages)
%         tmp =imread(deutranimages{imageIndex });tmp = rgb2lab(tmp);
%         subplot(3,4,index),imshow(tmp(:,:,channel),[]);%, text(1,1,images{ImageIndex});
%         index=index+1;
%     end
%     for imageIndex=1:length(originalimages)
%         tmp =imread(tritanimages{imageIndex });tmp = rgb2lab(tmp);
%         subplot(3,4,index),imshow(tmp(:,:,channel),[]);%, text(1,1,images{ImageIndex});
%         index=index+1;
%     end



% end
% for labelIndex=1:length(labels)
%     for inageIndex=1:length(images)
%
%     subplot(2,3,labelIndex),imshow(Lab_original(:,:,labelIndex),[]),title(labels{labelIndex});%, text(1,1,images{ImageIndex});
%     end
% end
% for labelIndex=1:length(labels)
%     subplot(2,3,labelIndex+3),imshow(Lab_changed(:,:,labelIndex),[]);%, text(1,1,images{ImageIndex});
% end
% fig.PaperPositionMode = 'manual';
% tightfig(fig);

% print('lchannel','-depsc','-r300')
% for ImageIndex=1:size(images,2)
%     xl = xlim(plots(ImageIndex));
%     xPos = diff(xl)/4;
%      yl = ylim(plots(ImageIndex));
%     yPos = yl(1,2)+10;
%     %text(xPos, yPos, sprintf('%s', images{ImageIndex}),'FontSize',12,'Parent',plots(ImageIndex));
% end
%print('-f2','mySavedOutput2','-dpng', '-r300');