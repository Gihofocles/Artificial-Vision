function [dist,cx,cy]=Encadenado(f2)
    [filas,columnas]=size(f2);
    x=1:columnas;
    fx=sum(f2,1);
    y=1:filas;
    fy=sum(f2,2)';
    cx=round(sum((x.*fx)/sum(fx)));
    cy=round(sum((y.*fy)/sum(fy)));
    %f2((cy-a):(cy+a),(cx-a):(cx+a))=1;
    for i=1:filas
        for j=1:columnas
            if f2(i,j)==1
                break;
            end
        end
        if f2(i,j)==1
                break;
            end
    end
    dir= [3 2 1;
          4 0 8;
          5 6 7];
    
    
    n=0;
    while 1
        V=f2(i-1:i+1,j-1:j+1);
        f2(i,j)=0;
        n=n+1;
        dist(n)=sqrt((cx-j)^2+(cy-i)^2);
        d=max(max(dir.*V));
        switch(d)
            case 1
                i=i-1;
                j=j+1;
            case 2
                i=i-1;
            case 3
                i=i-1;
                j=j-1;
            case 4
                j=j-1;
            case 5
                i=i+1;
                j=j-1;
            case 6
                i=i+1;
            case 7
                i=i+1;
                j=j+1;
            case 8
                j=j+1;
            otherwise
                break;
        end
    end
end