<?php
/**
 * Script d'installation automatique de la base de données
 * Ce script est appelé par db.php et s'exécute une seule fois
 */

// Configuration
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'quiz_db';

try {
    // Connexion sans spécifier de base de données
    $pdo = new PDO("mysql:host=$host;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Créer la base de données si elle n'existe pas
    $pdo->exec("CREATE DATABASE IF NOT EXISTS `$dbname` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    $pdo->exec("USE `$dbname`");
    
    // Vérifier si la table questions existe ET contient des données
    $stmt = $pdo->query("SHOW TABLES LIKE 'questions'");
    $tableExists = $stmt->rowCount() > 0;
    
    if ($tableExists) {
        $count = $pdo->query("SELECT COUNT(*) FROM questions")->fetchColumn();
        if ($count > 0) {
            // Base déjà installée, on ne fait rien
            return;
        }
    }
    
    // Lire et exécuter le fichier SQL
    $sqlFile = __DIR__ . '/sql/setup.sql';
    
    if (file_exists($sqlFile)) {
        $sql = file_get_contents($sqlFile);
        
        // Supprimer les commentaires et les lignes vides
        $sql = preg_replace('/--.*$/m', '', $sql);
        $sql = preg_replace('/\/\*.*?\*\//s', '', $sql);
        
        // Séparer les requêtes
        $queries = array_filter(array_map('trim', explode(';', $sql)));
        
        foreach ($queries as $query) {
            if (!empty($query) && stripos($query, 'SELECT') !== 0) {
                $pdo->exec($query);
            }
        }
        
        error_log("QPUC: Base de données installée automatiquement !");
    } else {
        error_log("QPUC: Fichier sql/setup.sql introuvable");
    }
    
} catch (PDOException $e) {
    error_log("QPUC Install Error: " . $e->getMessage());
}
?>
