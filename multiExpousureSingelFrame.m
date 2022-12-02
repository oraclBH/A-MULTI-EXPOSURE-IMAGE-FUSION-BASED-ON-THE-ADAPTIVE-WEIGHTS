function  outIM = multiExpousureSingelFrame(inIM)

[m, n, ~] = size(inIM);
outIM = zeros(m,n);
alpha = 0.75;

im1 = inIM(:,:,1);
im2 = inIM(:,:,2);
im3 = inIM(:,:,3);

I_dlow = double(im1)/255;
I_d = double(im2)/255;
I_dhigh = double(im3)/255;

meanIlow = mean(I_dlow(:));
meanI = mean(I_d(:));
meanhigh = mean(I_dhigh(:));
deltn1= 2 * alpha*(meanI-meanIlow);
deltn2 =  alpha*(meanhigh-meanIlow);
deltn3 =  2 * alpha*(meanhigh-meanI);

histI = zeros(1,256);
histIlow = zeros(1,256);
histIhigh = zeros(1,256);

for i =1:m*n
     histIlow(im1(i)+1) = histIlow(im1(i)+1) +1;
     histI(im2(i)+1) = histI(im2(i)+1) +1;
     histIhigh(im3(i)+1) = histIhigh(im3(i)+1) +1;
end

histIlow = histIlow/m/n ;
histI = histI/m/n;
histIhigh = histIhigh/m/n ;

W11 = exp(-(I_dlow - (1-meanIlow)).^2/2/deltn1/deltn1);
W12  = exp(-(I_d - (1-meanI)).^2/2/deltn2/deltn2);
W13 = exp(-(I_dhigh - (1-meanhigh)).^2/2/deltn3/deltn3);

gradhistlow =  circshift(histIlow, 1);
gradhistlow(1) = 0;
gradhistlow = abs(histIlow - gradhistlow);
gradhistI =  circshift(histI, 1);
gradhistI(1) = 0;
gradhistI = abs(histI - gradhistI);
gradhistIhigh =  circshift(histIhigh, 1);
gradhistIhigh(1) = 0;
gradhistIhigh = abs(histIhigh - gradhistIhigh);


W21 = (1./(gradhistlow + eps)) ./(1./(gradhistlow+ eps)  + 1./(gradhistI+eps) + 1./(gradhistIhigh + eps));
W22 = (1./(gradhistI + eps)) ./(1./(gradhistlow+ eps)  + 1./(gradhistI+ eps)  + 1./(gradhistIhigh + eps));
W23 = (1./(gradhistIhigh + eps)) ./(1./(gradhistlow+ eps)  + 1./(gradhistI+ eps) + 1./(gradhistIhigh + eps));

for i = 1:m
    for j =1:n
        vl = im1(i,j);
        v = im2(i,j);
        vh = im3(i,j);
        wvl =  (W11(i,j)*W21(vl+1)) / (W11(i,j)*W21(vl+1)+ W12(i,j)*W22(v+1)  + W13(i,j)*W23(vh+1));
        wv =  ( W12(i,j)*W22(v+1)) / (W11(i,j)*W21(vl+1)  + W12(i,j)*W22(v+1)  + W13(i,j)*W23(vh+1));
        wvh =  (W13(i,j)*W23(vh+1)) / (W11(i,j)*W21(vl+1)  + W12(i,j)*W22(v+1)  + W13(i,j)*W23(vh+1));
        outIM(i,j) =( vl*wvl + v*wv + vh*wvh )/(wvl + wv + wvh);
    end
end
outIM(outIM>255) = 255;
outIM(outIM<0) = 0;

end













