package com.mycompany.cinema.gui;

import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class AjouterSeanceFrame extends JFrame {

    private JTextField champDate, champHeure, champLangue, champPlaces;
    private JComboBox<Integer> comboFilm, comboSalle;
    private Runnable rafraichir;

    public AjouterSeanceFrame(Runnable rafraichir) {
        this.rafraichir = rafraichir;
        setTitle("Ajouter une Séance");
        setSize(400, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        initUI();
    }

    private void initUI() {
        JPanel panel = new JPanel(new GridLayout(7, 2, 10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        champDate = new JTextField();
        champHeure = new JTextField();
        champLangue = new JTextField();
        champPlaces = new JTextField();

        comboFilm = new JComboBox<>();
        comboSalle = new JComboBox<>();

        chargerFilms();
        chargerSalles();

        panel.add(new JLabel("Date (YYYY-MM-DD):"));
        panel.add(champDate);
        panel.add(new JLabel("Heure (HH:MM):"));
        panel.add(champHeure);
        panel.add(new JLabel("Langue:"));
        panel.add(champLangue);
        panel.add(new JLabel("ID Film:"));
        panel.add(comboFilm);
        panel.add(new JLabel("ID Salle:"));
        panel.add(comboSalle);
        panel.add(new JLabel("Places disponibles:"));
        panel.add(champPlaces);

        JButton btnValider = new JButton("Ajouter");
        JButton btnAnnuler = new JButton("Annuler");

        btnValider.addActionListener(e -> ajouterSeance());
        btnAnnuler.addActionListener(e -> dispose());

        panel.add(btnValider);
        panel.add(btnAnnuler);

        setContentPane(panel);
    }

    private void chargerFilms() {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id_film FROM films");
            while (rs.next()) {
                comboFilm.addItem(rs.getInt("id_film"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void chargerSalles() {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id_salle FROM salles");
            while (rs.next()) {
                comboSalle.addItem(rs.getInt("id_salle"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void ajouterSeance() {
        String date = champDate.getText();
        String heure = champHeure.getText();
        String langue = champLangue.getText();
        int idFilm = (int) comboFilm.getSelectedItem();
        int idSalle = (int) comboSalle.getSelectedItem();
        int places;

        try {
            places = Integer.parseInt(champPlaces.getText());
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(this, "Veuillez entrer un nombre valide pour les places.");
            return;
        }

        if (salleOccupee(date, heure, idSalle)) {
            JOptionPane.showMessageDialog(this, "La salle est déjà occupée à cette date et heure.");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO seances (date_seance, heure, langue, id_film, id_salle, places_disponibles) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, date);
            ps.setString(2, heure);
            ps.setString(3, langue);
            ps.setInt(4, idFilm);
            ps.setInt(5, idSalle);
            ps.setInt(6, places);
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Séance ajoutée avec succès.");
            dispose();
            if (rafraichir != null) rafraichir.run();
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Erreur lors de l'ajout de la séance.");
        }
    }

    private boolean salleOccupee(String date, String heure, int idSalle) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billetteriecinema", "root", "")) {
            String sql = "SELECT COUNT(*) FROM seances WHERE date_seance = ? AND heure = ? AND id_salle = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, heure);
            ps.setInt(3, idSalle);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }
}
