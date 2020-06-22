dec=[0 0 0 1 1 1 1 ;0 1 1 1 1 1 1 ;0 0 0 0 0 1 1 ;1 1 1 0 0 0 0;1 1 1 1 0 0 0;0 1 0 1 1 1 1;1 1 1 1 1 1 1];
imwrite(dec,'D:\study\cbivr\lab record\lab8-implementation of ccv\h.bmp');
J= imread('D:\study\cbivr\lab record\lab8-implementation of ccv\h.bmp');
I= imresize(J, 50);
I=im2bw(I);
imshow(I);
L = bwlabel(dec,8);
