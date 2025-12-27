-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  Dim 25 mai 2025 à 12:05
-- Version du serveur :  5.7.23
-- Version de PHP :  7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `billetteriecinema`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrateurs`
--

DROP TABLE IF EXISTS `administrateurs`;
CREATE TABLE IF NOT EXISTS `administrateurs` (
  `id_admin` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(100) NOT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `administrateurs`
--

INSERT INTO `administrateurs` (`id_admin`, `nom`, `prenom`, `email`, `mot_de_passe`) VALUES
(1, 'admin', 'admin', 'admin@test.com', 'bcb794a27e80b0d21e185c67c62860a2c7d38b7c8a03311cfea34055dad34a0d');

-- --------------------------------------------------------

--
-- Structure de la table `billets`
--

DROP TABLE IF EXISTS `billets`;
CREATE TABLE IF NOT EXISTS `billets` (
  `id_billet` int(11) NOT NULL AUTO_INCREMENT,
  `numero_billet` varchar(100) DEFAULT NULL,
  `id_reservation` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_billet`),
  UNIQUE KEY `numero_billet` (`numero_billet`),
  KEY `id_reservation` (`id_reservation`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `billets`
--

INSERT INTO `billets` (`id_billet`, `numero_billet`, `id_reservation`) VALUES
(5, 'B-8117D42D', 22),
(6, 'B-3C83F5F8', 22),
(7, 'B-E31D8D7F', 22),
(8, 'B-FD8ECAE3', 22),
(9, 'B-062B1A53', 22),
(10, 'B-0856C621', 22),
(11, 'B-672122AA', 22),
(12, 'B-EBE0270A', 22),
(13, 'B-6C814CB2', 22),
(14, 'B-5DEEB803', 22),
(15, 'B-501383EB', 22),
(16, 'B-197732E7', 22),
(17, 'B-AE077FB3', 22),
(18, 'B-6B813FB0', 22),
(37, 'B-04BA5142', 29),
(58, 'B-4D5182C4', 31),
(70, 'B-287AF50B', 36),
(71, 'B-448331E5', 36),
(72, 'B-87FF0E48', 37),
(73, 'B-54541C2A', 37),
(74, 'B-963E6E1C', 37),
(75, 'B-40DD3890', 37);

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id_client` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(100) NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id_client`, `nom`, `prenom`, `email`, `mot_de_passe`) VALUES
(1, 'barbouch', 'youssef', 'barbouchyoussef34@gmail.com', 'barbouch'),
(2, 'Durand', 'Claire', 'claire.durand@example.com', '956bf863627a718c3d8b151d1ac58e304d27e5503124a0178c51f6f265ccbb4f'),
(4, 'Durand', 'Claire', 'claire.durand2@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f'),
(6, 'Abdi', 'Yassine', 'yassineabdi@hotmail.com', '8023fd0ad4203dfc402481e651de11392c84c51f5336de1d56a9c1dffef732b1'),
(7, 'benihi', 'yassine', 'bnihi@gmail.com', 'bcb794a27e80b0d21e185c67c62860a2c7d38b7c8a03311cfea34055dad34a0d'),
(8, 'ali', 'benalaya', 'ali@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
(9, 'yassine', 'yassine', 'yassine@test.com', '1234567'),
(11, 'abdi', 'yassine', 'abdi@yahoo.com', '8023fd0ad4203dfc402481e651de11392c84c51f5336de1d56a9c1dffef732b1');

-- --------------------------------------------------------

--
-- Structure de la table `films`
--

DROP TABLE IF EXISTS `films`;
CREATE TABLE IF NOT EXISTS `films` (
  `id_film` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `duree` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id_film`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `films`
--

INSERT INTO `films` (`id_film`, `titre`, `genre`, `duree`, `description`) VALUES
(1, 'Titanic', 'Amour', 220, 'bateau ghrok fel mee'),
(2, 'bolice', 'action/humour', 260, 'bolice hala aadeya '),
(3, 'Avatar', 'Science-Fiction', 180, 'Voyage sur Pandora'),
(4, 'Le Seigneur des Anneaux', 'Fantastique', 200, 'La quête de l\'anneau'),
(5, 'Inception', 'Science-Fiction', 148, 'Rêves partagés'),
(6, 'La La Land', 'Comédie musicale', 128, 'Amour et musique'),
(7, 'Interstellar', 'Science-Fiction', 169, 'Voyage interstellaire'),
(8, 'Gladiator', 'Historique', 155, 'Le gladiateur vengeur'),
(9, 'Shrek', 'Animation', 90, 'L\'ogre et la princesse'),
(10, 'Joker', 'Drame', 122, 'Origine du Joker'),
(11, 'Harry Potter', 'Fantastique', 152, 'Le sorcier à lunettes'),
(12, 'Forrest Gump', 'Drame', 142, 'La vie d\'un homme simple'),
(13, 'Avengers', 'Action', 143, 'Héros Marvel réunis'),
(14, 'Matrix', 'Science-Fiction', 136, 'La matrice virtuelle'),
(15, 'Le Roi Lion', 'Animation', 88, 'Le roi de la savane'),
(16, 'Pirates des Caraïbes', 'Aventure', 143, 'Aventure pirate'),
(17, 'Deadpool', 'Action', 108, 'Le super-héros sarcastique'),
(18, 'The Dark Knight', 'Action', 152, 'Batman contre le Joker'),
(19, 'Titanic 2', 'Romance', 210, 'Suite imaginaire de Titanic'),
(20, 'Fast & Furious', 'Action', 130, 'Courses de voitures extrêmes'),
(21, 'Frozen', 'Animation', 102, 'La reine des neiges'),
(22, 'Finding Nemo', 'Animation', 100, 'Poisson perdu'),
(23, 'Toy Story', 'Animation', 81, 'Jouets vivants'),
(24, 'Inside Out', 'Animation', 95, 'Voyage émotionnel'),
(25, 'Coco', 'Animation', 105, 'Célébration des ancêtres'),
(26, 'Black Panther', 'Action', 134, 'Le roi du Wakanda'),
(27, 'Wonder Woman', 'Action', 141, 'La guerrière amazone'),
(28, 'The Godfather', 'Drame', 175, 'La famille Corleone'),
(29, 'Pulp Fiction', 'Crime', 153, 'Histoires entrelacées'),
(30, 'The Shawshank Redemption', 'Drame', 142, 'Espoir en prison'),
(31, 'The Silence of the Lambs', 'Thriller', 118, 'Tueur en série'),
(33, 'Yassine is the best', 'Comedy', 69, 'yassine abdi is the best person ever');

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

DROP TABLE IF EXISTS `paiements`;
CREATE TABLE IF NOT EXISTS `paiements` (
  `id_paiement` int(11) NOT NULL AUTO_INCREMENT,
  `montant` float NOT NULL,
  `statut` varchar(50) NOT NULL,
  `id_reservation` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_paiement`),
  KEY `id_reservation` (`id_reservation`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `paiements`
--

INSERT INTO `paiements` (`id_paiement`, `montant`, `statut`, `id_reservation`) VALUES
(4, 252, 'payé', 22),
(11, 18, 'payé', 29),
(13, 18, 'payé', 31),
(18, 36, 'en attente', 36),
(19, 72, 'payé', 37);

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id_reservation` int(11) NOT NULL AUTO_INCREMENT,
  `date_reservation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `statut` varchar(20) DEFAULT 'non payé',
  `id_client` int(11) DEFAULT NULL,
  `id_seance` int(11) DEFAULT NULL,
  `nb_places` int(11) NOT NULL,
  PRIMARY KEY (`id_reservation`),
  KEY `id_client` (`id_client`),
  KEY `id_seance` (`id_seance`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id_reservation`, `date_reservation`, `statut`, `id_client`, `id_seance`, `nb_places`) VALUES
(22, '2025-05-04 19:54:30', 'payé', 7, 4, 14),
(29, '2025-05-05 12:34:27', 'payé', 7, 7, 1),
(31, '2025-05-11 11:54:25', 'payé', 7, 7, 1),
(36, '2025-05-11 21:30:20', 'non payée', 7, 4, 2),
(37, '2025-05-12 11:52:06', 'payé', 7, 4, 4);

-- --------------------------------------------------------

--
-- Structure de la table `salles`
--

DROP TABLE IF EXISTS `salles`;
CREATE TABLE IF NOT EXISTS `salles` (
  `id_salle` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `capacite` int(11) NOT NULL,
  PRIMARY KEY (`id_salle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `salles`
--

INSERT INTO `salles` (`id_salle`, `nom`, `capacite`) VALUES
(1, 'Salle Azur City', 100),
(2, 'Salle Tunisia Mall', 120),
(3, 'Salle Mall of Sousse', 90),
(4, 'Salle Mall of Sfax', 110);

-- --------------------------------------------------------

--
-- Structure de la table `seances`
--

DROP TABLE IF EXISTS `seances`;
CREATE TABLE IF NOT EXISTS `seances` (
  `id_seance` int(11) NOT NULL AUTO_INCREMENT,
  `date_seance` date NOT NULL,
  `heure` time NOT NULL,
  `langue` varchar(50) DEFAULT NULL,
  `id_film` int(11) DEFAULT NULL,
  `id_salle` int(11) DEFAULT NULL,
  `places_disponibles` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_seance`),
  KEY `id_film` (`id_film`),
  KEY `id_salle` (`id_salle`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `seances`
--

INSERT INTO `seances` (`id_seance`, `date_seance`, `heure`, `langue`, `id_film`, `id_salle`, `places_disponibles`) VALUES
(2, '2024-05-01', '20:00:00', 'Français', 30, 1, 69),
(3, '2024-05-01', '22:00:00', 'Français', 3, 3, 56),
(4, '2024-05-01', '16:00:00', 'Français', 4, 4, 90),
(5, '2024-05-14', '15:00:00', 'Anglais', 5, 1, 100),
(7, '2025-05-06', '18:00:00', 'francais', 2, 3, 2),
(8, '2025-05-09', '18:00:00', 'Francais', 33, 1, 69),
(9, '2025-05-14', '15:00:00', 'français', 6, 4, 56);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `billets`
--
ALTER TABLE `billets`
  ADD CONSTRAINT `billets_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE CASCADE;

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `paiements_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`id_seance`) REFERENCES `seances` (`id_seance`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `reservations_ibfk_4` FOREIGN KEY (`id_seance`) REFERENCES `seances` (`id_seance`);

--
-- Contraintes pour la table `seances`
--
ALTER TABLE `seances`
  ADD CONSTRAINT `seances_ibfk_1` FOREIGN KEY (`id_film`) REFERENCES `films` (`id_film`) ON DELETE CASCADE,
  ADD CONSTRAINT `seances_ibfk_2` FOREIGN KEY (`id_salle`) REFERENCES `salles` (`id_salle`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
