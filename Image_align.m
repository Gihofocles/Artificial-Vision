clc, clear all, close all

% Rutas de las imágenes
ruta = strcat("C:\Users\HP\Downloads\pf6.jpg");
ruta2 = strcat("C:\Users\HP\Downloads\pf67.jpg");

f0 = imread(ruta2);
f1 = imread(ruta);
f3 = f0;
f5=f0;
gray1 = im2gray(f0);
gray2 = im2gray(f1);

% Detectar bordes
edges1 = edge(double(gray1), 'Canny', [0.1 0.2], 1);
edges2 = edge(double(gray2), 'Canny', [0.1 0.2], 1);

% Procesar la primera imagen
stats = regionprops(edges1, 'Area','Orientation');
[~, largestIdx] = max([stats.Area]);
singleEdge = ismember(edges1, largestIdx);
f0 = singleEdge;
se = strel('disk', 3);
f0 = imclose(f0, se);

% Procesar la segunda imagen
stats = regionprops(edges2, 'Area','Orientation');
[~, largestIdx] = max([stats.Area]);
singleEdge = ismember(edges2, largestIdx);
f1 = singleEdge;
se = strel('disk', 3);
f1 = imclose(f1, se);

% Obtener coordenadas del borde
[dist1, cx, cy] = Encadenado(f0);

grayImg = f0;
shiftedImg = zeros(size(grayImg), 'uint8');
[filas, columnas] = size(gray2);

% Desplazamiento en píxeles
horizontalShift = cx % Desplazamiento hacia la derecha
verticalShift = cy     % Desplazamiento hacia abajo

% Realizar el desplazamiento
shiftedImg = imtranslate(grayImg, [horizontalShift, verticalShift]);
shiftedImg2 = imtranslate(f3, [horizontalShift, verticalShift]);
% Rotación
f3=shiftedImg2;
f4 = f3;
Res1=0;
for i = 1:360
    rotationAngle = i;
    rotatedImg = imrotate(shiftedImg, rotationAngle, 'bilinear', 'crop');
    f3 = f4;
    
    for j = 1:filas
        for k = 1:columnas
            if rotatedImg(j, k) > 0
                f3(j, k) = rotatedImg(j, k);
            end
        end
    end
    
    [H1, theta1, ~] = hough(f0);
[H2, theta2, ~] = hough(rotatedImg);

% Encontrar picos en la transformada de Hough
peaks1 = houghpeaks(H1, 1); % Obtener el ángulo dominante de img1
peaks2 = houghpeaks(H2, 1); % Obtener el ángulo dominante de img2

% Convertir índices de picos a ángulos
angle1 = theta1(peaks1(:, 2)); % Ángulo dominante de img1
angle2 = theta2(peaks2(:, 2)); % Ángulo dominante de img2

% Calcular la diferencia de ángulos
stats1 = regionprops(f0, 'Centroid', 'Orientation');
stats2 = regionprops(rotatedImg, 'Centroid', 'Orientation');
angleDifference = abs(angle1 - angle2);
orientation1 = stats1.Orientation; % Orientación de la primera imagen
orientation2 = stats2.Orientation; % Orientación de la segunda imagen
or=abs(orientation1 - orientation2);

        if angleDifference==0 && or<=100
            Ang=i;
        end
        imshow(f3);
        title(strcat(num2str(angleDifference),"    ",num2str(or),"     ",num2str(i)));
        drawnow

end





rotationAngle = Ang;
    horizontalShift = -cx % Desplazamiento hacia la derecha
verticalShift = -cy     % Desplazamiento hacia abajo
shiftedImg = imtranslate(shiftedImg, [horizontalShift, verticalShift]);
    rotatedImg = imrotate(shiftedImg, rotationAngle, 'bilinear', 'crop');
    imshow(rotatedImg);
    for j = 1:filas
        for k = 1:columnas
            if rotatedImg(j, k) > 0
                f5(j, k,:) =[255,0,0];
            end
        end
    end



% Realizar el desplazamiento


  figure, imshow(f5)