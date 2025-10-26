clc;
clear all;
close all;
g=0;
h=0;
ruta=strcat("C:\Users\HP\OneDrive\upiita\SVA\Base_de_datos\Ref.png"); %Imagen a evaluar
f0=imread(ruta);
f1 = rgb2gray(f0);
f2 = f1 < 127;
[dist1,cx,cy] = Encadenado(f2);
a=5;
fex=f2;
fex((cy-a):(cy+a),(cx-a):(cx+a))=255;
fex(cy,cx)=0;
imshow(fex);

Tdist1=size(dist1);
Carpeta_raiz = "C:\Users\HP\OneDrive\upiita\SVA\Base_de_datos\";
elementos = dir(Carpeta_raiz);
esCarpeta = [elementos.isdir] & ~ismember({elementos.name}, {'.', '..'});
Base_datos_carpetas = {elementos(esCarpeta).name};


for N=1:length(Base_datos_carpetas)
    Imagen_actual=Base_datos_carpetas(N);
    ruta2=strcat(Carpeta_raiz + Base_datos_carpetas(N));
    archivosPNG = dir(fullfile(ruta2, '*.png'));
    nombresArchivosPNG = {archivosPNG.name};

    for IM=1:length(nombresArchivosPNG)
        ruta3=strcat(ruta2+"\"+nombresArchivosPNG(IM));
        f4=imread(ruta3);
        f5 = rgb2gray(f4);
        f6 = f5 < 127;
        dist2 = Encadenado(f6);
        Tdist2=size(dist2);
        
        if Tdist1(2)>Tdist2(2) 
            V1=dist1;
            V2=dist2;
        else
            V1=dist2;
            V2=dist1;
        end
        x_original = linspace(1, length(V1), length(V2));
        x_nuevo = 1:length(V1); 
        V2_interpolado = interp1(x_original, V2, x_nuevo, 'linear');                   
        
        r = corrcoef(V1,V2_interpolado);
        %disp(N);
        Res = (r(1,2));
    
        % % Imagen_actual
        % % Res
        if Res>=.7 || Res<=-.7
            g=g+1;
            resultados(g)=Res;
            Resultados(g)=string(Imagen_actual);
            for y=1:length(V2_interpolado)
                Plot_res(g,y)=V2_interpolado(y);
            end
            Resultados_ruta(g)=nombresArchivosPNG(IM);
            %figure, plot(V2_interpolado);
        end
    end
    
end

    Resultados
    [maximus,imaximus]=max(abs(resultados));
    disp(Resultados(imaximus));
    subplot(1,2,1);
    plot(dist1);
    title("Entrada");
    
    subplot(1,2,2);
    plot(Plot_res(imaximus,:));
    title(strcat("Resultado: " + Resultados(imaximus)));
    Resultados_ruta(imaximus)
    %figure,plot(V1);
