
function f3 = visorrecta2(f0, m, b)
    f3 = f0;
    [filas, columnas, ~] = size(f3);

    % Caso 1: Pendiente baja, recorrer en función de x
    if abs(m) <= 1
        xr = 1:0.1:columnas;
        yr = m * xr + b;
        for l = 1:length(xr)
            if xr(l) >= 1 && xr(l) <= columnas && yr(l) >= 1 && yr(l) <= filas
                f3(round(yr(l)), round(xr(l)), :) = [0, 255, 0]; % Línea verde
            end
        end
    else
        % Caso 2: Pendiente alta, recorrer en función de y
        yr = 1:0.1:filas;
        xr = (yr - b) / m;
        for l = 1:length(yr)
            if xr(l) >= 1 && xr(l) <= columnas && yr(l) >= 1 && yr(l) <= filas
                f3(round(yr(l)), round(xr(l)), :) = [0, 255, 0]; % Línea verde
            end
        end
    end

    imshow(f3);
end


