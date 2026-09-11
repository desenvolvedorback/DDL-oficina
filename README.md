# 🔧 Oficina Mecânica — Banco de Dados

Banco de dados relacional desenvolvido em **MySQL** para gerenciamento básico de uma oficina mecânica, permitindo cadastrar clientes, veículos, mecânicos e registrar os serviços realizados.

## 🗄️ Tecnologias

* **MySQL**
* **SQL**
* Banco de dados relacional
* Chaves primárias e estrangeiras
* `AUTO_INCREMENT`
* Restrições `NOT NULL`

---

## 📌 Estrutura do Banco

O banco de dados utilizado pelo projeto é:

```text
nova_oficina_mecanica_db
```

O sistema possui quatro tabelas principais:

```text
nova_oficina_mecanica_db
│
├── cliente
│
├── veiculo
│     └── id_cliente → cliente.id
│
├── mecanico
│
└── servico
      ├── id_veiculo → veiculo.id
      └── id_mecanico → mecanico.id
```

A tabela `servico` relaciona os **veículos** aos **mecânicos**, enquanto a tabela `veiculo` relaciona cada veículo ao seu respectivo **cliente**.

---

## 👤 Tabela `cliente`

Armazena os dados dos clientes cadastrados na oficina.

| Campo      | Tipo         | Descrição                      |
| ---------- | ------------ | ------------------------------ |
| `id`       | INT          | Identificador único do cliente |
| `nome`     | VARCHAR(100) | Nome completo do cliente       |
| `cpf`      | VARCHAR(15)  | CPF do cliente                 |
| `telefone` | VARCHAR(20)  | Telefone para contato          |
| `email`    | VARCHAR(50)  | E-mail do cliente              |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

O campo `id` identifica cada cliente de forma única e é gerado automaticamente.

---

## 🚗 Tabela `veiculo`

Armazena os veículos cadastrados e relaciona cada veículo ao seu proprietário.

| Campo        | Tipo        | Descrição                             |
| ------------ | ----------- | ------------------------------------- |
| `id`         | INT         | Identificador único do veículo        |
| `id_cliente` | INT         | Identificador do cliente proprietário |
| `placa`      | VARCHAR(10) | Placa do veículo                      |
| `marca`      | VARCHAR(50) | Marca do veículo                      |
| `modelo`     | VARCHAR(50) | Modelo do veículo                     |
| `ano`        | INT         | Ano do veículo                        |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### Chave estrangeira

```sql
FOREIGN KEY (id_cliente) REFERENCES cliente(id)
```

O campo `id_cliente` estabelece o relacionamento entre o veículo e seu proprietário.

### Relação

Um cliente pode possuir **vários veículos**, enquanto cada veículo está associado a um cliente.

```text
cliente 1 ───────── N veiculo
```

---

## 🧑‍🔧 Tabela `mecanico`

Armazena os dados dos mecânicos que trabalham na oficina.

| Campo           | Tipo         | Descrição                       |
| --------------- | ------------ | ------------------------------- |
| `id`            | INT          | Identificador único do mecânico |
| `nome`          | VARCHAR(100) | Nome do mecânico                |
| `especialidade` | VARCHAR(50)  | Especialidade profissional      |
| `telefone`      | VARCHAR(20)  | Telefone para contato           |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

O campo `id` identifica cada mecânico de forma única.

---

## 🔧 Tabela `servico`

Registra os serviços realizados ou registrados para os veículos.

| Campo          | Tipo          | Descrição                             |
| -------------- | ------------- | ------------------------------------- |
| `id`           | INT           | Identificador único do serviço        |
| `id_mecanico`  | INT           | Identificador do mecânico responsável |
| `id_veiculo`   | INT           | Identificador do veículo              |
| `descricao`    | VARCHAR(255)  | Descrição do serviço realizado        |
| `date_entrada` | DATETIME      | Data e horário de entrada             |
| `date_saida`   | DATETIME      | Data e horário de saída               |
| `valor`        | DECIMAL(10,2) | Valor do serviço                      |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### Chaves estrangeiras

O serviço possui duas chaves estrangeiras.

Relacionamento com o mecânico:

```sql
FOREIGN KEY (id_mecanico) REFERENCES mecanico(id)
```

Relacionamento com o veículo:

```sql
FOREIGN KEY (id_veiculo) REFERENCES veiculo(id)
```

Dessa forma, cada serviço fica associado a um **mecânico responsável** e a um **veículo atendido**.

---

## 🔗 Relacionamentos

A estrutura do banco pode ser representada da seguinte forma:

