function [RI,xi,yi]=Centroide_imagen(RI)
    [filas,columnas]=size(RI);
    fxi=sum(RI,1);
    fyi=sum(RI,2);
    xi=1:columnas;
    yi=1:filas;
    
    xci=round(sum((xi.*fxi))/sum(fxi));
    yci=round(sum((yi.*fyi'))/sum(fyi'));
    xi=xci;
    yi=yci;
    xi=xi-columnas/2;
    yi=-yi+filas/2;
    RI=cruz(RI,yci,xci,20,1,[255,0,0]);

end