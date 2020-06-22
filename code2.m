I=imread('D:\study\cbivr\lab record\lab8-implementation of ccv\h.bmp');
 
threshold = 128;
% i=rgb2gray(I);
i=i>threshold;
imshow(i)
 
L=bwlabel(i);
 
x=unique(L);
 
total=[x,histc(L(:),x)];
 
[r1,c1]=size(L);
 
for j=1:r1
    for k=1:c1
        if(L(j,k)==0)
            col1=i(j,k);
        
        elseif(L(j,k)==1)
            col2=i(j,k);
    end
        
    end
end
 
col=[col1,col2];
ccv(1,1)=0
ccv(1,2)=0
ccv(1,3)=0
ccv(2,1)=1
ccv(2,2)=0
ccv(2,3)=0
for j=1:length(x)
    if(col(j)==0)
        if(total(j,2)>3000)
            ccv(1,2)=ccv(1,2)+total(j,2)
        else
            ccv(1,3)=ccv(1,3)+total(j,2)
        end
    else
        if(total(j,2)>3000)
            ccv(2,2)=ccv(2,2)+total(j,2)
        else
            ccv(2,3)=ccv(2,3)+total(j,2)
        end
    end
end
