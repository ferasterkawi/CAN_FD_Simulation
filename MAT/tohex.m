clear all
clc
MatSDIn = '1881ABBA0x0E0x000xFF0x220x0E0xFA0xDD0x51'
txID = MatSDIn(1:8)
i = 1;
for j=9:4:37
var(i,:) = MatSDIn(j+2:j+3);
i = i+1;
end
var
vard = hex2dec(var)
txIDd = hex2dec(txID)
vard = vard'
vards = num2str(vard,'%03d')
txIDds = num2str(txIDd)
MatSDOut = [txIDds,vards]