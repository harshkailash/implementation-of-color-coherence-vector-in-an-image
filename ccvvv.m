% D = 'D:\18bce1340\20images';%GETTING THE PATH TO THE DIRECTORY%
% S = dir(fullfile(D,'*.jpg'));%READING IMAGE NAMES%
I=imread('D:\study\cbivr\lab record\lab8-implementation of ccv\h.bmp');
I1=imread('D:\study\cbivr\lab record\lab8-implementation of ccv\h.bmp');
ccv=getCCV(I,0.01,2);
ccv1=getCCV(I1,0.01,2);



function [oneChannel, updatedNumC] = discretizeColors(img,numColors)
width = size(img,2);
height = size(img,1);
oneChannel = zeros(height,width);
% We have 3 channels. For each channel we have V unique values.
% So we want to find the value of V given that V x V x V ~= numColors
numOfBins = floor(pow2(log2(numColors)/3));
numOfBinsSQ = numOfBins*numOfBins;
img = floor((img/(256/numOfBins)));
for i=1:height
    for j=1:width
        oneChannel(i,j) = img(i,j,1)*numOfBinsSQ ...
            + img(i,j,2)*numOfBins + img(i,j,3);
    end
end
updatedNumC = power(numOfBins,3);
end
function CCV = getCCV(img,coherentPrec, numberOfColors)
    if ~exist('coherentPrec','var')
        coherentPrec = 1;
    end
    if ~exist('numberOfColors','var')
        numberOfColors = 27;
    end
    CCV = zeros(2,numberOfColors);
   
    Gaus = fspecial('gaussian',[5 5],2);
    img = imfilter(img,Gaus,'same');
   
    [img, updNumOfPix]= discretizeColors(img,numberOfColors);
   
    imgSize = (size(img,1)*size(img,2));
    thresh = int32((coherentPrec/100) *imgSize);
   
    parfor i=0:updNumOfPix-1
        BW = img==i;
        CC = bwconncomp(BW);
        compsSize = cellfun(@numel,CC.PixelIdxList);
        incoherent = sum(compsSize(compsSize>=thresh));
        CCV(:,i+1) = [incoherent; ...
            sum(compsSize) - incoherent];
    end
end