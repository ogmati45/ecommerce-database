-- Usuwanie bazy danych SKLEP_ECOMMERCE, jeśli juz istnieje
DROP DATABASE IF EXISTS SKLEP_ECOMMERCE;

-- Utworzenie bazy danych SKLEP_ECOMMERCE
CREATE DATABASE SKLEP_ECOMMERCE CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;

-- Operacje na bazie danych
USE SKLEP_ECOMMERCE;

-- Utworzenie tabeli Klienci
CREATE TABLE Klienci (
    ID_Klienta INT PRIMARY KEY, -- Klucz główny
    Imie VARCHAR(25),
    Nazwisko VARCHAR(25),
    Plec CHAR(1),
    Miasto VARCHAR(15),
    Ulica VARCHAR(15),
    Nr_domu INT(3),
    Data_rejstracji DATE,
    Email VARCHAR(40),
    Wiek INT,
    Status_konta VARCHAR(25),
    Newsletter TINYINT(1)
);

-- ID_Klienta dla zakupów jako gość
INSERT INTO Klienci (ID_Klienta, Imie, Status_konta) VALUES (0, 'Gość', 'Niezarejestrowany');

-- Utworzenie tabeli Zamówienia
CREATE TABLE Zamowienia (
    ID_Zamowienia INT PRIMARY KEY AUTO_INCREMENT, -- Klucz główny
    ID_Klienta INT, -- Klucz obcy z Tabeli Klienci
    Data_zlozenia DATE,
    Status_zamowienia VARCHAR(25),
    FOREIGN KEY (ID_Klienta) REFERENCES Klienci(ID_Klienta) -- Utworzenie klucza obcego
);

-- Utworzenie tabeli Pracownicy
CREATE TABLE Pracownicy (
    ID_Pracownika INT PRIMARY KEY AUTO_INCREMENT, -- Klucz główny
    Imie VARCHAR(25),
    Nazwisko VARCHAR(25),
    Wynagrodzenie INT,
    Plec CHAR(1),
    Dzial VARCHAR(20),
    Email VARCHAR(45),
    Status_pracownika VARCHAR(20)
);


-- Utworzenie tabeli Płatności
CREATE TABLE Platnosci (
    ID_Zamowienia INT, -- Klucz obcy z Tabeli Zamówienia
    ID_Platnosci INT PRIMARY KEY AUTO_INCREMENT, -- Klucz główny
    ID_Pracownika INT, -- Klucz obcy z Tabeli Pracownicy
    Nazwa_faktury VARCHAR(20),
    Cena_poczatkowa DECIMAL(8,2),
    Rabat DECIMAL(3, 2),
    Cena_koncowa DECIMAL(8, 2),
    Status_platnosci VARCHAR(20),
    Data_platnosci DATE,
    Metoda_platnosci VARCHAR(20),
    FOREIGN KEY (ID_Zamowienia) REFERENCES Zamowienia(ID_Zamowienia), -- Utworzenie klucza obcego
    FOREIGN KEY (ID_Pracownika) REFERENCES Pracownicy(ID_Pracownika) -- Utworzenie klucza obcego
);

-- Utworzenie tabeli Produkty
CREATE TABLE Produkty (
    ID_Produktu INT PRIMARY KEY AUTO_INCREMENT, -- Klucz główny
    Producent VARCHAR(30),
    Nazwa VARCHAR(50),
    Pojemnosc INT,
    Jednostka VARCHAR(20),
    Cena_netto DECIMAL(8,2),
    VAT DECIMAL(3,2),
    Cena_brutto DECIMAL(8,2),
    Cena_strona DECIMAL(8,2),
    Marza DECIMAL(3,2),
    Status_produktu VARCHAR(25)
);

-- Utworzenie tabeli Pozycje zamówień
CREATE TABLE Pozycje_zamowien (
    ID_Zamowienia INT, -- Klucz obcy z Tabeli Zamówienia
    ID_Produktu INT, -- Klucz obcy z Tabeli Produkty
    Ilosc INT,
    Cena DECIMAL(8,2),
    FOREIGN KEY (ID_Zamowienia) REFERENCES Zamowienia(ID_Zamowienia), -- Utworzenie klucza obcego
    FOREIGN KEY (ID_Produktu) REFERENCES Produkty(ID_Produktu) -- Utworzenie klucza obcego
);

-- Utworzenie tabeli Wysyłki
CREATE TABLE Wysylki (
    ID_Zamowienia INT, -- Klucz obcy z tabeli Zamówienia
    Przewoznik VARCHAR(15),
    Format_dostawy VARCHAR(30),
    Status_wysylki VARCHAR(20),
    Data_wysylki DATE,
    FOREIGN KEY (ID_Zamowienia) REFERENCES Zamowienia(ID_Zamowienia) -- Utworzenie klucza obcego
);
