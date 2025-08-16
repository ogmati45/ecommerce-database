/* PRODUKTY: RANKING WG (SPRZEDAŻY, ILOŚCI, ZAROBKU) */

-- RANKING SPRZEDAŻY PRODUKTOW (WG SPRZEDAŻY)
CREATE VIEW Produkty_ranking_sprzedaz AS
SELECT
	RANK() OVER (ORDER BY `Sprzedaz (PLN)` DESC) AS RANKING,
    `Sprzedaz (PLN)`,
    `Ilosc sprzedanych`,
    ID_Produktu,
    Nazwa,
    Producent,
    `Opakowanie`,
    `Cena na stronie`,
    `Marza (%)`,
    `Zarobek`
FROM (
SELECT
	SUM(Pozycje_zamowien.Ilosc) AS 'Ilosc sprzedanych',
    Pozycje_zamowien.ID_Produktu,
    Produkty.Nazwa,
    Produkty.Producent,
    CONCAT(Produkty.Pojemnosc, ' ', Produkty.Jednostka) AS 'Opakowanie',
    Produkty.Cena_strona AS 'Cena na stronie',
    CONCAT(Produkty.Marza * 100, '%') AS 'Marza (%)',
    Produkty.Cena_strona * SUM(Pozycje_zamowien.Ilosc) AS 'Sprzedaz (PLN)',
    Produkty.Cena_strona * SUM(Pozycje_zamowien.Ilosc) * Produkty.Marza AS 'Zarobek'
FROM Pozycje_zamowien
JOIN Produkty ON Pozycje_zamowien.ID_Produktu = Produkty.ID_Produktu
GROUP BY 
    Pozycje_zamowien.ID_Produktu,
    Produkty.Nazwa,
    Produkty.Producent,
    Produkty.Pojemnosc,
    Produkty.Jednostka,
    Produkty.Cena_strona,
    Produkty.Marza
) AS Produkty_Ilosc;

-- RANKING SPRŻEDAZY PRODUKTOW (WG ILOŚCI)
CREATE VIEW Produkty_ranking_ilosc AS
SELECT
	RANK() OVER (ORDER BY `Ilosc sprzedanych` DESC) AS RANKING,
    `Ilosc sprzedanych`,
    ID_Produktu,
    Nazwa,
    Producent,
    `Opakowanie`,
    `Cena na stronie`,
    `Marza (%)`,
    `Sprzedaz (PLN)`,
    `Zarobek`
FROM (
SELECT
	SUM(Pozycje_zamowien.Ilosc) AS 'Ilosc sprzedanych',
    Pozycje_zamowien.ID_Produktu,
    Produkty.Nazwa,
    Produkty.Producent,
    CONCAT(Produkty.Pojemnosc, ' ', Produkty.Jednostka) AS 'Opakowanie',
    Produkty.Cena_strona AS 'Cena na stronie',
    CONCAT(Produkty.Marza * 100, '%') AS 'Marza (%)',
    Produkty.Cena_strona * SUM(Pozycje_zamowien.Ilosc) AS 'Sprzedaz (PLN)',
    Produkty.Cena_strona * SUM(Pozycje_zamowien.Ilosc) * Produkty.Marza AS 'Zarobek'
FROM Pozycje_zamowien
JOIN Produkty ON Pozycje_zamowien.ID_Produktu = Produkty.ID_Produktu
GROUP BY 
    Pozycje_zamowien.ID_Produktu,
    Produkty.Nazwa,
    Produkty.Producent,
    Produkty.Pojemnosc,
    Produkty.Jednostka,
    Produkty.Cena_strona,
    Produkty.Marza
) AS Produkty_Ilosc;

-- RANKING SPRZEDAŻY PRODUKTOW (WG ZAROBKU)
CREATE VIEW Produkty_ranking_zarobek AS
SELECT
	RANK() OVER (ORDER BY `Zarobek` DESC) AS RANKING,
    `Zarobek`,
    ID_Produktu,
    `Ilosc sprzedanych`,
    Nazwa,
    Producent,
    `Opakowanie`,
    `Cena na stronie`,
    `Marza (%)`,
    `Sprzedaz (PLN)`
