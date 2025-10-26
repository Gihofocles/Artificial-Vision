clc, close all, clear all;
R=0;
G=0;
B=0;
C=1;
VID = VideoReader("C:\Users\super\OneDrive\upiita\Semestres cursados\7 semestre\SVA\SVAT19\SVAT19.mp4");
Nf = floor(VID.Duration * VID.FrameRate);

filename = 'SVAT19_resultado.mp4';
if isfile(filename)
    delete(filename);
end
i=1;
while hasFrame(VID)
    f=readFrame(VID);
    F(:,:,:,i) = f;
    i=i+1;
end

[FILAS,COLUMNAS,CAPAS,TIEMPO]=size(F);
i=1;
j=1;
for T=1:TIEMPO
    for i=1:FILAS
        for j=1:COLUMNAS
            if F(i,j,C,T)<150
                f2(i,j)=0;
            else
                f2(i,j)=1;
            end
        end
    end
    fx=sum(f2,1);
    fy=sum(f2,2);
    
    x=[1:COLUMNAS];
    y=[1:FILAS];

    xc=round(sum((x.*fx))/sum(fx));
    yc=round(sum((y.*fy'))/sum(fy'));

    F(yc,xc,1,T)=R;
    F(yc,xc,2,T)=G;
    F(yc,xc,3,T)=B;

    F(yc+1,xc-1,1,T)=R;
    F(yc+1,xc-1,2,T)=G;
    F(yc+1,xc-1,3,T)=B;

    F(yc-1,xc+1,1,T)=R;
    F(yc-1,xc+1,2,T)=G;
    F(yc-1,xc+1,3,T)=B;

    F(yc-1,xc-1,1,T)=R;
    F(yc-1,xc-1,2,T)=G;
    F(yc-1,xc-1,3,T)=B;

    F(yc+1,xc+1,1,T)=R;
    F(yc+1,xc+1,2,T)=G;
    F(yc+1,xc+1,3,T)=B;

    F(yc,xc+1,1,T)=R;
    F(yc,xc+1,2,T)=G;
    F(yc,xc+1,3,T)=B;

    F(yc+1,xc,1,T)=R;
    F(yc+1,xc,2,T)=G;
    F(yc+1,xc,3,T)=B;

    F(yc,xc-1,1,T)=R;
    F(yc,xc-1,2,T)=G;
    F(yc,xc-1,3,T)=B;

    F(yc-1,xc,1,T)=R;
    F(yc-1,xc,2,T)=G;
    F(yc-1,xc,3,T)=B;

    F(yc,xc+2,1,T)=R;
    F(yc,xc+2,2,T)=G;
    F(yc,xc+2,3,T)=B;

    F(yc+2,xc,1,T)=R;
    F(yc+2,xc,2,T)=G;
    F(yc+2,xc,3,T)=B;

    F(yc,xc-2,1,T)=R;
    F(yc,xc-2,2,T)=G;
    F(yc,xc-2,3,T)=B;

    F(yc-2,xc,1,T)=R;
    F(yc-2,xc,2,T)=G;
    F(yc-2,xc,3,T)=B;

    PX(T)=xc;
    PY(T)=yc;
    f3(:,:,T)=f2(:,:);
end

dt=.5;
for L=2:length(PX)
    Vx(L)=(PX(L)-PX(L-1))/dt;
    Vy(L)=(PY(L)-PY(L-1))/dt;
end
for L=2:length(Vx)
    Ax(L)=(Vx(L)-Vx(L-1))/dt;
    Ay(L)=(Vy(L)-Vy(L-1))/dt;
end

subplot(3,1,1);
plot(PX,'k');
title('Posición X');
subplot(3,1,2);
plot(Vx,'r');
title('Velocidad X');
subplot(3,1,3);
plot(Ax,'b');
title('Aceleración X');

figure
subplot(3,1,1);
plot(PY,'k');
title('Posición Y');
subplot(3,1,2);
plot(Vy,'r');
title('Velocidad Y');
subplot(3,1,3);
plot(Ay,'b');
title('Aceleración Y');

figure
plot(PX,PY,'k');
title('Desplazamiento');

xlim([0, max(PX)]);
ylim([0, max(PY)]);
ax = gca;
ax.XAxisLocation = 'bottom'; 
ax.YAxisLocation = 'left';


OVID = VideoWriter('SVAT19_resultado.mp4', 'MPEG-4');
OVID.FrameRate = 24;
open(OVID);
for k = 1:T
    writeVideo(OVID,F(:,:,:,k));
end
close(OVID);
