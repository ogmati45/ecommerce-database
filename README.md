# Sklep E-commerce - Model Bazy Danych


## 📖 Opis projektu
Projekt został **stworzony całkowicie od podstaw** – od pomysłu, przez zaprojektowanie struktury bazy danych, aż po implementację i analizę danych.  

Cały scenariusz został wymyślony przeze mnie, włącznie z:
- zaprojektowałem strukturę bazy danych (ERD) w **MySQL Workbench** oraz **phpMyAdmin**,  
- tworzeniem tabel, relacji, widoków i zapytań w SQL,  
- opracowaniem procesów biznesowych sklepu internetowego,  
- analizą i raportowaniem danych w **Excel** i **Power BI**,  
- wykorzystaniem narzędzi do zarządzania i prezentacji danych,  
- pełnym przygotowaniem dokumentacji technicznej.  

Celem projektu było nie tylko odwzorowanie działania sklepu e-commerce, ale także **nauka i rozwój umiejętności praktycznych** w:
- **SQL** (projektowanie i optymalizacja zapytań),  
- **Excel** (analizy i raportowanie),  
- **Power BI** (wizualizacje i dashboardy),  
- **zarządzaniu projektem IT**,  
- **projektowaniu struktur bazodanowych**.  

Projekt pokazuje moje podejście do **całościowego tworzenia systemu** – od koncepcji po analizę wyników.


## 🧩 Struktura
Baza została zaprojektowana w oparciu o kluczowe procesy e-commerce.  
Składa się z 7 głównych tabel:  

- **Klienci** – dane użytkowników (7 tys. rekordów)  
- **Produkty** – asortyment sklepu (3 tys. rekordów)  
- **Zamówienia** – transakcje klientów (90 tys. rekordów)  
- **Pozycje_zamówień** – szczegóły zamówionych produktów  
- **Płatności** – faktury, statusy i metody płatności  
- **Wysyłki** – przewoźnicy, format dostawy, status przesyłki  
- **Pracownicy** – dane pracowników (100 rekordów)  

Szczegółowy opis wszystkich pól tabel znajduje się w [docs/Struktura.pdf] (docs/Struktura.pdf)


## 📂 Struktura repozytorium

- **sql/**
  - `SKLEP_ECOMMERCE.SQL` – pełna struktura bazy danych  
  - `KOMENDY.SQL` – przykładowe zapytania SQL  
  - `WIDOKI.SQL` – definicje widoków  

- **csv/**
  - `1Klienci.csv` – dane klientów (7 000 rekordów)  
  - `2Zamówienia.csv` – dane zamówień (90 000 rekordów)  
  - `3Produkty.csv` – dane produktów (3 000 rekordów)  
  - `4Pracownicy.csv` – dane pracowników (100 rekordów)  
  - `5Płatności.csv` – dane płatności (90 000 rekordów)  
  - `6Pozycje_zamówien.csv` – dane pozycji zamówień  
  - `7Wysyłki.csv` – dane wysyłek  

- **docs/**
  - `Schemat_ERD.png` – diagram bazy danych  
  - `Struktura.pdf` – szczegółowy opis tabel i pól  
  - `E-commerce_EXCEL.pdf` – analizy w Excelu  
  - `E-commerce_BI.pdf` – raporty w Power BI  

- **excel/**
  - `E-commerce_EXCEL.xlsx` – plik źródłowy z analizami  

- **powerbi/**
  - `E-commerce_BI.pbix` – dashboard w Power BI  

- **assets/**
  - `LOGO.jpeg` – logo projektu

## 🎯 Cele projektu
- Rozwój praktycznych umiejętności w SQL, Excel, Power BI i Workbench  
- Zaprojektowanie realistycznej bazy e-commerce od podstaw  
- Analiza dużego zbioru danych (ponad 180 000 rekordów)  
- Budowa portfolio do pokazania na rozmowach rekrutacyjnych  

## 🧠 Czego się nauczyłem
- Projektowania i normalizacji baz danych  
- Tworzenia i optymalizacji zapytań SQL  
- Dokumentowania projektu w MySQL Workbench  
- Tworzenia raportów i dashboardów w Excelu i Power BI  
- Pracy z danymi w formacie CSV i integracji z SQL
  
