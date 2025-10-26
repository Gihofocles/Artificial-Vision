clc, close all, clear all;
cam=webcam(1);
IMA=snapshot(cam);
resultado='';
figure
while true
        resultado='';
        IMA=snapshot(cam);
        IMAH=rgb2gray(IMA);
        IMAH2=(IMAH<110);
        % letra = Idef_letra(IMAH2);
        Columnas=5;
        Filas=Columnas;

        IMAH3=bwareaopen(IMAH2,50);
        [labeledImage, numObjects] = bwlabel(IMAH3);
        if numObjects==0
            numObjects=1;
        end

        for i=1:numObjects
            objectMask = labeledImage == i;
            letra = Idef_letra(objectMask);
            resultado = strcat(resultado, letra);
            subplot(Filas,Columnas,i);
            imshow(objectMask);
            title(letra);
        end
        subplot(Filas,Columnas,numObjects+1);
        imshow(IMA);
        title('Imagen original');
        subplot(Filas,Columnas,numObjects+2);
        imshow(IMAH2);
        title('Imagen binarizada');
        disp(resultado);
        drawnow
        clf
        
 end

