<?php
session_start();
header('Content-Type: application/json');
require_once '../db.php';

$data = json_decode(file_get_contents('php://input'), true);
$username = trim($data['username'] ?? '');
$email = trim($data['email'] ?? '');
$password = $data['password'] ?? '';

// Validation basique
if (empty($username) || empty($email) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Tous les champs sont requis.']);
    exit;
}

// 1. Vérifier si l'user existe déjà
$stmt = $pdo->prepare("SELECT id FROM users WHERE username = ?");
$stmt->execute([$username]);
if ($stmt->fetch()) {
    echo json_encode(['success' => false, 'message' => 'Ce pseudo est déjà pris.']);
    exit;
}

// 2. Hasher le mot de passe (Sécurité avec bcrypt)
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

// 3. Insérer
$insert = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
if ($insert->execute([$username, $email, $hashed_password])) {
    // Connexion auto après inscription
    $_SESSION['user_id'] = $pdo->lastInsertId();
    $_SESSION['username'] = $username;
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Erreur technique.']);
}
?>
