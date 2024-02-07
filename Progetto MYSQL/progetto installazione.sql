DROP database IF EXISTS progetto;
CREATE DATABASE progetto;
use progetto;

CREATE TABLE Agente (
  CF VARCHAR(16) PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Cognome VARCHAR(50) NOT NULL
);

CREATE TABLE Squadra (
  Nome VARCHAR(40) PRIMARY KEY,
  Citta VARCHAR(40) NOT NULL,
  Via VARCHAR(50) NOT NULL,
  Num_Civico INT NOT NULL, 
  CAP INT NOT NULL
);

CREATE TABLE Giocatore (
  CF VARCHAR(16) PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Cognome VARCHAR(50) NOT NULL,
  Ruolo ENUM('Portiere', 'Difensore', 'Centrocampista', 'Attaccante') NOT NULL,
  Valore INT(10) NOT NULL,
  Squadra VARCHAR(40),
    FOREIGN KEY (Squadra) REFERENCES Squadra(Nome)
);

CREATE TABLE Allenatore (
  CF VARCHAR(16) PRIMARY KEY NOT NULL,
  Nome VARCHAR(50) NOT NULL,
  Cognome VARCHAR(50) NOT NULL,
  Descrizione VARCHAR(255) NOT NULL,
  Squadra VARCHAR(40) NOT NULL,
    FOREIGN KEY (Squadra) REFERENCES Squadra(Nome)
);

CREATE TABLE Telefono (
  Numero VARCHAR(15) PRIMARY KEY,
  Agente VARCHAR(16) NOT NULL,
    FOREIGN KEY (Agente) REFERENCES Agente(CF)
);

CREATE TABLE Partita (
  nGiornata INT(2) NOT NULL CHECK (nGiornata >=0),
  SquadraCasa VARCHAR(40) NOT NULL,
  golSquadraCasa INT(1) NOT NULL DEFAULT 0 CHECK (golSquadraCasa >= 0),
  SquadraTrasferta VARCHAR(255) NOT NULL,
  golSquadraTrasferta INT(1) NOT NULL DEFAULT 0 CHECK (golSquadraTrasferta >= 0),
  Giorno DATETIME NOT NULL,
  PRIMARY KEY (nGiornata, SquadraCasa),
  FOREIGN KEY (SquadraCasa) REFERENCES Squadra(Nome),
  FOREIGN KEY (SquadraTrasferta) REFERENCES Squadra(Nome)
);


CREATE TABLE Lavora (
  Agente VARCHAR(16) NOT NULL,
  Giocatore VARCHAR(16) NOT NULL,
  PRIMARY KEY (Agente, Giocatore),
  FOREIGN KEY (Agente) REFERENCES Agente(CF),
  FOREIGN KEY (Giocatore) REFERENCES Giocatore(CF)
);


INSERT INTO Agente (CF, Nome, Cognome)
VALUES
  ('RSSMRA85T10A562S', 'Mario', 'Rossi'),
  ('VRDLCU70A01H501X', 'Lucia', 'Verdi'),
  ('BLUGNN80M23L219D', 'Giovanni', 'Blu');

INSERT INTO Squadra (Nome, Citta, Via, Num_Civico, CAP)
VALUES
('Inter', 'Milano', 'Corso Vittorio Emanuele', 12, 20121),
('Juventus', 'Torino', 'Corso Galileo Ferraris', 32, 10128),
('Roma', 'Roma', 'Via del Foro Italico', 10, 00135),
('Lazio', 'Roma', 'Via di Santa Cornelia', 22, 00135),
('Napoli', 'Napoli', 'Corso Umberto I', 56, 80122),
('Milan', 'Milano', 'Piazza Giuseppe Meazza', 2, 20113),
('Sampdoria', 'Genova', 'Piazza Luigi Ferraris', 1, 16121),
('Fiorentina', 'Firenze', 'Viale Manfredo Fanti', 45, 50137),
('Atalanta', 'Bergamo', 'Via Guglielmo Marconi', 12, 24124),
('Bologna', 'Bologna', 'Via Andrea Costa', 30, 40133),
('Cremonese', 'Cremona', 'Piazza XX Settembre', 1, 26100),
('Empoli', 'Empoli', 'Via Guglielmo Marconi', 45, 50053),
('Hellas Verona', 'Verona', 'Piazzale Olimpia', 10, 37134),
('Monza', 'Monza', 'Piazza Trento e Trieste', 2, 20900),
('Torino', 'Torino', 'Via Giuseppe Garibaldi', 12, 10122),
('Udinese', 'Udine', 'Piazzale della Repubblica', 1, 33100),
('Sassuolo', 'Reggio Emilia', 'Via Ugo Bassi', 12, 42123),
('Lecce', 'Lecce', 'Via XX Settembre', 45, 73100),
('Spezia', 'La Spezia', 'Via Giovanni Pascoli', 10, 19121),
('Salernitana', 'Salerno', 'Piazza Mercato', 1, 84100);



