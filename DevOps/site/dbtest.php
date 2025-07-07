<?php
$servername = "192.168.85.101";  // IP de ta VM bd
$username = "webuser";
$password = "superpassword";
$dbname = "mabase";

// Créer la connexion
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérifier la connexion
if ($conn->connect_error) {
    die("❌ Connexion échouée: " . $conn->connect_error);
}
echo "✅ Connexion réussie à la base de données!";
$conn->close();
?>