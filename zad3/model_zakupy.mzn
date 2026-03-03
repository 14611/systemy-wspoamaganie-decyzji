% --- DEKLARACJE DANYCH WEJŚCIOWYCH ---
enum Posilek;                   % Nazwy posiłków zostaną wczytane z zewnątrz
array[Posilek] of int: ceny;    % Ceny zostaną wczytane z zewnątrz
int: budzet;                    % Kwota zostanie wczytana z zewnątrz

% --- ZMIENNE DECYZYJNE ---
% Szukamy tablicy ilości 'x', gdzie każda wartość jest >= 0
array[Posilek] of var 0..100: ilosc;

% --- OGRANICZENIA (CONSTRAINTS) ---
% Suma (cena_i * ilosc_i) musi być równa budżetowi
constraint sum(p in Posilek) (ceny[p] * ilosc[p]) = budzet;

% --- CEL ---
solve satisfy;

% --- FORMATOWANIE WYNIKU ---
output [
    "--- Zamówienie ---\n"
] ++ [
    show(p) ++ ": " ++ show(ilosc[p]) ++ " szt.\n" 
    | p in Posilek where fix(ilosc[p]) > 0
] ++ [
    "------------------\n",
    "Łączny koszt: " ++ show(sum(p in Posilek) (ceny[p] * ilosc[p]))
];