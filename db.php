<?php
/**
 * QPUC - Connexion Base de Données
 * Configuration pour WAMP/MySQL
 */

$host = 'localhost';
$dbname = 'quiz_db';  // Nom de la base de données
$username = 'root';   // Par défaut sur WAMP
$password = '';       // Vide par défaut sur WAMP

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    // Activer les erreurs pour le debug
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Erreur de connexion à la base de données : " . $e->getMessage());
}
?>
