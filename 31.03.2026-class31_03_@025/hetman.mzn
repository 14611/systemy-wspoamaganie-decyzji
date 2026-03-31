include "alldifferent.mzn";

int: N = 8; % rozmiar szachownicy
array[1..N] of var 1..N: rows;
% rows[i] = numer wiersza, w którym stoi hetman w kolumnie i
% np. rows = [4, 2, 7, ...] -> w kolumnie 1 hetman w wierszu 4, itd.

constraint
  % żadnych dwóch hetmanów nie może być w tym samym wierszu
  alldifferent(rows) /\
  % żadnych dwóch hetmanów nie może być na tej samej przekątnej "\"
  alldifferent([rows[i] + i | i in 1..N]) /\
  % żadnych dwóch hetmanów nie może być na tej samej przekątnej "/"
  alldifferent([rows[i] - i | i in 1..N]);

solve satisfy;

output [
  if fix(rows[i]) == j then "H" else "." endif ++
  if j == N then "\n" else " " endif
  | i in 1..N, j in 1..N
];
