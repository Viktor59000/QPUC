<?php
session_start();
header('Content-Type: application/json');
require_once '../db.php';

$data = json_decode(file_get_contents('php://input'), true);
$username = trim($data['username'] ?? '');
$password = $data['password'] ?? '';

// Validation basique
if (empty($username) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Identifiants requis.']);
    exit;
}

// 1. Chercher l'utilisateur
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
$stmt->execute([$username]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

// 2. Vérifier le hash du mot de passe
if ($user && password_verify($password, $user['password'])) {
    // Succès : Création de la session serveur
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['username'] = $user['username'];
    echo json_encode(['success' => true, 'username' => $user['username']]);
} else {
    echo json_encode(['success' => false, 'message' => 'Identifiants incorrects.']);
}
?>
