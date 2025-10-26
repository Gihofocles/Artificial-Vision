function upq=Momento_Central(f2,p,q,xc,yc)

    [filas,columnas]=size(f2);
    
    for y=1:filas
        for x=1:columnas
            MPQ(y,x)=((x-xc)^p)*((y-yc)^q)*f2(y,x);
        end
    end
    upq=sum(sum(MPQ));
end