FROM (
SELECT 
    Pozycje_zamowien.ID_Produktu,
    SUM(Pozycje_zamowien.Ilosc) AS "Ilosc sprzedanych",
    Produkty.Nazwa,
    Produkty.Producent,
    CONCAT(Produkty.Pojemnosc, ' ', Produkty.Jednostka) AS 'Opakowanie',
    Produkty.Cena_strona AS 'Cena na stronie',
    CONCAT(Produkty.Marza * 100, '%') AS 'Marza (%)',
    Produkty.Cena_strona * SUM(Pozycje_zamowien.Ilosc) AS 'Sprzedaz (PLN)',
    Produkty.Cena_strona * SUM(Pozycje_zamowien.Ilosc) * Produkty.Marza AS 'Zarobek'
FROM Pozycje_zamowien
JOIN Produkty ON Pozycje_zamowien.ID_Produktu = Produkty.ID_Produktu
GROUP BY 
    Pozycje_zamowien.ID_Produktu,
    Produkty.Nazwa,
    Produkty.Producent,
    Produkty.Pojemnosc,
    Produkty.Jednostka,
    Produkty.Cena_strona,
    Produkty.Marza)
AS Produkty_zarobek;


/* KLIENCI: RANKING WG (ILOSCI ZAMOWIEN, KWOTY ZAMOWIENIA, KWOTY ZAMOWIEN (WSZYSTKICH)) */

-- GRUPA WIEKOWA KLIENCI
CREATE VIEW Klienci_grupy_wiekowe AS
SELECT
	CASE
    	WHEN Klienci.Wiek < 22 THEN '16-24'
        WHEN Klienci.Wiek < 35 THEN '25-34'
        WHEN Klienci.WIEK < 45 THEN '35-44'
        WHEN Klienci.WIEK < 55 THEN '45-54'
        WHEN Klienci.WIEK < 65 THEN '55-64'
        ELSE '65+'
	END AS `Grupa wiekowa`,
    COUNT(DISTINCT Klienci.ID_Klienta) AS 'Liczba klientow',
    CONCAT(ROUND(COUNT(DISTINCT Klienci.ID_Klienta)/(SELECT COUNT(DISTINCT Klienci.ID_Klienta) FROM Klienci)*100, 2), ' %') AS 'Udzial (%)',
    SUM(CASE WHEN Klienci.Plec = 'K' THEN 1 ELSE 0 END) AS 'Kobiety',
    SUM(CASE WHEN Klienci.Plec = 'M' THEN 1 ELSE 0 END) AS 'Mezczyzni',
    SUM(CASE WHEN Klienci.Newsletter = 1 THEN 1 ELSE 0 END) AS 'Newsletter',
    CONCAT(ROUND(SUM(CASE WHEN Klienci.Newsletter = 1 THEN 1 ELSE 0 END)/COUNT(DISTINCT Klienci.ID_Klienta) * 100, 2), ' %') AS 'Newsletter (%)'
FROM Klienci
GROUP BY `Grupa wiekowa`;

-- RANKING KLIENTÓW (WG ILOŚCI ZAMÓWIEN)
CREATE VIEW Klienci_ranking_ilosci_zamowien AS
SELECT
	RANK() OVER (ORDER BY `Ilosc zamowien` DESC) AS RANKING,
    `Ilosc zamowien`,
    ID_Klienta,
    Imie,
    Nazwisko,
    Wiek,
    Newsletter
FROM (
SELECT 
	Zamowienia.ID_Klienta, 
    Klienci.Imie,
    Klienci.Nazwisko,
    Klienci.Wiek,
    CASE
    	WHEN Klienci.Newsletter = 1 THEN 'TRUE' ELSE 'FALSE'
    END AS Newsletter,
    COUNT(Zamowienia.ID_Klienta) AS 'Ilosc zamowien'
FROM Zamowienia 
JOIN Klienci ON Zamowienia.ID_Klienta = Klienci.ID_Klienta 
GROUP BY Zamowienia.ID_Klienta, Klienci.Imie, Klienci.Nazwisko, Klienci.Wiek)
AS Klienci_ilosc_zam;

-- RANKING KLIENTÓW (WG KWOTY ZAMÓWIENIA - OPŁACONEGO!)
CREATE VIEW Klienci_ranking_kwota_zamowienia AS
SELECT
	RANK() OVER (ORDER BY `Kwota zamowienia` DESC) AS RANKING,
    `Kwota zamowienia`,
    ID_Zamowienia,
    ID_Klienta,
    Imie,
    Nazwisko,
    Wiek,
    Newsletter