```text
┌──────────────────┐
│     cliente      │
├──────────────────┤
│ id (PK)          │
│ nome             │
│ cpf              │
│ telefone         │
│ email            │
└────────┬─────────┘
         │
         │ 1:N
         ▼
┌──────────────────┐
│     veiculo      │
├──────────────────┤
│ id (PK)          │
│ id_cliente (FK)  │
│ placa            │
│ marca            │
│ modelo           │
│ ano              │
└────────┬─────────┘
         │
         │ 1:N
         ▼
┌──────────────────────┐
│       servico        │
├──────────────────────┤
│ id (PK)              │
│ id_mecanico (FK)     │
│ id_veiculo (FK)      │
│ descricao            │
│ date_entrada         │
│ date_saida           │
│ valor                │
└──────────┬───────────┘
           │
           │ N:1
           ▼
┌──────────────────┐
│     mecanico     │
├──────────────────┤
│ id (PK)          │
│ nome             │
│ especialidade    │
│ telefone         │
└──────────────────┘
```

### Relação `cliente` → `veiculo`

Um cliente pode possuir vários veículos cadastrados.

### Relação `veiculo` → `servico`

Um veículo pode possuir vários serviços registrados ao longo do tempo.

### Relação `mecanico` → `servico`

Um mecânico pode ser responsável por vários serviços.

### Relação `servico` → `veiculo` e `mecanico`

Cada serviço está associado a um veículo e a um mecânico.

---

## ⚙️ Como executar

### 1. Pré-requisitos

É necessário possuir um servidor **MySQL** instalado e em execução.

Algumas opções:

* MySQL Server
* MySQL Workbench
* XAMPP
* WAMP
* Laragon

### 2. Executar o script

Abra seu cliente MySQL e execute o arquivo:

```text
oficina_mecanica.sql
```

O script começa criando o banco:

```sql
CREATE DATABASE IF NOT EXISTS nova_oficina_mecanica_db;
```

> **Observação:** para criar as tabelas dentro do banco corretamente, é recomendado adicionar o comando abaixo após o `CREATE DATABASE`:

```sql
USE nova_oficina_mecanica_db;
```

---

## 🧱 Comandos SQL utilizados

O projeto utiliza principalmente comandos de **DDL (Data Definition Language)**, responsáveis pela definição da estrutura do banco de dados.

### `CREATE DATABASE`

Cria o banco de dados:

```sql
CREATE DATABASE IF NOT EXISTS nova_oficina_mecanica_db;
```

O `IF NOT EXISTS` evita erro caso o banco já exista.

### `CREATE TABLE`

Utilizado para criar as tabelas:

```sql
CREATE TABLE IF NOT EXISTS cliente (...);
CREATE TABLE IF NOT EXISTS veiculo (...);
CREATE TABLE IF NOT EXISTS mecanico (...);
CREATE TABLE IF NOT EXISTS servico (...);
```

### `PRIMARY KEY`

Define o identificador único de cada registro:

```sql
PRIMARY KEY
```

### `AUTO_INCREMENT`

Gera automaticamente um novo ID para cada registro:

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### `FOREIGN KEY`

Estabelece os relacionamentos entre as tabelas:

```sql
FOREIGN KEY (id_cliente) REFERENCES cliente(id)
```

```sql
FOREIGN KEY (id_veiculo) REFERENCES veiculo(id)
```

```sql
FOREIGN KEY (id_mecanico) REFERENCES mecanico(id)
```

### `NOT NULL`

Define campos que não podem ficar sem valor:

```sql
nome VARCHAR(100) NOT NULL
```

---

## 📋 Regras definidas no banco

O banco possui regras para manter a integridade dos dados:

* Cada cliente possui um ID único.
* Cada veículo possui um ID único.
* Cada mecânico possui um ID único.
* Cada serviço possui um ID único.
* Os IDs são gerados automaticamente.
* Os campos definidos como `NOT NULL` são obrigatórios.
* Todo veículo deve estar associado a um cliente existente.
* Todo serviço deve estar associado a um veículo existente.
* Todo serviço deve estar associado a um mecânico existente.
* O valor do serviço utiliza `DECIMAL(10,2)`, permitindo o armazenamento de valores monetários com duas casas decimais.
* As datas de entrada e saída são armazenadas utilizando `DATETIME`.

---

## 📁 Estrutura sugerida do projeto

```text
oficina-mecanica/
│
├── README.md
└── oficina_mecanica.sql
```

O arquivo `oficina_mecanica.sql` contém os comandos responsáveis pela criação da estrutura do banco de dados.

---

## 🎯 Objetivo

O projeto tem como objetivo praticar conceitos fundamentais de **SQL e bancos de dados relacionais**, utilizando como cenário uma oficina mecânica.

Entre os conceitos aplicados estão:

* Criação de banco de dados;
* Criação de tabelas;
* Definição de tipos de dados;
* Chaves primárias;
* Chaves estrangeiras;
* Relacionamentos entre tabelas;
* Integridade referencial;
* `AUTO_INCREMENT`;
* Restrições `NOT NULL`;
* Armazenamento de datas e horários;
* Armazenamento de valores monetários com `DECIMAL`.

---

## 👨‍💻 Autor

**Davi Leonardo**

Projeto desenvolvido para fins de estudo e prática de **SQL, modelagem e gerenciamento de bancos de dados relacionais**.
