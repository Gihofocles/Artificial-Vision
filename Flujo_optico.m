clc, clear all, close all
N=2;

for N=2:49
rutaf=strcat("C:\Users\HP\OneDrive\upiita\SVA\FLUJO OPTICO\FLUJO 1\" + num2str(N) + ".jpg");
rutai=strcat("C:\Users\HP\OneDrive\upiita\SVA\FLUJO OPTICO\FLUJO 1\" + num2str(N-1) + ".jpg");
Ff=double(rgb2gray(imread(rutaf)));
Fi=double(rgb2gray(imread(rutai)));

[filas,columnas]=size(Ff);

for i=2:filas
    for j=2:columnas
        Dx(i,j)=Ff(i,j)-Ff(i,j-1);
        Dy(i,j)=Ff(i,j)-Ff(i-1,j);
        Dt(i,j)=Ff(i,j)-Fi(i,j);%entre frames;
    end
end

% figure,imshow(uint8(Dx));
% figure,imshow(uint8(Dy));
% figure,imshow(uint8(Dt));

TV=21;
LV=(TV-1)/2;
in=LV+1;

cx=0;
cy=0;
for i=in:TV:filas-LV
    cy=cy+1;
    cx=0;
    for j=in:TV:columnas-LV
        cx=cx+1;
        px(cy,cx)=j;
        py(cy,cx)=i;

        Fx=Dx(i-LV:i+LV,j-LV:j+LV);
        Fy=Dy(i-LV:i+LV,j-LV:j+LV);
        Ft=Dt(i-LV:i+LV,j-LV:j+LV);
        A=[sum(sum(Fx.*Fx))  sum(sum(Fx.*Fy)) 
           sum(sum(Fx.*Fy))  sum(sum(Fy.*Fy))];

        B=-[sum(sum(Ft.*Fx))  
            sum(sum(Ft.*Fy))];

        V=inv(A'*A)*A'*B;
        u(cy,cx)=V(1,1);
        v(cy,cx)=V(2,1);
    end
end
imshow(uint8(Ff));
hold on
quiver(px,py,u,v,'Y');
hold off;
exportgraphics(gca,strcat("C:\Users\HP\OneDrive\upiita\SVA\FLUJO OPTICO\FLUJO 1\Nueva carpeta)"+num2str(N)+".jpg"));
drawnow
end
