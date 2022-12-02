clc; clear; close all; warning off;

%基于反映相对像素强度和全局梯度的自适应权值的多曝光图像融合 

I_low = imread('cathedralA.jpg');
figure,subplot(221)  
imshow(uint8(I_low)),title('low-light-image')

I= imread('cathedralC.jpg');
I = cat(3, I, I, I);
subplot(222), imshow(uint8(I)),title('mid-light-image')
 
I_high= imread('cathedralB.jpg');
subplot(223), imshow(uint8(I_high)),title('high-light-image')

outIM = zeros(size(I));
for i =1:3
    outIM(:,:,i) = multiExpousureSingelFrame(cat(3, I_low(:,:,i), I(:,:,i), I_high(:,:,i)));
end
subplot(224), imshow(uint8(outIM)),title('multi-fusion-image')












