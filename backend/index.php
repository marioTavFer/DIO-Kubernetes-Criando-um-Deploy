<?php
//header("Access-Control-Allow-Origin: *");
//header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Origin: *"); // Allow cross-origin requests
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


include 'conexao.php';

// $id =  rand(1, 999);
$nome = $_POST["nome"];
$email = $_POST["email"];
$comentario = $_POST["comentario"];

// $query = "INSERT INTO mensagens(id, nome, email, comentario) VALUES ('$id', '$nome', '$email', '$comentario')";
$query = "INSERT INTO mensagens(nome, email, comentario) VALUES ('$nome', '$email', '$comentario')";


if ($link->query($query) === TRUE) {
  echo "Novo registro criado com sucesso";
} else {
  echo "Erro: " . $link->error;
}
?>