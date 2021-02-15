SNRdB = -1 : 0.5 : 4;
NoIter = [3 6];
BlockLength = [128 4096];

ber = zeros ( length(SNRdB) , length(NoIter) * length(BlockLength) );

linie_SNR = 1;
coloana_iter = 1;
SNRindex = 1;

data.trellis = poly2trellis(3, [7 5], 7);

for z = 1 : length(BlockLength)
    
    data.BlockLength = BlockLength(z);
    data.InterleaverIndices = randperm(data.BlockLength);
    R   = data.BlockLength / (3 * data.BlockLength + 4 * 3);
    
    for j = 1 : length(NoIter)
        
        data.NoIter = NoIter(j);
        
        for i = SNRdB
            
            data.RSZ = i;
            data.NoiseVar = 1 ./ (2 * R * 10 .^( SNRdB(SNRindex) / 10 ));
            sim('DECODER');
            ber( linie_SNR , coloana_iter ) = BER(1);
            
            linie_SNR = linie_SNR + 1;
            SNRindex = SNRindex + 1;
            
        end
        
        linie_SNR = 1;
        SNRindex = 1;
        coloana_iter = coloana_iter+1; 
        
    end
    
end

figure;
semilogy(SNRdB,ber(:,1),'k--','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,2),'m-o','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,3),'b-<','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,4),'r-<','linewidth',2.0);


title('Performatele decodorului Turbo/ canal BPSK/ variatii SNR/ Bloc Intrare/ Nr. Iteratii ');
xlabel('SNR(dB)');ylabel('BER');
legend('N=128 3 Iter','N=128 6 Iter','N=4096 3 Iter','N=4096 6 Iter');
grid on
xlim ([-2 5]);