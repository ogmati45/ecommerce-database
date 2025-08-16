/* Tabela Klienci */

-- Liczba unikalnych zarejestrowanych klientów (bez konta gościa o ID 0)
SELECT Plec, COUNT(DISTINCT ID_Klienta) AS "Liczba klientow" FROM Klienci WHERE Plec IS NOT NULL GROUP BY Plec ORDER BY COUNT(DISTINCT ID_Klienta) DESC;

-- Liczba unikalnych klientów wg miast zamieszkania (bez konta gościa o ID 0)
SELECT Miasto, COUNT(DISTINCT ID_Klienta) AS "Liczba klientow" FROM Klienci WHERE Miasto IS NOT NULL GROUP BY Miasto ORDER BY COUNT(DISTINCT ID_Klienta) DESC;

-- Liczba unikalnych klientów wg statusu konta (z kontem gościa o ID 0 - jako Niezarejestrowany)
SELECT Status_konta, COUNT(DISTINCT ID_Klienta) AS "Liczba klientow" FROM Klienci WHERE Status_konta IS NOT NULL GROUP BY Status_konta ORDER BY COUNT(DISTINCT ID_Klienta) DESC;

-- Liczba unikalanych klientów wg roku zarejestrowania (bez konta gościa o ID 0)
SELECT YEAR(Data_rejstracji) AS ROK, COUNT(DISTINCT ID_Klienta) AS "Liczba klientow" FROM Klienci WHERE YEAR(Data_rejstracji) IS NOT NULL GROUP BY YEAR(Data_rejstracji) ORDER BY YEAR(Data_rejstracji) DESC;

-- Liczba unikalnych klientów wg newslettera (bez konta gościa o ID 0)
SELECT CASE WHEN Newsletter = 1 THEN 'TRUE' ELSE 'FALSE' END AS Newsletter, COUNT(DISTINCT ID_Klienta) AS "Liczba klientow" FROM Klienci WHERE Newsletter IS NOT NULL GROUP BY Newsletter ORDER BY COUNT(DISTINCT ID_Klienta) DESC;

-- Średnia wieku klientów (bez konta gościa o ID 0)
SELECT AVG(Wiek) AS "Sredni wiek klientow" FROM Klienci WHERE Wiek IS NOT NULL;


/* Tabela Płatności */

-- Liczba wydanych FV wg pracownika + Imie + Nazwisko (JOIN)
SELECT Platnosci.ID_Pracownika, Pracownicy.Imie, Pracownicy.Nazwisko, COUNT(DISTINCT ID_Platnosci) AS "Liczba zamowien" FROM Platnosci JOIN Pracownicy ON Platnosci.ID_Pracownika = Pracownicy.ID_Pracownika GROUP BY Platnosci.ID_Pracownika, Pracownicy.Imie, Pracownicy.Nazwisko ORDER BY COUNT(DISTINCT ID_Platnosci) DESC;

-- Liczba płatności wg statusu płatności
SELECT Status_platnosci, COUNT(DISTINCT ID_Platnosci) AS "Liczba platnosci" FROM Platnosci GROUP BY Status_platnosci ORDER BY COUNT(DISTINCT ID_Platnosci) DESC;

-- Liczba płatności wg metody płatności
SELECT Metoda_platnosci, COUNT(DISTINCT ID_Platnosci) AS "Liczba platnosci" FROM Platnosci GROUP BY Metoda_platnosci ORDER BY COUNT(DISTINCT ID_Platnosci) DESC;

-- Podsumowanie płatności – średnie ceny, rabaty i liczba zamówień wg statusu
SELECT Status_platnosci, ROUND(AVG(Cena_poczatkowa), 2) AS "Srednia cena poczatkowa", CONCAT(ROUND(AVG(Rabat) * 100, 2), '%') AS "Sredni rabat", ROUND(AVG(Cena_koncowa), 2) AS "Srednia cena koncowa", COUNT(DISTINCT ID_Platnosci) AS "Liczba platnosci" FROM Platnosci GROUP BY Status_platnosci ORDER BY COUNT(DISTINCT ID_Platnosci) DESC;

-- Liczba platnosci wg poziomu rabatu
SELECT CONCAT(Rabat * 100, '%') AS "Rabat (%)", COUNT(DISTINCT ID_Platnosci) AS "Liczba platnosci" FROM Platnosci GROUP BY Rabat ORDER BY Rabat DESC;

