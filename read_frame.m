function A=read_frame(name,i)
    A=double(rgb2gray(imread(sprintf('./%s/%s%0.5d.bmp',name,name,i))));
end