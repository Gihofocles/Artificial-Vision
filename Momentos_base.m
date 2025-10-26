function hus = Momentos_base(rut)
res=['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'X' 'Y' 'Z'];
hus=zeros(25,7);
    for N=1:25
        ruta=strcat(rut,num2str(N),".jpeg");
        f0=imread(ruta);
        f1=rgb2gray(f0);
        f2=(f1>115);
        img=f2;
        m00=Momento_Inercial(f2,0,0);
        m10=Momento_Inercial(f2,1,0);
        m01=Momento_Inercial(f2,0,1);
    
        xc=m10/m00;
        yc=m01/m00;
    
        [filas, columnas] = size(img);
        [X, Y] = meshgrid(1:columnas, 1:filas);
        x_bar = xc;
        y_bar = yc;
        
        mu_00 = sum(sum(img));
        mu_20 = sum(sum(((X - x_bar).^2) .* img));
        mu_02 = sum(sum(((Y - y_bar).^2) .* img));
        mu_11 = sum(sum(((X - x_bar) .* (Y - y_bar)) .* img));
        mu_30 = sum(sum(((X - x_bar).^3) .* img));
        mu_12 = sum(sum(((X - x_bar) .* (Y - y_bar).^2) .* img));
        mu_21 = sum(sum(((X - x_bar).^2 .* (Y - y_bar)) .* img));
        mu_03 = sum(sum(((Y - y_bar).^3) .* img));
    
        eta_20 = mu_20 / (mu_00^(2/2 + 1));
        eta_02 = mu_02 / (mu_00^(2/2 + 1));
        eta_11 = mu_11 / (mu_00^(2/2 + 1));
        eta_30 = mu_30 / (mu_00^(3/2 + 1));
        eta_12 = mu_12 / (mu_00^(3/2 + 1));
        eta_21 = mu_21 / (mu_00^(3/2 + 1));
        eta_03 = mu_03 / (mu_00^(3/2 + 1));
    
        hu(1) = eta_20 + eta_02;
        hu(2) = (eta_20 - eta_02)^2 + 4 * eta_11^2;
        hu(3) = (eta_30 - 3 * eta_12)^2 + (3 * eta_21 - eta_03)^2;
        hu(4) = (eta_30 + eta_12)^2 + (eta_21 + eta_03)^2;
        hu(5) = (eta_30 - 3 * eta_12) * (eta_30 + eta_12) * ...
                ((eta_30 + eta_12)^2 - 3 * (eta_21 + eta_03)^2) + ...
                (3 * eta_21 - eta_03) * (eta_21 + eta_03) * ...
                (3 * (eta_30 + eta_12)^2 - (eta_21 + eta_03)^2);
        hu(6) = (eta_20 - eta_02) * ((eta_30 + eta_12)^2 - ...
                (eta_21 + eta_03)^2) + 4 * eta_11 * (eta_30 + eta_12) * ...
                (eta_21 + eta_03);
        hu(7) = (3 * eta_21 - eta_03) * (eta_30 + eta_12) * ...
                ((eta_30 + eta_12)^2 - 3 * (eta_21 + eta_03)^2) - ...
                (eta_30 - 3 * eta_12) * (eta_21 + eta_03) * ...
                (3 * (eta_30 + eta_12)^2 - (eta_21 + eta_03)^2);
        hus(N,:)=hu;
    end
end
