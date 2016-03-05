close all;
clear all;
clc;

% a=imread('test.jpg');

% R=a(:,:,1);
% G=a(:,:,2);
% B=a(:,:,3);
% R=double(R);
% G=double(G);
% B=double(B);
% [s v d]=svd(R);
% re1=s(:,:)*v(:,1:140)*d(:,1:140)';
% [s v d]=svd(G);
% re2=s(:,:)*v(:,1:140)*d(:,1:140)';
% [s v d]=svd(B);
% re3=s(:,:)*v(:,1:140)*d(:,1:140)';
% a(:,:,1)=re1;
% a(:,:,2)=re2;
% a(:,:,3)=re3;

I_rgb = imread('test.jpg');
figure(1);
imshow(I_rgb,'border','tight','InitialMagnification','fit');
title('原始图像');

%将彩色图像从RGB转化到lab色彩空间
C = makecform('srgb2lab');%设置转换格式
I_lab = applycform(I_rgb, C);

%进行K-means聚类对图像进行分割
ab = double(I_lab(:,:,2:3));%取出lab空间的a分量和b分量
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;  %分割的区域个数,可进行修改
[cluster_center,cluster_idx,mindist,q2,quality] = kmeanss(ab,nColors,2)
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure(2);
imshow(pixel_labels,[],'border','tight','InitialMagnification','fit');
title('聚类结果');

%显示分割后的各个区域
dst = cell(1,nColors);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = I_rgb;
    
    color(rgb_label ~= k) = 0;
    dst{k} = color;
end
for i=1:nColors
figure(i+2);
imshow(dst{i});
title('分割结果');
end 