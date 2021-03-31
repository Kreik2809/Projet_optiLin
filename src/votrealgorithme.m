% Votre algorithme pour résoudre 
% 
%   min_{0 <= xprime <= 1} ||A*xprime - yprime||_1 

function xprime = votrealgorithme(A,yprime)

% !!! Ecrivez votre code ici !!! 

yprime = yprime'; %On prend la transposée de yprime

%On crée le vecteur objectif
cprime = zeros(size(A,2),1); %On remplit de 0 pour chaque coefficient x

c2prime = ones(size(A,1),1); %On remplit de 1 pour chaque coefficient t

c = cat(1,c2prime, cprime);

%On crée le vecteur de contrainte
Aprime = [];
count = 1;
for i=1:(2*size(A,1))%Au total on aura 2 contrainte par ligne de la matrice A
    if (mod(i,2) == 0)
      Aprime(i, count) = -1;
      Aprime(i-1, count) = -1;
      count = count + 1;
    endif;
  endfor;

lineCount = 1;
for x=1:size(A,1)
  for y=1:size(A,2) %On ajoute au vecteur de contraintes les coefficient de A
    Aprime(lineCount, size(A,1)+y) = A(x, y);
    Aprime(lineCount+1, size(A,1)+y) = -A(x,y);
    endfor;
  lineCount = lineCount + 2;
  endfor;


%On crée le vecteur B
Bprime = []
rowCount = 1;
for i=1:size(yprime,2)
  Bprime(1, rowCount) = yprime(1, i);
  Bprime(1,rowCount+1) = -yprime(1, i);
  rowCount = rowCount + 2;
  endfor
 
%On crée le vecteur de bornes supérieur
ubPrime = [];
for i=1:(size(A,1))
  ubPrime(i)=Inf;
  endfor
ub2Prime = [];
for i=1:(size(A,2))
  ub2Prime(i)=1;
endfor
ub = (horzcat(ubPrime, ub2Prime))

%On crée un tableau pour spécifier le sens des inégalités
charArray = [];
for i=1:(2*size(A,1))
  charArray(i) = "U";
  endfor
charArray = char(charArray);


%On crée un tableau pour spécifier le type des variables
%Ici on n'impose pas de variables binaires
typeArray = [];
%for i=1:(size(A,1)+size(A,2))
  %typeArray(i) = "C";
%endfor;

%Ici on impose des variables binaires
for i=1:(size(A,1))
  ubPrime(i)="I";
  endfor
ub2Prime = [];
for i=1:(size(A,2))
  ub2Prime(i)="I";
endfor
typeArray = char(typeArray);
  
x = glpk(c, Aprime, Bprime, zeros(size(A,2)+size(A,1),1), ub,
 charArray, typeArray, 1);
 
for i=size(A,1) : size(A,1)+size(A,2)
  xprime(i) = x(i)
endfor;

 




