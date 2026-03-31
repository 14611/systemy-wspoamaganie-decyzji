include "alldifferent.mzn";

% Sudoku

int: S = 3;                           % rozmiar małego kwadratu (3x3)
int: N = S * S;                       % rozmiar planszy (9x9)
set of int: PuzzleRange = 1..N;
set of int: BlockRange  = 1..S;

% Plansza startowa: 0 = puste pole
array[1..N, 1..N] of 0..N: board =
[| 5,3,0, 0,7,0, 0,0,0
 | 6,0,0, 1,9,5, 0,0,0
 | 0,9,8, 0,0,0, 0,6,0
 | 8,0,0, 0,6,0, 0,0,3
 | 4,0,0, 8,0,3, 0,0,1
 | 7,0,0, 0,2,0, 0,0,6
 | 0,6,0, 0,0,0, 2,8,0
 | 0,0,0, 4,1,9, 0,0,5
 | 0,0,0, 0,8,0, 0,7,9
|];

array[1..N, 1..N] of var PuzzleRange: puzzle;

constraint
  % przepisz podane liczby z planszy wejściowej
  forall(r, c in PuzzleRange) (
    if board[r,c] > 0 then puzzle[r,c] = board[r,c] else true endif
  ) /\
  % różne wartości w każdym wierszu
  forall(r in PuzzleRange) (alldifferent([puzzle[r, c] | c in PuzzleRange])) /\
  % różne wartości w każdej kolumnie
  forall(c in PuzzleRange) (alldifferent([puzzle[r, c] | r in PuzzleRange])) /\
  % różne wartości w każdym bloku 3x3
  forall(br, bc in 0..S-1) (
    alldifferent([puzzle[br*S + i, bc*S + j] | i, j in BlockRange])
  );

solve satisfy;

output [
  show(fix(puzzle[r, c])) ++
  if c mod S == 0 /\ c != N then " " else "" endif ++
  if c == N then
    if r mod S == 0 /\ r != N then "\n\n" else "\n" endif
  else " " endif
  | r in PuzzleRange, c in PuzzleRange
];