FROM (
SELECT 
	Platnosci.Cena_koncowa AS 'Kwota zamowienia',
    Zamowienia.ID_Zamowienia,
	Zamowienia.ID_Klienta,
    Klienci.Imie,
    Klienci.Nazwisko,
    Klienci.Wiek,
    CASE
    	WHEN Klienci.Newsletter = 1 THEN 'TRUE' ELSE 'FALSE'
    END AS Newsletter
FROM Zamowienia
JOIN Klienci ON Zamowienia.ID_Klienta = Klienci.ID_Klienta
JOIN Platnosci ON Zamowienia.ID_Zamowienia = Platnosci.ID_Zamowienia
WHERE Platnosci.Status_platnosci = 'Opłacona')
AS Klienci_kwota_zamowienia;

-- RANKING KLIENTÓW (WG KWOTY ZAMÓWIEŃ (WSZYSTKICH) - OPŁACONYCH!)
CREATE VIEW Klienci_ranking_kwoty_zamowien AS
SELECT
	RANK() OVER (ORDER BY `Kwota zamowien` DESC) AS RANKING,
    `Kwota zamowien`,
    ID_Klienta,
    Imie,
    Nazwisko,
    Wiek,
    Newsletter,
    `Ilosc zamowien`
FROM (
SELECT 
	SUM(Platnosci.Cena_koncowa) AS 'Kwota zamowien',
    COUNT(Zamowienia.ID_Zamowienia) AS 'Ilosc zamowien',
	Zamowienia.ID_Klienta,
    Klienci.Imie,
    Klienci.Nazwisko,
    Klienci.Wiek,
    CASE
    	WHEN Klienci.Newsletter = 1 THEN 'TRUE' ELSE 'FALSE'
    END AS Newsletter
FROM Zamowienia
JOIN Klienci ON Zamowienia.ID_Klienta = Klienci.ID_Klienta
JOIN Platnosci ON Zamowienia.ID_Zamowienia = Platnosci.ID_Zamowienia
WHERE Platnosci.Status_platnosci = 'Opłacona'
GROUP BY Zamowienia.ID_Klienta, Klienci.Imie, Klienci.Nazwisko, Klienci.Wiek, Klienci.Newsletter)
AS Klienci_kwota_zamowien;


/* PRACOWNICY: DEMOGRAFIA WG (PŁCI, DZIAŁU), RANKING ZAROBKÓW (TYLKO ZATRUDNIONYCH), WYDAJNOSC PRACOWNIKOW */

-- DEMOGRAFIA WG PŁCI
CREATE VIEW Pracownicy_demografia_plec AS
SELECT
	Plec,
    COUNT(ID_Pracownika) AS 'Liczba pracownikow',
    CONCAT(ROUND(COUNT(ID_Pracownika) / (SELECT COUNT(ID_Pracownika) FROM Pracownicy) * 100, 2), ' %') AS 'Udzial (%)',
    SUM(CASE WHEN Status_pracownika = 'Zatrudniony' THEN 1 ELSE 0 END) AS Zatrudnieni,
    SUM(CASE WHEN Status_pracownika = 'Zwolniony' THEN 1 ELSE 0 END) AS Zwolnieni,
    CONCAT(ROUND(SUM(CASE WHEN Status_pracownika = 'Zatrudniony' THEN 1 ELSE 0 END) / COUNT(ID_Pracownika) * 100, 2), ' %') AS 'Zatrudnienie (%)',
    SUM(CASE WHEN Dzial = 'Rachunkowość' THEN 1 ELSE 0 END) AS Rachunkowosc,
    SUM(CASE WHEN Dzial = 'Analityk' THEN 1 ELSE 0 END) AS Analityk,
    SUM(CASE WHEN Dzial = 'Kompletacja' THEN 1 ELSE 0 END) AS Kompletacja,
    SUM(CASE WHEN Dzial = 'Magazynier' THEN 1 ELSE 0 END) AS Magazynier,
    SUM(CASE WHEN Dzial = 'Informatyk' THEN 1 ELSE 0 END) AS Informatyk,
    ROUND(AVG(Wynagrodzenie), 2) AS 'Wynagrodzenie (AVG)',
    SUM(Wynagrodzenie) AS 'Wynagrodzenie (SUMA)'
FROM Pracownicy
GROUP BY Plec;

