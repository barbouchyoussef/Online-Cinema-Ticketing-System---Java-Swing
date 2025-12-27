package com.mycompany.cinema.gui;

import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.util.HashMap;

public class ModifierSeanceFrame extends JFrame {

    private JTextField champDate, champHeure, champLangue, champPlaces;
    private JComboBox<String> comboFilms, comboSalles;
    private HashMap<String, Integer> filmMap = new HashMap<>();
    private HashMap<String, Integer> salleMap = new HashMap<>();
    private int idSeance;

    public ModifierSeanceFrame(int id, String date, String heure, String langue, int idFilm, int idSalle, int places, Runnable callback) {
        this.idSeance = id;
        setTitle("Modifier une Séance");
        setSize(450, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        initUI(date, heure, langue, idFilm, idSalle, places, callback);
    }

    private void initUI(String date, String heure, String langue, int idFilm, int idSalle, int places, Runnable callback) {
        JPanel panel = new JPanel(new GridLayout(7, 2, 10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        champDate = new JTextField(date);
        champHeure = new JTextField(heure);
        champLangue = new JTextField(langue);
        champPlaces = new JTextField(String.valueOf(places));

        comboFilms = new JComboBox<>();
        comboSalles = new JComboBox<>();
        chargerFilmsEtSalles(idFilm, idSalle);

        panel.add(new JLabel("Date :"));
        panel.add(champDate);
        panel.add(new JLabel("Heure :"));
        panel.add(champHeure);
        panel.add(new JLabel("Langue :"));
        panel.add(champLangue);
        panel.add(new JLabel("Film :"));
        panel.add(comboFilms);
        panel.add(new JLabel("Salle :"));
        panel.add(comboSalles);
        panel.add(new JLabel("Places disponibles :"));
        panel.add(champPlaces);

        JButton btnModifier = new JButton("Enregistrer");
        btnModifier.addActionListener(e -> modifierSeance(callback));
        panel.add(new JLabel());
        panel.add(btnModifier);

        add(panel);
    }

    private void chargerFilmsEtSalles(int idFilm, int idSalle) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
            Statement stmt = conn.createStatement();

            ResultSet rsFilms = stmt.executeQuery("SELECT id_film, titre FROM films");
            while (rsFilms.next()) {
                String titre = rsFilms.getString("titre");
                int id = rsFilms.getInt("id_film");
                comboFilms.addItem(titre);
                filmMap.put(titre, id);
                if (id == idFilm) comboFilms.setSelectedItem(titre);
            }

            ResultSet rsSalles = stmt.executeQuery("SELECT id_salle, nom FROM salles");
            while (rsSalles.next()) {
                String nom = rsSalles.getString("nom");
                int id = rsSalles.getInt("id_salle");
                comboSalles.addItem(nom);
                salleMap.put(nom, id);
                if (id == idSalle) comboSalles.setSelectedItem(nom);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private boolean salleOccupee(String date, String heure, int idSalle, int idSeance) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
            String sql = "SELECT COUNT(*) FROM seances WHERE date_seance = ? AND heure = ? AND id_salle = ? AND id_seance <> ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, heure);
            ps.setInt(3, idSalle);
            ps.setInt(4, idSeance);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // true si salle occupée par une autre séance
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true; // en cas d'erreur, on considère la salle occupée par sécurité
    }

    private void modifierSeance(Runnable callback) {
        String date = champDate.getText().trim();
        String heure = champHeure.getText().trim();
        String langue = champLangue.getText().trim();
        String placesStr = champPlaces.getText().trim();

        try {
            int places = Integer.parseInt(placesStr);
            int idFilm = filmMap.get((String) comboFilms.getSelectedItem());
            int idSalle = salleMap.get((String) comboSalles.getSelectedItem());

            // Vérification disponibilité salle
            if (salleOccupee(date, heure, idSalle, idSeance)) {
                JOptionPane.showMessageDialog(this, "La salle est déjà occupée à cette date et heure.");
                return;
            }

            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE seances SET date_seance=?, heure=?, langue=?, id_film=?, id_salle=?, places_disponibles=? WHERE id_seance=?");
                ps.setString(1, date);
                ps.setString(2, heure);
                ps.setString(3, langue);
                ps.setInt(4, idFilm);
                ps.setInt(5, idSalle);
                ps.setInt(6, places);
                ps.setInt(7, idSeance);
                ps.executeUpdate();
            }

            JOptionPane.showMessageDialog(this, "Séance modifiée.");
            if (callback != null) callback.run();
            dispose();
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(this, "Le nombre de places doit être un entier.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Erreur lors de la modification.");
        }
    }
}
