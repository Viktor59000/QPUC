<?php
/**
 * QPUC - Connexion Base de Données
 * Configuration pour WAMP/MySQL
 * Auto-installation au premier lancement
 */

$host = 'localhost';
$dbname = 'quiz_db';
$username = 'root';
$password = '';

try {
    // D'abord, on tente l'installation automatique (si nécessaire)
    require_once __DIR__ . '/install.php';
    
    // Ensuite, connexion normale
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
} catch (PDOException $e) {
    die("Erreur de connexion à la base de données : " . $e->getMessage());
}
?>