-- DEMOGRAFIA WG DZIAŁU
CREATE VIEW Pracownicy_demografia_dzial AS 
SELECT
	Dzial,
    COUNT(ID_Pracownika) AS 'Liczba pracownikow',
    CONCAT(ROUND(COUNT(ID_Pracownika) / (SELECT COUNT(ID_Pracownika) FROM Pracownicy) * 100, 2), ' %') AS 'Udzial (%)',
    SUM(CASE WHEN Status_pracownika = 'Zatrudniony' THEN 1 ELSE 0 END) AS Zatrudnieni,
    SUM(CASE WHEN Status_pracownika = 'Zwolniony' THEN 1 ELSE 0 END) AS Zwolnieni,
    CONCAT(ROUND(SUM(CASE WHEN Status_pracownika = 'Zatrudniony' THEN 1 ELSE 0 END) / COUNT(ID_Pracownika) * 100, 2), ' %') AS 'Zatrudnienie (%)',
    SUM(CASE WHEN Plec = 'K' THEN 1 ELSE 0 END) AS Kobiety,
    CONCAT(ROUND(SUM(CASE WHEN Plec = 'K' THEN 1 ELSE 0 END) / COUNT(ID_Pracownika) * 100, 2), ' %') AS 'Kobiety (%)',
    SUM(CASE WHEN Plec = 'M' THEN 1 ELSE 0 END) AS Mezczyzni,
    CONCAT(ROUND(SUM(CASE WHEN Plec = 'M' THEN 1 ELSE 0 END) / COUNT(ID_Pracownika) * 100, 2), ' %') AS 'Mezczyzni (%)',
    ROUND(AVG(Wynagrodzenie),2) AS 'Wynagrodzenie (AVG)',
    SUM(Wynagrodzenie) AS 'Wynagrodzenie (SUMA)'
FROM Pracownicy
GROUP BY Dzial;

-- RANKING ZAROBKÓW (TYLKO ZATRUDNIONYCH)
SELECT
	RANK() OVER (ORDER BY Wynagrodzenie DESC) AS RANKING,
    Wynagrodzenie,
	ID_Pracownika,
    Imie,
    Nazwisko,
    Plec,
    Dzial
FROM Pracownicy
WHERE Status_pracownika = 'zatrudniony';

-- WYDAJNOSC PRACONIKOW
CREATE VIEW Pracownicy_ranking_wydajnosci AS
SELECT
	RANK() OVER (ORDER BY `Ilosc zamowien` DESC) AS RANKING,
    `Ilosc zamowien`,
    ID_Pracownika,
    Imie,
    Nazwisko,
    Dzial
FROM (
SELECT
	COUNT(ID_Zamowienia) AS 'Ilosc zamowien',
	Platnosci.ID_Pracownika,
    Pracownicy.Imie,
    Pracownicy.Nazwisko,
    Pracownicy.Dzial
FROM Platnosci
JOIN Pracownicy ON Platnosci.ID_Pracownika = Pracownicy.ID_Pracownika
GROUP BY ID_Pracownika, Pracownicy.Imie, pracownicy.Nazwisko, pracownicy.Dzial)
AS Pracownicy_wyd;


/* PLATNOSCI: PODSUMOWANIE METOD / PODSUMOWANIE STATUSOW PLATNOSCI */

-- PODSUMOWANIE METOD PLATNOSCI
CREATE VIEW Platnosci_podsumowanie_metod AS
SELECT
	Metoda_platnosci,
    CONCAT(ROUND(COUNT(ID_Platnosci)/(SELECT COUNT(ID_Platnosci) FROM Platnosci) * 100, 2), ' %') AS 'Udzial (%)',
    COUNT(DISTINCT ID_Platnosci) AS 'Ilosc platnosci',
    CONCAT(ROUND(AVG(Rabat), 2), ' %') AS 'Rabat (% AVG)',
    ROUND(AVG(Cena_koncowa), 2) AS 'Kwota koncowa (AVG)',
    SUM(Cena_koncowa) AS 'Suma koncowa',
    (SUM(Cena_poczatkowa) - SUM(Cena_koncowa)) AS 'Suma rabatow'
FROM Platnosci
GROUP BY Metoda_platnosci;

