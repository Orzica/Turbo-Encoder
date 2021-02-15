function [x]=DistantaMinima(si)
    si=nonzeros(si)';
    BlockLength=length(si);
    s=1:BlockLength;

    d=zeros(BlockLength,BlockLength);

    for i=1:length(si)
        for j=1:length(si)
            if i~=j
                d(i,j)=abs(s(i)-s(j))+abs(si(i)-si(j));
            end
        end
    end
    d=d(~(eye(size(d))));
    x=min(d);
end





