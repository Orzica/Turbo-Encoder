function [perioadaRepetitie]=Perioada_Repetitie( Secventa_Generata , m )

perioadaRepetitie=1;
b=reshape(Secventa_Generata(1:(m*floor(length(Secventa_Generata)/m))),m,floor(length(Secventa_Generata)/m))';
for i=2:length(b(:,1))
    if b(1,:)==b(i,:)
        break
    else
        perioadaRepetitie=perioadaRepetitie+1;
    end
end
end
