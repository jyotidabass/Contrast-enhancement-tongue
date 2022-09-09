clear
clc
close all;
%%
I=imread('WhatsApp Image 2022-01-28 at 12.13.58 - sumit sachdeva.jpeg');

I=rgb2gray(I);
HE = histeq(I);
CLAHE=adapthisteq(I);
figure,
subplot(1,2,1);
imshow(I), title('original image');
subplot(1,2,2);
imhist(I);title('Histogram')

figure,
subplot(1,2,1)
imshow(HE), title('HE');
subplot(1,2,2)
imhist(HE);title('Histogram')

figure,
subplot(1,2,1)
imshow(CLAHE), title('CLAHE');
subplot(1,2,2)
imhist(CLAHE);title('Histogram')
%% RMSHE
n=1;
Xm=mean(mean(I));
[count,num]=imhist(I);
Xg=sum(count.*num)/(numel(count)*numel(num));
E=Xm+(Xg-Xm)/2^n;
I1=find(I<E);
I2=find(I>=E);
temp=I;
temp(I2)=255;
HE1=histeq(temp);
temp2=I;
temp2(I1)=0;
HE2=histeq(temp2);
HE1(I2)=I(I2);
HE2(I1)=I(I1);
RMSHE=HE2;
figure,
subplot(1,2,1)
imshow(RMSHE), title('RMSHE');
subplot(1,2,2)
imhist(RMSHE);title('Histogram')
%% Hybrid
I1=find(I<E);
I2=find(I>=E);
temp=I;
temp(I2)=255;
claHE1=adapthisteq(temp);
temp2=I;
temp2(I1)=0;
claHE2=adapthisteq(temp2);
claHE1(I2)=I(I2);
claHE2(I1)=I(I1);
claRMSHE=claHE2;
figure,
subplot(1,2,1)
imshow(claRMSHE), title('claRMSHE');
subplot(1,2,2)
imhist(claRMSHE);title('Histogram')
%% Evaluation
PSNR_HE=psnr(I,HE)
PSNR_CLAHE=psnr(I,CLAHE)
PSNR_RMSHE=psnr(I,RMSHE)
PSNR_claRMSHE=psnr(I,claRMSHE)
disp('......................');
EME_HE=eme(HE)
EME_CLAHE=eme(CLAHE)
EME_RMSHE=eme(RMSHE)
EME_claRMSHE=eme(claRMSHE)
