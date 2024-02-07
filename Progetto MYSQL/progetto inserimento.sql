
INSERT INTO Agente (CF, Nome, Cognome)
VALUES
  ('RSSMRA85T10A562S', 'Mario', 'Rossi'),
  ('VRDLCU70A01H501X', 'Lucia', 'Verdi'),
  ('BLUGNN80M23L219D', 'Giovanni', 'Blu');

INSERT INTO Squadra (Nome)
VALUES
  ('Juventus'),
  ('Inter'),
  ('Napoli'),
  ('Milan');

INSERT INTO Giocatore (CF, Nome, Cognome, Ruolo, Valore, Squadra)
VALUES
  ('BNCNDR85T04B123B', 'Andrea', 'Bianchi', 'Portiere', 10000, 'Juventus'),
  ('GLLFNC88A11A456F', 'Francesca', 'Gialli', 'Attaccante', 6000, 'Inter'),
  ('RSSPPL84L23A789G', 'Paolo', 'Rossi', 'Centrocampista', 8000, 'Milan'),
  ('FCTMDC90E21Z112C', 'Marco', 'Fucili', 'Difensore', 7000, 'Napoli');


INSERT INTO Allenatore (CF, Nome, Cognome, Descrizione, Squadra)
VALUES
  ('BNCRRT85T04B123B', 'Roberto', 'Bianchi', 'Specialista in difesa', 'Juventus'),
  ('VRDNNN70A01H501X', 'Anna', 'Verdi', 'Specialista in attacco', 'Inter'),
  ('BLULCU80M23L219D', 'Luca', 'Blu', 'Specialista in contropiede', 'Milan');

INSERT INTO Telefono (Numero, Agente)
VALUES
  ('+39 0123456789', 'RSSMRA85T10A562S'),
  ('+39 0123456788', 'VRDLCU70A01H501X'),
  ('+39 0123456787', 'BLUGNN80M23L219D');

INSERT INTO Partita (nGiornata, SquadraCasa, golSquadraCasa, SquadraTrasferta, golSquadraTrasferta, Giorno)
VALUES
  (1, 'Juventus', 3, 'Inter', 1, '2022-12-08 17:00:00'),
  (2, 'Milan', 0, 'Juventus', 2, '2022-12-09 20:00:00'),
  (3, 'Inter', 1, 'Milan', 2, '2022-12-10 19:00:00');

INSERT INTO Lavora (Agente, Giocatore)
VALUES
  ('RSSMRA85T10A562S', 'BNCNDR85T04B123B'),
  ('VRDLCU70A01H501X', 'GLLFNC88A11A456F'),
  ('BLUGNN80M23L219D', 'RSSPPL84L23A789G');

