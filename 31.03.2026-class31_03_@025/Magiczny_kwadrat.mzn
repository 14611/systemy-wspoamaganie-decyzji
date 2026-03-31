include "alldifferent.mzn";

% Magiczny kwadrat
% suma wierszy = suma kolumn = suma przekątnych = magic_sum
% każda liczba od 1 do n^2 pojawia się dokładnie raz

int: n = 3;
int: n2 = n * n;
int: magic_sum = n * (n2 + 1) div 2; % = 15 dla n=3

array[1..n, 1..n] of var 1..n2: square;

% każda liczba od 1 do n^2 dokładnie raz
constraint alldifferent([square[i,j] | i, j in 1..n]);

% suma każdego wiersza = magic_sum
constraint forall(i in 1..n) (sum(j in 1..n)(square[i,j]) = magic_sum);

% suma każdej kolumny = magic_sum
constraint forall(j in 1..n) (sum(i in 1..n)(square[i,j]) = magic_sum);

% suma przekątnej głównej (lewy górny -> prawy dolny) = magic_sum
constraint sum(i in 1..n)(square[i,i]) = magic_sum;

% suma przekątnej pobocznej (prawy górny -> lewy dolny) = magic_sum
constraint sum(i in 1..n)(square[i, n-i+1]) = magic_sum;

solve satisfy;

output [
  show(fix(square[i,j])) ++ if j == n then "\n" else " " endif
  | i, j in 1..n
];