-- Zestawienie metod i statusów płatności z liczbą unikalnych platnosci
SELECT Metoda_platnosci, Status_platnosci, COUNT(DISTINCT ID_Platnosci) FROM Platnosci GROUP BY Metoda_platnosci, Status_platnosci ORDER BY Metoda_platnosci, Status_platnosci ASC, COUNT(DISTINCT ID_Platnosci) DESC;

-- Roczne zestawienie liczby płatności
SELECT YEAR(Data_platnosci) AS ROK, COUNT(DISTINCT ID_Platnosci) AS "Liczba platnosci" FROM Platnosci GROUP BY YEAR(Data_platnosci) ORDER BY YEAR(Data_platnosci) DESC;


/* Tabela Pozycje Zamowien */

-- Zestawienie najlepiej sprzedających się produktów
SELECT Pozycje_zamowien.ID_Produktu, Produkty.Nazwa, Produkty.Pojemnosc, Produkty.Jednostka, Produkty.Producent, SUM(Pozycje_zamowien.Ilosc) AS "Ilosc sprzedanych (szt)" FROM Pozycje_zamowien JOIN Produkty ON Pozycje_zamowien.ID_Produktu = Produkty.ID_Produktu GROUP BY Pozycje_zamowien.ID_Produktu, Produkty.Nazwa, Produkty.Pojemnosc, Produkty.Jednostka, Produkty.Producent ORDER BY SUM(Pozycje_zamowien.Ilosc) DESC;

-- Różnorodność produktów w zamówieniach
SELECT ID_Zamowienia, COUNT(DISTINCT ID_Produktu) AS "Liczba unikalnych produktow" FROM Pozycje_zamowien GROUP BY ID_Zamowienia ORDER BY COUNT(DISTINCT ID_Produktu) DESC;

-- TOP zamówienia wg wartości przed rabatem
SELECT ID_Zamowienia, SUM(CENA) AS "Kwota zamowienia - bez rabatu" FROM Pozycje_zamowien GROUP BY ID_Zamowienia ORDER BY SUM(CENA) DESC;


/* Tabela Pracownicy */

-- Demografia zatrudnionych wg płci
SELECT Plec, COUNT(DISTINCT ID_Pracownika) AS "Liczba pracownikow" FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' GROUP BY Plec ORDER BY COUNT(DISTINCT ID_Pracownika) DESC;

-- Status zatrudnienia – liczba pracowników
SELECT Status_pracownika, COUNT(DISTINCT ID_Pracownika) AS "Liczba pracowników" FROM Pracownicy GROUP BY Status_pracownika ORDER BY COUNT(DISTINCT ID_Pracownika) DESC;

-- Średnie wynagrodzenia zatrudnionych wg płci
SELECT Plec, ROUND(AVG(Wynagrodzenie), 2) AS "Srednie wynagrodzenie" FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' GROUP BY Plec ORDER BY AVG(Wynagrodzenie) DESC;

