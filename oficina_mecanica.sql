CREATE DATABASE IF NOT EXISTS nova_oficina_mecanica_db;

CREATE TABLE IF NOT EXISTS cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cpf VARCHAR(15) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS veiculo(
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(10) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    foreign key (id_cliente) references cliente (id)
);

CREATE TABLE IF NOT EXISTS mecanico(
id INT AUTO_INCREMENT PRIMARY KEY,
nome varchar(100) NOT NULL,
especialidade varchar(50) NOT NULL,
telefone varchar(20) NOT NULL
);

create table if not exists servico(
id int auto_increment primary key,
id_mecanico int not null,
id_veiculo int not null,
descricao varchar(255) not null,
date_entrada datetime not null,
date_saida datetime not null,
valor decimal(10.2) not null,
foreign key (id_veiculo) references veiculo (id),
foreign key (id_mecanico) references mecanico (id)
);