INSERT INTO Giocatore (CF, Nome, Cognome, Ruolo, Valore, Squadra)
VALUES
    ("MRTAXN86E13G234I", "Alex", "Meret", "Portiere", 25000000, "Napoli"),
    ("SRSVTR90E01G234J", "Salvatore", "Sirigu", "Portiere", 800000, "Napoli"),
    ("HDSTKU00B01G234K", "Hubert", "Idasiak", "Portiere", 150000, "Napoli"),
    ("MRFDVD93E13G234L", "Davide", "Marfella", "Portiere", 50000, "Napoli"),
    
    ("MKMNJA94E02G234M", "Min-jae", "Kim", "Difensore", 35000000, "Napoli"),
    ("RRHMRA92E01G234N", "Amir", "Rrahmani", "Difensore", 25000000, "Napoli"),
    ("OSTLLE97E01G234O", "Leo", "Östigard", "Difensore", 7000000, "Napoli"),
    ("JSNJOA89E02G234P", "Juan", "Jesus", "Difensore", 4000000, "Napoli"),
    ("OLRMTH00E25G234Q", "Mathías", "Olivera", "Difensore", 15000000, "Napoli"),
    ("RUMRNO89E01G234R", "Mário", "Rui", "Difensore", 8000000, "Napoli"),
    ("DLRGNV91E01G234S", "Giovanni", "Di Lorenzo", "Difensore", 25000000, "Napoli"),
    ("ZNLASN00E01G234T", "Alessandro", "Zanoli", "Difensore", 4000000, "Napoli"),
    
    ("ANGFNK90L27H501P", "Frank", "Anguissa", "Centrocampista", 27000000, "Napoli"),
	("LOBTSN92S28H501N", "Stanislav", "Lobotka", "Centrocampista", 30000000, "Napoli"),
	("DEMSDF92T31H501L", "Diego", "Demme", "Centrocampista", 5000000, "Napoli"),
	("NMDTGY95A25H501R", "Tanguy", "Ndombélé", "Centrocampista", 28000000, "Napoli"),
	("ZEDKKR99C22H501E", "Karim", "Zedadka", "Centrocampista", 300000, "Napoli"),
	("ZLSPTR93B28H501L", "Piotr", "Zielinski", "Centrocampista", 40000000, "Napoli"),
	("LMSJFJ97M23H501T", "Eljif", "Elmas", "Centrocampista", 23000000, "Napoli"),
	("GAEGNL98B22H501Z", "Gianluca", "Gaetano", "Centrocampista", 4500000, "Napoli"),
    
	("KVRKHC00S21H501Y", "Khvicha", "Kvaratskhelia", "Attaccante", 60000000, "Napoli"),
	("ZRBLSO00C23H501Z", "Alessio", "Zerbin", "Attaccante", 4000000, "Napoli"),
	("LZNHRV93G27H501L", "Hirving", "Lozano", "Attaccante", 28000000, "Napoli"),
	("PLTMTE94L29H501F", "Matteo", "Politano", "Attaccante", 20000000, "Napoli"),
	("RSPGCM98M22H501W", "Giacomo", "Raspadori", "Attaccante", 35000000, "Napoli"),
	("OSHVCT98M23H501D", "Victor", "Osimhen", "Attaccante", 70000000, "Napoli"),
	("SMNGNV93C27H501F", "Giovanni", "Simeone", "Attaccante", 17000000, "Napoli"),
    
('ONAAND01A01H501S', 'André', 'Onana', 'Portiere', 14000000, 'Inter'),
('HANSAM01A01H501S', 'Samir', 'Handanovic', 'Portiere', 1000000, 'Inter'),
('BRAGAB01A01H501S', 'Gabriel', 'Brazão', 'Portiere', 500000, 'Inter'),
('CORALE01A01H501S', 'Alex', 'Cordaz', 'Portiere', 300000, 'Inter'),

('SKRMIL01A01H501S', 'Milan', 'Skriniar', 'Difensore', 60000000, 'Inter'),
('BSTAAL01A01H501S', 'Alessandro', 'Bastoni', 'Difensore', 55000000, 'Inter'),
('DEVSST01A01H501S', 'Stefan', 'de Vrij', 'Difensore', 15000000, 'Inter'),
('ACEFRA01A01H501S', 'Francesco', 'Acerbi', 'Difensore', 4000000, 'Inter'),
('DMBDAN01A01H501S', 'Danilo', "D'Ambrosio", 'Difensore', 2000000, 'Inter'),
('DMAFED01A01H501S', 'Federico', 'Dimarco', 'Difensore', 25000000, 'Inter'),
('BLLRLA22C05G273E', 'Raoul', 'Bellanova', 'Difensore', 7000000, 'Inter'),
('DRMMTT33D06L219F', 'Matteo', 'Darmian', 'Difensore', 4000000, 'Inter'),

