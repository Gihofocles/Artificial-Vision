function npq=Momento_Normalizado(upq,u00,p,q)
    if p+q>=2
        gamma=((p+q)/2)+1;
    else
        gamma=1;
    end
    npq=upq/(u00^gamma);
end