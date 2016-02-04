tritanimages={'changedtritancimage1.jpg','changedtritanwinnipeg.png','changedtritantokyo.jpg','changedtritanvan.jpg'};
deutranimages={'changedcimage1.jpg','changedwinnipeg.png','changedtokyo.jpg','changedvan.jpg'};
originalimages={'cimage1.jpg','winnipeg.png','tokyo.jpg','van.jpg'};

for currentIndex=1:size(originalimages,2)
    distanceOfImages=0;
    distanceOfImagesMain=0;
    lab_he_original=rgb2lab(imread(originalimages{currentIndex}));
    C_lab = rgb2lab(imread(tritanimages{currentIndex}));
    lab_he_cb = rgb2lab(convertToDichromatImage(imread(tritanimages{currentIndex}),'deutran'));
    for i=1:size(lab_he_original,1)
        for j=1:size(lab_he_original,2)
            for k=1:size(lab_he_original,3)
                difference =(lab_he_original(i,j,k))-(C_lab(i,j,k));
                distanceOfImages=double(distanceOfImages)+double(difference^2);
                
                difference =(lab_he_original(i,j,k))-(lab_he_cb(i,j,k));
                distanceOfImagesMain=double(distanceOfImagesMain)+double(difference^2);
            end
        end
    end
    distanceOfImagesMain=sqrt(double(distanceOfImagesMain))/(size(lab_he_original,3)*size(lab_he_original,2)*size(lab_he_original,1));
    distanceOfImages=sqrt(double(distanceOfImages))/(size(lab_he_original,3)*size(lab_he_original,2)*size(lab_he_original,1));
    fprintf('for %d -- main dist %f , cb dist %f \r\n',currentIndex,distanceOfImages,distanceOfImagesMain);
end
