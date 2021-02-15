data.SNRdB = -1 : 0.5 : 4;
data.NoIter = 6;
data.BlockLength = 4096;

data.trellis = poly2trellis(3, [7 5], 7);

Date=(1:data.BlockLength);


InterleaverIndicesRandom = randperm(data.BlockLength);

a=floor(sqrt(data.BlockLength));
b=floor(data.BlockLength/a);

if data.BlockLength>a*b
    b=b+1;
end

sim('BERPerform')

Matrix=nonzeros(Matrix);
Matrix=Matrix';

InterleaverIndicesBloc = Matrix;

ber = zeros ( length(data.SNRdB) , 2 );

linie_SNR=1;

R   = data.BlockLength / (3 * data.BlockLength + 4 * 3);

data.InterleaverIndices=InterleaverIndicesRandom;

for j = 1:length(data.SNRdB)
    
    data.NoiseVar = 1 ./ (2 * R * 10 .^( data.SNRdB(j) / 10 ));
    sim('DECODER');
    ber( linie_SNR , 1 ) = BER(1);
    
    linie_SNR = linie_SNR + 1;
    
end

data.InterleaverIndices=Matrix;

linie_SNR=1;
j=1;

for j = 1:length(data.SNRdB)
    
    data.NoiseVar = 1 ./ (2 * R * 10 .^( data.SNRdB(j) / 10 ));
    sim('DECODER');
    ber( linie_SNR , 2 ) = BER(1);
    
    linie_SNR = linie_SNR + 1;
    
end

semilogy(data.SNRdB,ber(:,1),'k--','linewidth',2.0);
hold on
semilogy(data.SNRdB,ber(:,2),'m-o','linewidth',2.0);

title('Performatele decodorului Turbo/ canal BPSK/ Tip Interleaver ');
xlabel('SNR(dB)');ylabel('BER');
legend('RandomInterleaver','MatrixInterleaver');
grid on
xlim ([-2 5]);