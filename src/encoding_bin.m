% Encode a sentence into a binary vector 

function [x,d] = encoding_bin(mess)

xi = dec2bin(mess+0); 
[m,d] = size(xi); 
x = []; 
for i = 1 : m
    x = [x; double(xi(i,:)')-48];
end