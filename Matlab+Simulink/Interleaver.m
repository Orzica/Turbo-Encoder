%% Date Intrare
prompt = {'Introdu lungimea datelor de intrare'};
dlgtitle = 'Date';
definput = {'64'};
answer = inputdlg(prompt,dlgtitle,[1 40],definput);

BlockLength=str2double(answer{1});

Date=1:BlockLength;
%% Matrix Interleaver
a=floor(sqrt(BlockLength));
b=floor(BlockLength/a);

if BlockLength>a*b
   b=b+1;
end
%% GFn Interleaver
[Polinom , Seed , p , m]=AlegePolinom(BlockLength);
if m==3
    sim('Grad3')
end
if m==4
    sim('Grad4')
end
if m==5
    sim('Grad5')
end
if p~=2
Index=nonzeros(unique(Secventa_Generata,'stable'))';
end
if p==2
Index=unique(Secventa_Generata,'stable')'+1;
end
Index(Index>BlockLength)=[];

perioadaRepetie=Perioada_Repetitie( Secventa_Generata , m );
msgbox({'Perioada de repetitie a polinomului este : ' num2str(perioadaRepetie)});
%% Rulare Simulink + Distanta Minima
sim('Intretesatoare');

dm_GFn=DistantaMinima(GFn);
dm_Matrix=DistantaMinima(Matrix);
dm_Random=DistantaMinima(Random);
%% Plot
figure;
subplot(311)
stem(Date,nonzeros(Matrix));
title( 'Matrix Interleaver' );
xlabel( 'Indice vector' ); ylabel( 'Valoare vector' );
axis tight; grid on;
subplot(312)
stem(Date,Random);
title( 'Random Interleaver' );
xlabel( 'Indice vector' ); ylabel( 'Valoare vector' );
axis tight; grid on;
subplot(313)
stem(Date,GFn);
title( 'GFn Interleaver' );
xlabel( 'Indice vector' ); ylabel( 'Valoare vector' );
axis tight; grid on;
msgbox({'Distanta minima : ',['Random GFn Interleaver : ' num2str(dm_GFn)],...
    ['Random Interleaver : ' num2str(dm_Random)],['Matrix Interleaver : ' num2str(dm_Matrix)]});