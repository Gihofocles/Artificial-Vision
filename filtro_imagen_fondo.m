function IMAD1 =filtro_imagen_fondo(IMAD,u)
    IMAD;
    IMAD1=IMAD;
    IMAD_hsv = rgb2hsv(IMAD);
    %IMAI_hsv = rgb2hsv(IMAI);
    IMAD_filtro = uint8(255*(IMAD_hsv(:,:,2)));
    imshow(IMAD_filtro);
    [filas,columnas]=size(IMAD_filtro);
    
    FiltroD=zeros(filas,columnas,3);
    for i=1:filas
        for j=1:columnas
            if IMAD_filtro(i,j)<=u
                IMAD1(i,j,:)=0;            
            end
        end
    end
    IMAD1;
end