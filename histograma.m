clc, close all, clear all;
i=4;
ruta=strcat('C:\Users\HP\OneDrive\upiita\SVA\SVA06\',num2str(i),'.jpg');
IMA1=imread(ruta);
IMA=imcrop(IMA1);

R=IMA(:,:,1);
G=IMA(:,:,2);
B=IMA(:,:,3);

HSV=rgb2hsv(IMA);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);

HistoR = svahistograma1(R);
HistoG = svahistograma1(G);
HistoB = svahistograma1(B);

HistoH = svahistograma1(uint8(H*255));
HistoS = svahistograma1(uint8(S*255));
HistoV = svahistograma1(uint8(V*255));

figure
hold on
plot(HistoR,'r');
plot(HistoG,'g');
plot(HistoB,'b');
hold off
figure
hold on
plot(HistoH,'m');
plot(HistoS,'y');
plot(HistoV,'k');
hold off
figure, imshow(IMA);