-- Najwyzsze i najnizsze wynagrodzenie pracowników (Zatrudnionych)
(SELECT ID_Pracownika, Imie, Nazwisko, Plec, Dzial, Wynagrodzenie, 'Najw. wynagrodzenie' AS Pozycja FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' ORDER BY Wynagrodzenie DESC LIMIT 1)
UNION
(SELECT ID_Pracownika, Imie, Nazwisko, Plec, Dzial, Wynagrodzenie, 'Najn. wynagrodzenie' AS Pozycja FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' ORDER BY Wynagrodzenie ASC LIMIT 1);

-- TOP 10 najlepiej zarabiających zatrudnionych
SELECT RANK() OVER (ORDER BY Wynagrodzenie DESC) AS 'Miejsce', ID_Pracownika, Imie, Nazwisko, Dzial, Wynagrodzenie FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' LIMIT 10;

-- Podział zatrudniony pracowników wg działu
SELECT Dzial, COUNT(DISTINCT ID_Pracownika) AS "Liczba pracownikow" FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' GROUP BY Dzial ORDER BY COUNT(DISTINCT ID_Pracownika) DESC;

-- Srednie wynagrodzenie zatrudnionych wg dzialu
SELECT Dzial, ROUND(AVG(Wynagrodzenie), 2) AS "Srednie wynagrodzenie" FROM Pracownicy WHERE Status_pracownika = 'Zatrudniony' GROUP BY Dzial ORDER BY AVG(Wynagrodzenie) DESC;

-- Demografia pracowników wg płci i statusu zatrudnienia
SELECT Plec, Status_pracownika, COUNT(DISTINCT ID_Pracownika) AS "Liczba pracownikow" FROM Pracownicy GROUP BY Plec,Status_pracownika ORDER BY Plec, Status_pracownika ASC;


/* Tabela Produkty */

-- Liczba produktow wg producenta
SELECT Producent, COUNT(DISTINCT ID_Produktu) AS "Liczba produktow" FROM Produkty GROUP BY Producent ORDER BY COUNT(DISTINCT ID_Produktu) DESC;

-- Średnie ceny i marża wg producenta
SELECT Producent, ROUND(AVG(Cena_netto), 2) AS "Srednia cena netto", ROUND(AVG(Cena_brutto), 2) AS "Srednia cena brutto", CONCAT(ROUND(AVG(Marza)*100, 2), '%') AS "Srednia marza" FROM Produkty GROUP BY Producent ORDER BY AVG(Marza) DESC;

-- Statusy produktów per producent (posortowane po liczbie aktywnych)
SELECT Producent, SUM(CASE WHEN Status_produktu = 'Aktywny' THEN 1 ELSE 0 END) AS "Aktywne produkty",  SUM(CASE WHEN Status_produktu = 'Nieaktywny' THEN 1 ELSE 0 END) AS "Nieaktywne produkty" FROM Produkty GROUP BY Producent ORDER BY Producent ASC, `Aktywne produkty` ASC;

-- Rozkład produktów wg jednostki miary
SELECT Jednostka, COUNT(DISTINCT ID_Produktu) AS "Liczba produktow" FROM Produkty GROUP BY Jednostka ORDER BY `Liczba produktow` DESC;

-- Rozkład produktów wg stawki VAT
SELECT VAT, COUNT(DISTINCT ID_Produktu) AS "Liczba produktow" FROM Produkty GROUP BY VAT ORDER BY `Liczba produktow` DESC;


/* Tabela Wysyłki */

-- Liczba przesyłek wg przewoźnika
SELECT Przewoznik, COUNT(ID_Zamowienia) "Liczba przesylek" FROM Wysylki GROUP BY Przewoznik ORDER BY `Liczba przesylek` DESC;

-- Zestawienie przewoźników i formatów dostawy z liczbą przesyłek
SELECT Przewoznik, Format_dostawy, COUNT(ID_Zamowienia) AS "Liczba przesylek" FROM Wysylki GROUP BY Przewoznik, Format_dostawy ORDER BY Przewoznik ASC, Format_dostawy ASC, `Liczba przesylek` DESC;

-- Statusy wysyłek per przewoźnik
SELECT Przewoznik, SUM(CASE WHEN Data_wysylki IS NOT NULL THEN 1 ELSE 0 END) AS "Liczba wyslanych przesylek", SUM(CASE WHEN Data_wysylki IS NULL THEN 1 ELSE 0 END) AS "Liczba niewyslanych przesylek" FROM Wysylki GROUP BY Przewoznik ORDER BY Przewoznik ASC;

-- Roczne zestawienie liczby wysłanych przesyłek
SELECT YEAR(Data_wysylki) AS ROK, COUNT(ID_Zamowienia) AS "Liczba przesylek" FROM Wysylki WHERE Data_wysylki IS NOT NULL GROUP BY YEAR(Data_wysylki) ORDER BY YEAR(Data_wysylki) DESC;

-- Zestawienie liczby przesyłek wg statusu
SELECT Status_wysylki, COUNT(ID_Zamowienia) AS "Liczba przesylek" FROM Wysylki GROUP BY Status_wysylki ORDER BY `Liczba przesylek` DESC;


/* Tabela Zamówienia */

-- Liczba zamówień w podziale na lata
SELECT YEAR(Data_zlozenia) AS ROK, COUNT(ID_Zamowienia) AS "Liczba zamowien" FROM Zamowienia GROUP BY YEAR(Data_zlozenia) ORDER BY `Liczba zamowien` DESC;

-- Liczba zamówień wg statusu
SELECT Status_zamowienia, COUNT(ID_Zamowienia) AS "Liczba zamowien" FROM Zamowienia GROUP BY Status_zamowienia ORDER BY `Liczba zamowien` DESC;

-- Statusy zamówień w podziale na lata
SELECT Status_zamowienia, YEAR(Data_zlozenia) AS ROK, COUNT(ID_Zamowienia) AS "Liczba zamowien" FROM Zamowienia GROUP BY Status_zamowienia, Year(Data_zlozenia) ORDER BY Status_zamowienia ASC, YEAR(Data_zlozenia) DESC;

-- Ranking klientów wg liczby zamówień
SELECT ID_Klienta, COUNT(ID_Zamowienia) AS "Liczba zamowien" FROM Zamowienia GROUP BY ID_Klienta ORDER BY `Liczba zamowien` DESC;
