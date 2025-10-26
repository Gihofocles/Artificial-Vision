clc, close all, clear all;
f0=imread("ruta//");
f1=rgb2gray(f0);
f2=double(imnoise(f1,"salt & pepper"));

Filtros='pbgm';

t=3;
tipo='b';
f3=zeros(size(f2));

for N=1:length(Filtros)
    tipo=Filtros(N);
switch tipo
    case 'p'
        Filtro=(1/(t^2))*ones(t);
    case 'b'
        n=t-1;        %Fila
        r=2;          %Elemento
        for r=0:n
            nCr(r+1)=factorial(n)/(factorial(n-r)*factorial(r));
        end
        Filtro=(nCr'*nCr)/(sum(sum((nCr'*nCr))));
    case 'g'
        sig=1;
        for i=1:t
            for j=1:t
                Filtro(i,j)=exp(-((i-t/2-0.5)^2+(j-t/2-0.5)^2)/(sig^2));
            end
        end
        Filtro=Filtro/sum(sum(Filtro));
    otherwise
        Filtro=zeros(t);
end

[filas,columnas]=size(f2);

for i=(t+1)/2:filas-(t-1)/2
    for j=(t+1)/2:columnas-(t-1)/2
        V=f2(i-(t-1)/2:i+(t-1)/2,j-(t-1)/2:j+(t-1)/2);
        if tipo == 'm'
            f3(i,j)=median(V,"all");
        else
            f3(i,j)=sum(sum(V.*Filtro));
        end
    end
end
%imshow(uint8(f3));
figure, imshow(uint8(f3));
end