% 1. Definicja danych (łatwo tu dopisać nowe pozycje)
enum Posilek = { Owoce, Frytki, Salatka, Skrzydelka, Paluszki, Zestaw_Probny };
array[Posilek] of int: ceny = [215, 275, 335, 355, 420, 580];

int: cel = 1505;

% 2. Zmienna decyzyjna: ile sztuk każdego posiłku kupujemy
% Od razu ograniczamy zakres do liczb nieujemnych (0..100)
array[Posilek] of var 0..100: ilosc;

% 3. Warunek: Suma (cena * ilosc) musi równać się celowi
constraint sum(p in Posilek) (ceny[p] * ilosc[p]) = cel;

% 4. Rozwiązanie
solve satisfy;

% 5. Czytelny format wyjściowy
output [ show(p) ++ ": " ++ show(ilosc[p]) ++ "\n" | p in Posilek ] ++
       ["--- \nSuma: " ++ show(sum(p in Posilek) (ceny[p] * ilosc[p]))];