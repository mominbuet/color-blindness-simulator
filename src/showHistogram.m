function  showHistogram( I,I2,figure_no)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    figure(figure_no)
    subplot(1,3,1), imhist(I(:,:,1)),imhist(I2(:,:,1))
    title('Red Band')
    subplot(1,3,2), imhist(I(:,:,2))
    title('Green Band')
    subplot(1,3,3), imhist(I(:,:,3))
    title('Blue Band')

end

