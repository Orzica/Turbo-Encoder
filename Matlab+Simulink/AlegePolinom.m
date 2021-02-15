function [Polinom , Seed , p , m]=AlegePolinom(BlockLength)
%% Date intrare
listOptions={'min','max','all'};
f=listdlg('ListString',listOptions,...
    'ListSize',[350 75],...
    'PromptString',{'OPT = min  find one primitive polynomial of minimum weight.',...
    'OPT = max  find one primitive polynomial of maximum weight.',...
    'OPT = all  find all primitive polynomials.',''},...
    'SelectionMode','Single');
if f==1
    opt='min';
elseif f==2
    opt='max';
elseif f==3
    opt='all';
end

Primes=primes(150);
Primes(Primes<BlockLength)=[];
listPrimes=cell(1,length(Primes));
for i=1:length(Primes)
    listPrimes(:,i)={num2str(Primes(i))}; 
end

l=listdlg('ListString',listPrimes,...
    'ListSize',[175 175],...
    'PromptString',{'Lista numere prime.',...
    'Toate numerele vor fi in GF(P)'},...
    'SelectionMode','Single');

p=Primes(l);

listGrad={'3','4','5'};
g=listdlg('ListString',listGrad,...
    'ListSize',[250 75],...
    'PromptString',{'Gradul polinomului primitiv'},...
    'SelectionMode','Single');
if g==1
    m=3;
elseif g==2
    m=4;
elseif g==3
    m=5;
end

Seed=randi([1 p-1],[1 m]);


%% Alegere polinom primitiv / Generare polinoame primitive in functie de datele de intrare

if (strcmp(opt,'min')==1 || strcmp(opt,'max')==1)
    c = gfprimfd(m,opt,p);
    if m==3
        Polinom=[c(1) c(2) c(3) c(4)];
        msgbox({'Polinomul ales este : ' ; [num2str(c(1)) '*x^0 + ' num2str(c(2)) '*x^1 + '...
            num2str(c(3)) '*x^2 + ' num2str(c(4)) '*x^3']});
    end
    
    if m==4
        Polinom=[c(1) c(2) c(3) c(4) c(5)];
        msgbox({'Polinomul ales este : ' ; [num2str(c(1)) '*x^0 + ' num2str(c(2)) '*x^1 + '...
            num2str(c(3)) '*x^2 + ' num2str(c(4)) '*x^3 + ' num2str(c(5)) '*x^4']});
    end
    if m==5
        Polinom=[c(1) c(2) c(3) c(4) c(5) c(6)];
        msgbox({'Polinomul ales este : ' ; [num2str(c(1)) '*x^0 + ' num2str(c(2)) '*x^1 + '...
            num2str(c(3)) '*x^2 + ' num2str(c(4)) '*x^3 + ' num2str(c(5)) '*x^4 + ' num2str(c(5)) '*x^6']});
    end
end

if (strcmp(opt,'all')==1)
    c = gfprimfd(m,opt,p);
    list=cell(1,length(c(:,1)));
    if m==3
        for i=1:length(c(:,1))
            list(:,i)={[num2str(c(i,1)) '*x^0 + ' num2str(c(i,2)) '*x^1 + ' num2str(c(i,3)) '*x^2 + ' num2str(c(i,4)) '*x^3']};
        end
        coeficient=listdlg('PromptString',{'Polinoamele generate sunt :' },...
            'ListString',list,...
            'ListSize',[200 300],...
            'SelectionMode','Single');
        
        Polinom=c(coeficient,:);
    end
    if m==4
        for i=1:length(c(:,1))
            list(:,i)={[num2str(c(i,1)) '*x^0 + ' num2str(c(i,2)) '*x^1 + ' num2str(c(i,3)) '*x^2 + ' num2str(c(i,4)) '*x^3 + ' num2str(c(i,5)) '*x^4']};
        end
        coeficient=listdlg('PromptString',{'Polinoamele generate sunt :' },...
            'ListString',list,...
            'ListSize',[250 300],...
            'SelectionMode','Single');
        
        Polinom=c(coeficient,:);
    end
    if m==5
        for i=1:length(c(:,1))
            list(:,i)={[num2str(c(i,1)) '*x^0 + ' num2str(c(i,2)) '*x^1 + ' num2str(c(i,3)) '*x^2 + '...
                num2str(c(i,4)) '*x^3 + ' num2str(c(i,5)) '*x^4 + ' num2str(c(i,6)) '*x^5']};
        end
        coeficient=listdlg('PromptString',{'Polinoamele generate sunt :' },...
            'ListString',list,...
            'ListSize',[300 300],...
            'SelectionMode','Single');
        
        Polinom=c(coeficient,:);
    end
end
end