('BRZMRL77L22L736S', 'Marcelo', 'Brozovic', 'Centrocampista', 35000000, 'Inter'),
('ASLLKR20L45L123B', 'Kristjan', 'Asllani', 'Centrocampista', 12000000, 'Inter'),
('BARNCN25D45L789Z', 'Nicolò', 'Barella', 'Centrocampista', 70000000, 'Inter'),
('CLHNHK28T67L321A', 'Hakan', 'Calhanoglu', 'Centrocampista', 35000000, 'Inter'),
('GAGLRN28L11L987Z', 'Roberto', 'Gagliardini', 'Centrocampista', 6500000, 'Inter'),
('DMFDNZ26D44L222L', 'Denzel', 'Dumfries', 'Centrocampista', 28000000, 'Inter'),
('GSNRBN28D55L444N', 'Robin', 'Gosens', 'Centrocampista', 18000000, 'Inter'),
('MKHTMH33A22L999S', 'Henrikh', 'Mkhitaryan', 'Centrocampista', 6000000, 'Inter'),
('CRBVNT17A33L555F', 'Valentín', 'Carboni', 'Centrocampista', 1500000, 'Inter'),

('CRCJQN90R30H501X', 'Joaquín', 'Correa', 'Attaccante', 20000000, 'Inter'),
('MRTLTR95S22H501X', 'Lautaro', 'Martínez', 'Attaccante', 75000000, 'Inter'),
('LKCRML91S12H501X', 'Romelu', 'Lukaku', 'Attaccante', 55000000, 'Inter'),
('DZKDNE85S19H501X', 'Edin', 'Dzeko', 'Attaccante', 4000000, 'Inter'),
('GHOFLZ85M10L219E', 'Faouzi', 'Ghoulam', 'Difensore', 100000, NULL),
('RSSFRC81M10L219E', 'Francesco', 'Rossi', 'Centrocampista', 100000, NULL);



INSERT INTO Allenatore (CF, Nome, Cognome, Descrizione, Squadra)
VALUES
  ('BNCRRT85T04B123B', 'Roberto', 'Bianchi', 'Specialista in difesa', 'Juventus'),
  ('VRDNNN70A01H501X', 'Anna', 'Verdi', 'Specialista in attacco', 'Inter'),
  ('BLULCU80M23L219D', 'Luca', 'Blu', 'Specialista in contropiede', 'Milan'),
  ("SPLLCN55S05H501T", "Luciano", "Spalletti", "Possesso Palla", "Napoli");

INSERT INTO Telefono (Numero, Agente)
VALUES
  ('+39 0123456789', 'RSSMRA85T10A562S'),
  ('+39 0123456788', 'VRDLCU70A01H501X'),
  ('+39 0123456787', 'BLUGNN80M23L219D');

INSERT INTO Partita (nGiornata, SquadraCasa, golSquadraCasa, SquadraTrasferta, golSquadraTrasferta, Giorno)
VALUES
  (1, 'Inter', 3, 'Juventus', 1, '2022-12-13 12:00:00'),
  (1, 'Roma', 2, 'Lazio', 2, '2022-12-13 15:00:00'),
  (1, 'Napoli', 1, 'Milan', 1, '2022-12-13 18:00:00'),
  (1, 'Sampdoria', 1, 'Fiorentina', 0, '2022-12-13 21:00:00'),
  (1, 'Atalanta', 2, 'Bologna', 1, '2022-12-14 12:00:00'),
  (1, 'Cremonese', 0, 'Empoli', 2, '2022-12-14 15:00:00'),
  (1, 'Hellas Verona', 1, 'Monza', 0, '2022-12-14 18:00:00'),
  (1, 'Torino', 3, 'Udinese', 1, '2022-12-14 21:00:00'),
  (1, 'Sassuolo', 1, 'Lecce', 2, '2022-12-15 12:00:00'),
  (1, 'Spezia', 1, 'Salernitana', 0, '2022-12-15 15:00:00'),
  
  (2 , 'Juventus', 4, 'Spezia', 0, '2022-12-20 12:00:00'),
  (2, 'Lazio', 2, 'Sassuolo', 3, '2022-12-20 15:00:00'),
  (2, 'Milan', 2, 'Torino', 0, '2022-12-20 18:00:00'),
  (2, 'Fiorentina', 0, 'Hellas Verona', 2, '2022-12-20 21:00:00'),
  (2, 'Bologna', 2, 'Cremonese', 1, '2022-12-21 12:00:00'),
  (2, 'Empoli', 0, 'Atalanta', 2, '2022-12-21 15:00:00'),
  (2, 'Monza', 1, 'Sampdoria', 0, '2022-12-21 18:00:00'),
  (2, 'Udinese', 0, 'Napoli', 1, '2022-12-21 21:00:00'),
  (2, 'Lecce', 3, 'Roma', 0, '2022-12-22 12:00:00'),
  (2, 'Salernitana', 0, 'Inter', 0, '2022-12-22 15:00:00');

INSERT INTO Lavora (Agente, Giocatore)
VALUES
  ('RSSMRA85T10A562S', 'OSHVCT98M23H501D'),
  ('VRDLCU70A01H501X', 'JSNJOA89E02G234P'),
  ('BLUGNN80M23L219D', 'SMNGNV93C27H501F'),
  ('RSSMRA85T10A562S', 'MRTAXN86E13G234I'),
  ('VRDLCU70A01H501X', 'SRSVTR90E01G234J'),
  ('BLUGNN80M23L219D', 'HDSTKU00B01G234K'),
  ('VRDLCU70A01H501X', 'OSHVCT98M23H501D');

