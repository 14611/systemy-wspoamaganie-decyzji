% Magiczna seria
% magic[i] = liczba wystąpień wartości (i-1) w tablicy magic
%
% Przykład dla len=4: magic = [1, 2, 1, 0]
%   magic[1]=1  -> liczba 0 występuje 1 raz  ✓ (tylko magic[4]=0)
%   magic[2]=2  -> liczba 1 występuje 2 razy ✓ (magic[1]=1, magic[3]=1)
%   magic[3]=1  -> liczba 2 występuje 1 raz  ✓ (magic[2]=2)
%   magic[4]=0  -> liczba 3 występuje 0 razy ✓

int: len = 5;
array[1..len] of var 0..len: magic;

constraint
  % suma wszystkich elementów musi równać się len
  sum(i in 1..len)(magic[i]) = len /\
  % magic[i] = ile razy wartość (i-1) pojawia się w tablicy
  forall(i in 1..len) (
    magic[i] = sum(j in 1..len)(bool2int(magic[j] == i - 1))
  );

solve satisfy;

output [
  "Magiczna seria (len=" ++ show(len) ++ "): " ++ show(magic) ++ "\n" ++
  "Sprawdzenie:\n"
] ++
[
  "  magic[" ++ show(i) ++ "]=" ++ show(fix(magic[i])) ++
  " -> liczba " ++ show(i-1) ++ " wystepuje " ++ show(fix(magic[i])) ++ " razy\n"
  | i in 1..len
];
