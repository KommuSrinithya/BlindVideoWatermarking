clc;
clear all;
close all;
[J P]=uigetfile('*.*','select the video File');
X=VideoReader(strcat(P,J));
NF=65;
V=read(X);
[K T]=uigetfile('*.*','select the Logo');
G=imread(strcat(T,K));
if size(G,3)>1
    G=rgb2gray(G);
end
GB=imresize(G,[64 64]);
GB=double(im2bw(GB));
GBB=reshape(GB,[1 64*64]);
%=========================================
t=1;k=64;
for ff=1:NF    
F1=V(:,:,:,ff);
F1=imresize(F1,[256 256]);
OV(:,:,:,ff)=F1;
if k<=(length(GBB))
%====      Embedding ====================
Y=rgb2ycbcr(F1);
[LL1 LH1 HL1 HH1]=inwavtras(double(Y(:,:,1)));
[LL2 LH2 HL2 HH2]=inwavtras(LL1);
[UHL2, SHL2]=schur(HL2);
SS=diag(SHL2)./100;
SE=uencode(SS,8);
SB=dec2bin(SE);
SB(:,8)=num2str(GBB(t:k)');
SD=bin2dec(SB);
SDE=udecode(uint8(SD),8)*100;
for ii=1:length(SDE)
SHL2(ii,ii)=SDE(ii);
end
MHL2=UHL2*SHL2*UHL2';
MLL1=myinvinwavtras(LL2,LH2,MHL2,HH2);
MY=myinvinwavtras(MLL1,LH1,HL1,HH1);
Y(:,:,1)=uint8(MY);
YW(:,:,:,ff)=(SDE);
FM=ycbcr2rgb(Y);
WV(:,:,:,ff)=FM;
t=k+1;
k=k+64;
[Ms rs(ff)]=Calc_MSE_PSNR(F1(:,:,1),FM(:,:,1));
else
WV(:,:,:,ff)=F1;

end
end
%===================================================
%=========== Extraction ============================

E=[];
for ff=1:size(YW,4)  
F2=YW(:,:,:,ff); 
SS1=F2;
SE1=uencode(SS1/100,8);
SB1=dec2bin(double(SE1));
E=[E; str2num(SB1(:,8))];
end
EE=reshape(E,[64 64]);
%==============================================
%========== Display =========================
mplay(OV);
mplay(WV);
figure,subplot(121),imshow(GB);title('Embedding Logo');
subplot(122),imshow(EE);title('Extracted Logo');

figure,stem(1:ff,rs,'k-x','Linewidth',2);grid on;
xlabel('--Frame Number');
ylabel('---PSNR');
