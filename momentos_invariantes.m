clc, close all, clear all;

N=1;
for N=1:25
    ruta=strcat("C:\Users\HP\OneDrive\upiita\SVA\drive-download-20241016T234434Z-001\",num2str(N),".bmp");
    f0=imread(ruta);
    f1=rgb2gray(f0);
    f2=(f1<200);
    
    m00=Momento_Inercial(f2,0,0);
    m10=Momento_Inercial(f2,1,0);
    m01=Momento_Inercial(f2,0,1);

    xc=m10/m00
    yc=m01/m00

    u00=Momento_Central(f2,0,0,xc,yc);
    u02=Momento_Central(f2,0,2,xc,yc);
    u20=Momento_Central(f2,2,0,xc,yc);
    u11=Momento_Central(f2,1,1,xc,yc);
    
    n20=Momento_Normalizado(u20,u00,2,0);
    n02=Momento_Normalizado(u02,u00,0,2);
    n11=Momento_Normalizado(u11,u00,1,1);

    phi1=n20+n02
    phi2=((n20-n02)^2)+4*n11

    subplot(5,5,N)
    imshow(f0);
    title(num2str(phi2));
    Res(N)=ruta;
    RES(N)=phi2;
end

