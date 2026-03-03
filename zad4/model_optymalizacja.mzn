% --- DANE ---
enum Posilek;
array[Posilek] of int: ceny;
array[Posilek] of int: yumyum;
int: budzet;

% --- ZMIENNE ---
array[Posilek] of var 0..10: ilosc; % Ograniczenie do 10 sztuk dla realizmu

% --- OGRANICZENIA ---
% Łączny koszt musi być DOKŁADNIE równy budżetowi (lub <= budzet, zależnie od interpretacji)
constraint sum(p in Posilek) (ceny[p] * ilosc[p]) = budzet;

% --- CEL: MAKSYMALIZACJA SMAKU ---
% Obliczamy całkowitą smakowitość: suma (ilość_sztuk * punkty_smaku)
var int: calkowity_smak = sum(p in Posilek) (ilosc[p] * yumyum[p]);

solve maximize calkowity_smak;

% --- WYNIK ---
output [
    "=== NAJPYSZNIEJSZE ZAMÓWIENIE ===\n"
] ++ [
    show(p) ++ ": " ++ show(ilosc[p]) ++ " szt. (Smak: " ++ show(ilosc[p] * yumyum[p]) ++ ")\n"
    | p in Posilek where fix(ilosc[p]) > 0
] ++ [
    "---------------------------------\n",
    "Łączny koszt: " ++ show(sum(p in Posilek) (ceny[p] * ilosc[p])) ++ "\n",
    "Łączny YumYum Factor: " ++ show(calkowity_smak)
];