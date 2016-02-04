function  scatterPlot( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    r = I(:,:,1);
    g = I(:,:,2);
    b = I(:,:,3);
    figure
    plot3(r(:),g(:),b(:),'.')
    grid('on')
    xlabel('Red (Band 3)')
    ylabel('Green (Band 2)')
    zlabel('Blue (Band 1)')
    title('Scatterplot of the Visible Bands')
end

