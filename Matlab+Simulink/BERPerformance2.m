SNRdB = -1 : 0.5 : 4;                 
SNR = 10.^(SNRdB/10);
NoIter = [3 6 10 14 18];

ber = zeros ( length(SNRdB) , length(NoIter) );

data.trellis = poly2trellis(3, [7 5], 7);
data.BlockLength = 1024;
data.InterleaverIndices=randperm(data.BlockLength);

R   = data.BlockLength / (3 * data.BlockLength + 4 * 3);

linie_SNR=1;
coloana_iter=1;
SNRindex=1;

for j=1:length(NoIter)
    
    for i=SNRdB
        
        data.RSZ = i;
        data.NoIter = NoIter(j);
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

semilogy(SNRdB,ber(:,1),'k--','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,2),'m-o','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,3),'b-<','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,4),'r-<','linewidth',2.0);
hold on
semilogy(SNRdB,ber(:,5),'c-x','linewidth',2.0);



title('Performatele decodorului Turbo/ canal BPSK/ variatii SNR/ Nr. Iteratii ');
xlabel('SNR(dB)');ylabel('BER');
legend('3 Iter','6 Iter','10 Iter','14 Iter','18 Iter');
grid on
xlim ([-2 5]);