import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.Scanner;
import java.sql.PreparedStatement;


public class JDBC {
    public static void main(String[] args) throws SQLException {

        try {
                    //connessione al driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Crea la connessione al database
            String url = "jdbc:mysql://localhost/progetto";
            String username = "root";
            String password = "Gianmarco02";
            Connection conn = DriverManager.getConnection(url, username, password);
            Statement st = conn.createStatement();
            String input = null;
            do {
                System.out.print("1)Visualizza tutti i giocatori di una squadra\n2)Inserisci un nuovo numero di telefono ad un agente\n3)Modifica il valore di un giocatore\n4)Elimina una collaborazione fra agente e calciatore(Eliminare una tupla dalla tabella Lavora)\n0)Termina Programma\nScelta: ");
                Scanner in = new Scanner(System.in);
                ResultSet rs;
                int result;
                String query;
                result = Integer.parseInt(in.nextLine());
                switch (result){
                    case 1 -> {

                        do {
                            System.out.println("Le Squadre fra le quali puoi scegliere sono queste: ");
                            query = "SELECT Nome FROM Squadra;";
                            rs = st.executeQuery(query);
                            while (rs.next()) {
                                System.out.println(rs.getString(1));
                            }
                            System.out.print("Inserire nome Squadra: ");
                            try{
                                input = in.nextLine();
                            }catch (IllegalArgumentException e){
                                e.printStackTrace();
                            }
                            query = "SELECT Nome FROM Giocatore WHERE Squadra ='" + input + "';";
                            rs = st.executeQuery(query);
                            //verifica se è vuota la tabella restituita
                            if (rs.next())
                                break;
                            else
                                System.out.println("La squadra inserita non è contenuta all'interno del campionato di Serie A oppure non ha giocatori inseriti");
                        } while (true);
                        query = "SELECT Nome, Cognome, Ruolo FROM Giocatore WHERE Squadra = '" + input + "' ORDER BY Ruolo, Cognome;";
                        rs = st.executeQuery(query);
                        while (rs.next()) {
                            System.out.println(rs.getString(1) + " " + rs.getString(2)+ " -> " + rs.getString(3));
                        }
                    }

                    case 2 -> {
                        do{
                            System.out.println("Gli agenti fra i quali puoi scegliere sono questi: ");
                            query = "SELECT CF, Nome, Cognome FROM Agente;";
                            rs = st.executeQuery(query);
                            while (rs.next()) {
                                System.out.println(rs.getString(1) +" "+ rs.getString(2) + " "+ rs.getString(3));
                            }
                            System.out.print("Inserire CF Agente al quale aggiungere il numero: ");
                            try {
                                input = in.nextLine();
                            }catch(IllegalArgumentException e){
                                e.printStackTrace();
                            }
                            query = "SELECT CF FROM Agente WHERE CF ='" + input + "';";
                            rs = st.executeQuery(query);
                            //verifica se è vuota la tabella
                            if (rs.next())
                                break;
                            else
                                System.out.println("L' agente non è contenuto all'interno del Database");
                        } while (true);
                        query = "INSERT INTO Telefono (Numero, Agente) VALUES (?, ?)";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        String num = null;
                        System.out.print("Inserire numero di telefono: ");
                        try {
                            do {
                                num = in.nextLine();
                                if (num.length() < 10)
                                    System.out.println("Errore il numero ha minimo 10 caratteri");
                                else
                                    break;
                            }while(true);
                            stmt.setString(1, num);
                            stmt.setString(2, input);
                        }catch (IllegalArgumentException e) {
                            e.printStackTrace();
                        }

                        // Esegue la query di inserimento
                        int rowsAffected = stmt.executeUpdate();
                        System.out.println(rowsAffected + " riga/e inserita/e nel database.");
                        query = "SELECT Telefono.Agente, Agente.Nome, Agente.Cognome, Telefono.Numero FROM Telefono,Agente WHERE Telefono.Agente = Agente.CF AND Numero = '"+num+"';";
                        rs = st.executeQuery(query);
                        while (rs.next()) {
                            System.out.println(rs.getString(1) +" "+ rs.getString(2) +" "+ rs.getString(3)+" "+ rs.getString(4));
                        }
                    }

                    case 3->{
                        do {
                            System.out.println("I giocatori fra i quali scegliere sono questi: ");
                            query = "SELECT CF, Cognome, Valore FROM Giocatore;";
                            rs = st.executeQuery(query);
                            while (rs.next()) {
                                System.out.println(rs.getString(1) +" "+rs.getString(2) +" "+rs.getString(3));
                            }
                            System.out.print("Inserire Codice fiscale del calciatore al quale vuoi cambiare il valore: ");
                            try{
                                input = in.nextLine();
                            }catch (IllegalArgumentException e){
                                e.printStackTrace();
                            }
                            query = "SELECT CF FROM Giocatore WHERE CF ='" + input + "';";
                            rs = st.executeQuery(query);
                            //verifica se è vuota la tabella
                            if (rs.next())
                                break;
                            else
                                System.out.println("Il giocatore inserito non è all'interno del database");
                        } while (true);
                        query = "UPDATE Giocatore SET Valore = ? WHERE CF = ?";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        int val;
                        System.out.print("Inserire nuovo valore del giocatore: ");
                        try {
                            do {
                                val = Integer.parseInt(in.nextLine());
                                if (val < 0)
                                    System.out.println("Il valore deve essere >=0");
                                else
                                    break;
                            }while(true);
                            stmt.setInt(1, val);
                            stmt.setString(2, input);
                        }catch (IllegalArgumentException e) {
                            e.printStackTrace();
                        }

                        // Esegue la query di inserimento
                        int rowsAffected = stmt.executeUpdate();
                        System.out.println(rowsAffected + " riga/e modificata/e nel database.");
                        query = "SELECT CF, Cognome, Valore FROM Giocatore WHERE CF = '"+input+"';";
                        rs = st.executeQuery(query);
                        while (rs.next()) {
                            System.out.println(rs.getString(1) +" "+ rs.getString(2) +" "+ rs.getString(3));
                        }
                    }

                    case 4 ->{
                        String i2= null;
                        do {
                            System.out.println("Le collaborazioni fra le quali scegliere sono queste: ");
                            query = "SELECT Agente.CF, Agente.Cognome, Agente.Nome, Giocatore.CF, Giocatore.Cognome, Giocatore.Nome FROM Giocatore, Lavora, Agente WHERE Lavora.Agente = Agente.CF AND Giocatore.CF = Lavora.Giocatore;";
                            rs = st.executeQuery(query);
                            while (rs.next()) {
                                System.out.println(rs.getString(1) +" "+rs.getString(2) +" "+rs.getString(3) +" "+rs.getString(4)  +" "+rs.getString(5)  +" "+rs.getString(6));
                            }
                            System.out.print("Inserire Codice fiscale del CALCIATORE al quale vuoi togliere la tupla: ");
                            try{
                                input = in.nextLine();
                            }catch (IllegalArgumentException e){
                                e.printStackTrace();
                            }
                            System.out.print("Inserire Codice fiscale dell'AGENTE al quale vuoi togliere la tupla: ");
                            try{
                                i2 = in.nextLine();
                            }catch (IllegalArgumentException e){
                                e.printStackTrace();
                            }
                            query = "SELECT Agente, Giocatore FROM Lavora WHERE Giocatore ='"+input+"' AND Agente = '"+i2+"';";
                            rs = st.executeQuery(query);
                            //verifica se è vuota la tabella
                            if (rs.next())
                                break;
                            else
                                System.out.println("La collaborazione non è all'interno del database");
                        } while (true);
                        query = "DELETE FROM Lavora WHERE Giocatore = ? AND Agente = ?;";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setString(1, input);
                        stmt.setString(2, i2);

                        // Esegue la query di inserimento
                        int rowsAffected = stmt.executeUpdate();
                        System.out.println(rowsAffected + " riga/e eliminata/e nel database.");
                        query = "SELECT Agente.CF, Agente.Cognome, Agente.Nome, Giocatore.CF, Giocatore.Cognome, Giocatore.Nome FROM Giocatore, Lavora, Agente WHERE Lavora.Agente = Agente.CF AND Giocatore.CF = Lavora.Giocatore;";
                        rs = st.executeQuery(query);
                        while (rs.next()) {
                            System.out.println(rs.getString(1) +" "+rs.getString(2) +" "+rs.getString(3) +" "+rs.getString(4)  +" "+rs.getString(5)  +" "+rs.getString(6));
                        }

                    }

                    case 0 ->{
                        System.out.println("Fine programma");
                        System.exit(0);
                    }
                    default -> throw new IllegalStateException("Unexpected value: " + in);
                }
            }while(true);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
