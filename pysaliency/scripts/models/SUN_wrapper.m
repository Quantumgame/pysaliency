% created by Aykut Erdem
% adapted by Matthias Kuemmerer for pysaliency

function [ ] = SUN(filename, outname, scale)

    addpath('saliency')

    img = imread(filename);
	img = ensure_image_is_color_image(img);
	% submodel names are without the decimal separator, i.e. 'scale05' for a scale of 0.5'
	%scale_string = sprintf('%s.%s', submodel(6), submodel(7:end));
	%scale = str2num(scale_string);
    %disp(sprintf('Doing scale %f', scale));
    salmap = saliencyimage(img,scale);
    salmap = imresize(salmap,1/scale, 'nearest');
    height = size(salmap,1);
    width = size(salmap,2);
    ydiff = size(img,1)-size(salmap,1);
    xdiff = size(img,2)-size(salmap,2);
    ydiff = round(ydiff/ 2);
    xdiff = round(xdiff/ 2);
    saliency_map = ones(size(img,1),size(img,2))*min(salmap(:));
    saliency_map(ydiff+1:ydiff+height,xdiff+1:xdiff+width) = salmap;
    save(outname, 'saliency_map');
