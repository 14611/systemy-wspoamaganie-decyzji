% 1. Definicja zmiennych (liczba sztuk każdego posiłku)
var int: owoce;
var int: frytki;
var int: salatka;
var int: skrzydelka;
var int: paluszki;
var int: zestaw_probny;

% 2. Ograniczenia: Liczby nie mogą być ujemne
constraint owoce >= 0;
constraint frytki >= 0;
constraint salatka >= 0;
constraint skrzydelka >= 0;
constraint paluszki >= 0;
constraint zestaw_probny >= 0;

% 3. Główne równanie kosztów
constraint 215 * owoce + 
           275 * frytki + 
           335 * salatka + 
           355 * skrzydelka + 
           420 * paluszki + 
           580 * zestaw_probny = 1505;

% 4. Polecenie szukania rozwiązania
solve satisfy;

% 5. Czytelny format wyniku
output ["Owoce: \(owoce), Frytki: \(frytki), Sałatka: \(salatka), Skrzydełka: \(skrzydelka), Paluszki: \(paluszki), Zestaw: \(zestaw_probny)"];