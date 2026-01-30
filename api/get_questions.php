<?php
/**
 * QPUC - API Questions
 * Retourne toutes les questions avec support image
 */

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
require_once '../db.php';

try {
    $sql = "SELECT * FROM questions ORDER BY RAND()";
    $stmt = $pdo->query($sql);
    $questions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $formattedQuestions = array_map(function($q) {
        $correctIndex = ord(strtoupper($q['bonne_reponse'])) - 65;
        return [
            'id' => (int)$q['id'],
            'theme' => $q['theme'],
            'difficulte' => $q['difficulte'] ?? 'Moyen',
            'question' => $q['question'],
            'image' => $q['image_url'] ?? null,
            'clue' => $q['indice'] ?? '',
            'options' => [
                $q['reponse_A'],
                $q['reponse_B'],
                $q['reponse_C'],
                $q['reponse_D']
            ],
            'correct' => $correctIndex
        ];
    }, $questions);

    echo json_encode($formattedQuestions, JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()], JSON_UNESCAPED_UNICODE);
}
?>
