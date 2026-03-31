include "alldifferent.mzn";

% kolorowanie wierzchołków grafu

int: n_nodes = 5; % liczba wierzchołków
int: m = 6;       % liczba krawędzi
int: k = 3;       % maks liczba dostępnych kolorów

array[1..m, 1..2] of int: edges =
[| 1, 2
 | 1, 5
 | 2, 3
 | 3, 4
 | 4, 5
 | 5, 3
|];

array[1..n_nodes] of var 1..k: nodes; % kolor każdego wierzchołka
var 1..n_nodes: colorsNumber;          % minimalna liczba użytych kolorów

constraint
  colorsNumber = max(nodes) /\
  % dla każdej krawędzi: sąsiednie wierzchołki muszą mieć różne kolory
  forall(i in 1..m) (nodes[edges[i,1]] != nodes[edges[i,2]]);

solve minimize colorsNumber;

output
  ["Liczba kolorów: " ++ show(colorsNumber) ++ "\n"] ++
  ["Wierzchołek " ++ show(i) ++ " -> kolor " ++ show(fix(nodes[i])) ++ "\n"
   | i in 1..n_nodes];
