function mpq=Momento_Inercial(f2,p,q)

    [filas,columnas]=size(f2);
    
    for y=1:filas
        for x=1:columnas
            MPQ(y,x)=(x^p)*(y^q)*f2(y,x);
        end
    end
    mpq=sum(sum(MPQ));
end