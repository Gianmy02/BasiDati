


#1 - stampa di tutti i difensori e portieri di una squadra ordinati per ruolo e cognome
SELECT Nome, Cognome, Ruolo 
FROM Giocatore 
WHERE Giocatore.Squadra = 'Napoli' AND (Ruolo = 'Portiere' OR Ruolo = 'Difensore') 
ORDER BY Ruolo,Cognome;

#2 - stampa di tutte le partite di una determinata giornata, della citta e dell'orario dove e stata giocata ogni partita
SELECT Squadra.Citta, Partita.Giorno, Partita.SquadraCasa, Partita.golSquadraCasa, Partita.SquadraTrasferta, Partita.golSquadraTrasferta 
FROM Partita, Squadra 
WHERE Partita.nGiornata = 2 AND Squadra.Nome = Partita.SquadraCasa;

#3 - stampa la somma dei valori dei calciatori di una determinata rosa
SELECT sum(Valore) AS Valore_Rosa 
FROM Giocatore 
WHERE Squadra = 'Napoli';

#4 - stampa del valore totale di ogni ruolo di una determinata rosa
SELECT Squadra, Ruolo, sum(Valore) AS ValoreRuolo
FROM Giocatore 
WHERE Squadra = 'Inter' 
GROUP BY Ruolo 
ORDER BY Ruolo;

#5 - stampa tutte le giornate con gol totali maggiore di 25
SELECT nGiornata, sum(golSquadraCasa+golSquadraTrasferta) AS golTotali 
FROM Partita 
GROUP BY nGiornata 
HAVING golTotali >= 25;

#6 - stampa del valore medio del valore dei vari ruoli per ogni squadra nel database che ha 5 o più giocatori in quel ruolo
SELECT Squadra, Ruolo, avg(Valore) AS ValoreMedio
FROM Giocatore
GROUP BY Squadra, Ruolo
HAVING COUNT(*) > 4
ORDER BY Squadra, Ruolo;

#7 - stampa di tutti i giocatori che hanno gli agenti
SELECT Giocatore.Nome, Giocatore.Cognome
FROM Giocatore
WHERE Giocatore.CF IN (SELECT Lavora.Giocatore FROM Lavora);

#stampa di tutte le partite di una determinata giornata con numero di gol >=2
SELECT  Giocatore.Cognome
FROM Giocatore, Lavora, Agente
WHERE Giocatore.CF= Lavora.Giocatore AND Lavora.Agente=Agente.CF;

#8 - stampa tutti i giocatori senza squadra e senza agente
SELECT Giocatore.Nome, Giocatore.Cognome, Giocatore.Ruolo, Giocatore.Valore
FROM Giocatore
WHERE NOT EXISTS (
  SELECT * FROM Lavora WHERE Lavora.Giocatore = Giocatore.CF
) AND NOT EXISTS (
  SELECT * FROM Squadra WHERE Squadra.Nome = Giocatore.Squadra
);