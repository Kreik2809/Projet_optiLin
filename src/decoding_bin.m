% Decode a binary vector into a sentence

function [mess,y] = decoding_bin(x,d)

x = max(x,0);
x = min(x,1); 
x = round(x); 
k = 1; 
for i = 1 :  length(x)/d
  for j = 1 : d
    y(i,j) = dec2bin(x(k)); k = k + 1; 
  end
end
mess = char(bin2dec(y))'; 