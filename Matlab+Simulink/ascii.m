
binary=de2bi(([(48:57) (65:90) (97:122)]),8,'left-msb');
chara=char([(48:57)  (65:90) (97:122)]');
hex=binaryVectorToHex(de2bi(([(48:57) (65:90) (97:122)]),8,'left-msb'));

dateCodate=zeros(62,32);

for i=1:length(binary(:,1))
    sim('turboEncoder.slx');
    dateCodate(i,:)=simout;
end

dateCodate=binaryVectorToHex(dateCodate(:,(1:24)));
dateCodate1=[cellstr(chara(1:31,:)) cellstr(num2str(binary(1:31,:))) hex(1:31,:) dateCodate(1:31,:)];
dateCodate2=[cellstr(chara(32:62,:)) cellstr(num2str(binary(32:62,:))) hex(32:62,:) dateCodate(32:62,:)];

T1 = table([{'Char','Binary','Hex','Encoded'} ; dateCodate1]);
T2 = table([{'Char','Binary','Hex','Encoded'} ; dateCodate2]);
T=table([T1{:,1} T2{:,1}]);
writetable(T,'TurboCode.xlsx','WriteVariableNames',false);