-- PODSUMOWANIE STATUSÓW PŁATNOŚCI
CREATE VIEW Platnosci_podsumowanie_statusow AS
SELECT
	Status_platnosci,
    CONCAT(ROUND(COUNT(ID_Platnosci)/(SELECT COUNT(ID_Platnosci) FROM Platnosci) * 100, 2), ' %') AS 'Udzial (%)',
    COUNT(ID_Platnosci) AS 'Ilosc platnosci',
    SUM(CASE WHEN Metoda_platnosci = 'Blik' THEN 1 ELSE 0 END) AS 'Blik',
    SUM(CASE WHEN Metoda_platnosci = 'Przelewy24' THEN 1 ELSE 0 END) AS 'Przelewy24',
    SUM(CASE WHEN Metoda_platnosci = 'PayU' THEN 1 ELSE 0 END) AS 'PayU',
    SUM(CASE WHEN Metoda_platnosci = 'Karta' THEN 1 ELSE 0 END) AS 'Karta',
    SUM(CASE WHEN Metoda_platnosci = 'Pobranie' THEN 1 ELSE 0 END) AS 'Pobranie',
    SUM(CASE WHEN Metoda_platnosci = 'Voucher' THEN 1 ELSE 0 END) AS 'Voucher',
    SUM(CASE WHEN Metoda_platnosci LIKE 'Przelew%' THEN 1 ELSE 0 END) AS 'Przelew',
    CONCAT(ROUND(AVG(Rabat), 2), ' %') AS 'Rabat (% AVG)',
    SUM(Cena_koncowa) AS 'Suma koncowa',
    (SUM(Cena_poczatkowa) - SUM(Cena_koncowa)) AS 'Suma rabatow'
FROM Platnosci
GROUP BY Status_platnosci;


/* WYSYŁKI: RANKING PRZEWOŹNIKÓW */

-- RANKING PRZEWOZNIKÓW
CREATE VIEW Wysylki_ranking_przewoznik AS
SELECT
	RANK() OVER (ORDER BY `Liczba przesylek` DESC) AS 'RANKING',
    Przewoznik,
    `Udzial (%)`,
    `Liczba przesylek`,
    `Kurier`,
    `Kurier Pobranie`,
    `Paczkomat`,
    `Dostarczone`,
    `Niedostarczone`
FROM (
SELECT
	Przewoznik,
    COUNT(ID_Zamowienia) AS 'Liczba przesylek',
    CONCAT(ROUND(COUNT(ID_Zamowienia)/(SELECT COUNT(ID_Zamowienia) FROM Wysylki) * 100, 2), ' %') AS 'Udzial (%)',
    SUM(CASE WHEN Format_dostawy = 'Kurier' THEN 1 ELSE 0 END) AS 'Kurier',
    SUM(CASE WHEN Format_dostawy = 'Kurier Pobranie' THEN 1 ELSE 0 END) AS 'Kurier Pobranie',
    SUM(CASE WHEN Format_dostawy = 'Paczkomat' THEN 1 ELSE 0 END) AS 'Paczkomat',
    SUM(CASE WHEN Data_wysylki IS NOT NULL THEN 1 ELSE 0 END) AS 'Dostarczone',
    SUM(CASE WHEN Data_wysylki IS NULL THEN 1 ELSE 0 END) AS 'Niedostarczone'
FROM Wysylki
GROUP BY Przewoznik) AS Przewoznik_chwil;


SELECT
	Status_zamowienia,
    COUNT(ID_Zamowienia) AS 'Liczba zamowien',
    CONCAT(ROUND(COUNT(ID_Zamowienia)/(SELECT COUNT(ID_Zamowienia) FROM Zamowienia)*100, 2), ' %') AS 'Udzial (%)'
FROM Zamowienia
GROUP BY Status_zamowienia
ORDER BY COUNT(ID_Zamowienia) DESC;

/* ZAMÓWIENIA: STATYSTYKI STATUSÓW ZAMÓWIEŃ + STATYSTYKI ZAMÓMÓWIEN WG ROKU/MIESIACA */

-- STATYSTYKI ZAMÓWIEŃ WG STATUSU
CREATE VIEW Zamowienia_statystyki_statusu AS
SELECT 
    Status_zamowienia, 
    COUNT(ID_Zamowienia) AS 'Liczba zamowien' 
FROM Zamowienia
GROUP BY Status_zamowienia 
ORDER BY COUNT(ID_Zamowienia) DESC;

-- STATYSTYKI ZAMÓWIEN WG DATY (ROK/MIESIAC)
CREATE VIEW Zamowienia_stastyki_zamowien_data AS
SELECT 
	YEAR(Data_zlozenia) AS `ROK`, 
    MONTH(Data_zlozenia) AS `MIESIAC`, 
    COUNT(ID_Zamowienia) AS `Liczba zamowien` 
FROM Zamowienia 
GROUP BY YEAR(Data_zlozenia), MONTH(Data_zlozenia) 
ORDER BY YEAR(Data_zlozenia) DESC, MONTH(Data_zlozenia) ASC;
