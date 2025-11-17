CREATE TABLE mensagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(50),
    comentario VARCHAR(100)
);
INSERT INTO mensagens (nome, email, comentario) VALUES ('Mario Ferreira', 'mario@example.com', 'Primeiro comentário!');
