## Sistemas de Banco de Dados

Claro, Paula! Aqui está o material desenvolvido de forma mais estruturada e didática, pronto para ser usado em aulas, apresentações ou apostilas:

---

# **Structured Query Language (SQL)**

Structured Query Language (SQL) é a linguagem padrão para manipulação de bancos de dados relacionais. Ela é composta por diversas sublinguagens, cada uma com uma finalidade específica:

---

## **1. DDL (Data Definition Language)**  
Responsável pela **definição da estrutura** do banco de dados, como tabelas, domínios e restrições.

### Comandos principais:
- `CREATE` – Cria objetos (tabelas, domínios, etc).
- `ALTER` – Modifica a estrutura dos objetos existentes.
- `DROP` – Exclui objetos do banco de dados.

---

## **2. DQL (Data Query Language)**  
Utilizada para **consultar** os dados armazenados no banco.

### Comando principal:
- `SELECT` – Recupera dados de uma ou mais tabelas.

---

## **3. DML (Data Manipulation Language)**  
Utilizada para **inserir, atualizar ou excluir dados** nas tabelas.

### Comandos principais:
- `INSERT` – Insere novos registros.
- `UPDATE` – Atualiza dados existentes.
- `DELETE` – Remove dados.

---

## **4. DCL (Data Control Language)**  
Controla os **direitos de acesso e permissões** dos usuários no banco de dados.

### Comandos principais:
- `GRANT` – Concede privilégios.
- `REVOKE` – Remove privilégios.

---

## **5. DTL (Data Transaction Language)**  
Gerencia **transações**, assegurando a integridade dos dados durante operações complexas.

### Comandos principais:
- `BEGIN TRANSACTION` – Inicia uma transação.
- `COMMIT` – Confirma as mudanças.
- `ROLLBACK` – Desfaz alterações.

---

## **Tipos de Dados**

### Numéricos
- `INTEGER`, `SMALLINT`, `TINYINT`
- `FLOAT`, `DOUBLE PRECISION`
- `DECIMAL(i,j)` – para valores com casas decimais formatadas

### Strings
- `CHAR(n)` – comprimento fixo  
- `VARCHAR(n)` – comprimento variável

### Datas e Horários
- `DATE` – formato AAAA-MM-DD  
- `TIME` – formato HH:MM:SS

### Booleanos e Bits
- `BIT(n)` ou `BIT VARYING(n)`

---

## **Criação de Tabelas**

```sql
CREATE TABLE empregado_IS (
  matricula INT,
  nome VARCHAR(20),
  endereco VARCHAR(30),
  depart INT,
  salario DECIMAL(10,2)
);
```

### Definindo Domínios

```sql
CREATE DOMAIN tipo_nome AS CHAR(30);
```

---

## **Restrições de Integridade**

### Integridade de Domínio

- `NULL` – permite valores nulos
- `NOT NULL` – impede valores nulos
- `DEFAULT` – define um valor padrão

```sql
CREATE TABLE Empregado (
  matricula INT NOT NULL,
  nomeemp VARCHAR(20) NOT NULL,
  endereco VARCHAR(30),
  depart INT DEFAULT 1,
  salario DECIMAL(10,2) NOT NULL
);
```

### Integridade de Entidade

```sql
CREATE TABLE Departamento (
  Codigo INTEGER NOT NULL,
  nome VARCHAR(20) NOT NULL,
  matgerente INT,
  CONSTRAINT Pkdepto PRIMARY KEY (Codigo)
);
```

### Integridade Referencial

```sql
CREATE TABLE Empregado (
  matricula INTEGER NOT NULL,
  nome VARCHAR(20) NOT NULL,
  endereco VARCHAR(30),
  depart INT,
  salario DECIMAL(10,2) NOT NULL,
  CONSTRAINT PK_XXT PRIMARY KEY (matricula),
  CONSTRAINT EC_XXT FOREIGN KEY (depart)
    REFERENCES Departamento(Codigo)
    ON DELETE CASCADE
);
```

---

## **Manipulação de Tabelas**

### DROP TABLE
```sql
DROP TABLE Departamento CASCADE;
```

### ALTER TABLE
Adicionar atributo:
```sql
ALTER TABLE Empregado ADD atividade VARCHAR(15);
```

Remover atributo:
```sql
ALTER TABLE Empregado DROP COLUMN atividade CASCADE;
```

Modificar tipo de atributo:
```sql
ALTER TABLE Empregado MODIFY Endereco VARCHAR(50);
```

Adicionar chave estrangeira:
```sql
ALTER TABLE Departamento ADD CONSTRAINT echavedepartamento
FOREIGN KEY (matgerente)
REFERENCES Empregado(matricula)
ON DELETE SET NULL;
```

Remover restrição:
```sql
ALTER TABLE Departamento DROP CONSTRAINT echavedepartamento;
```

---

## **Atividade Prática: Modelagem de Tabelas**

Crie e insira dados nas tabelas abaixo:

### **Empregado**
```sql
CREATE TABLE Empregado (
  Matricula INT PRIMARY KEY,
  nome VARCHAR(50),
  rua VARCHAR(50),
  bairro VARCHAR(30),
  telefone VARCHAR(15),
  datanasc DATE,
  dataadm DATE,
  funcao VARCHAR(30),
  coddepart INT,
  matgerente INT,
  salario DECIMAL(10,2),
  comissao DECIMAL(10,2),
  FOREIGN KEY (coddepart) REFERENCES Departamento(Cod),
  FOREIGN KEY (matgerente) REFERENCES Empregado(Matricula)
);
```

### **Dependente**
```sql
CREATE TABLE Dependente (
  Mat INT,
  num INT,
  nome VARCHAR(50),
  sexo CHAR(1),
  datanasc DATE,
  parentesco VARCHAR(20),
  PRIMARY KEY (Mat, num),
  FOREIGN KEY (Mat) REFERENCES Empregado(Matricula)
);
```

### **Departamento**
```sql
CREATE TABLE Departamento (
  Cod INT PRIMARY KEY,
  nome VARCHAR(30),
  localizacao VARCHAR(30),
  matgerente INT,
  datainicioger DATE,
  FOREIGN KEY (matgerente) REFERENCES Empregado(Matricula)
);
```

### **Projeto**
```sql
CREATE TABLE Projeto (
  Cod INT PRIMARY KEY,
  nome VARCHAR(50),
  situacao VARCHAR(20),
  coddepar INT,
  FOREIGN KEY (coddepar) REFERENCES Departamento(Cod)
);
```

### **TrabalhaEm**
```sql
CREATE TABLE TrabalhaEm (
  Mat INT,
  codproj INT,
  papel VARCHAR(30),
  horas INT,
  PRIMARY KEY (Mat, codproj),
  FOREIGN KEY (Mat) REFERENCES Empregado(Matricula),
  FOREIGN KEY (codproj) REFERENCES Projeto(Cod)
);
```


Perfeito, Paula! Aqui está a continuação do seu material, organizado de forma didática para facilitar a leitura e o uso em aulas ou apostilas:

---

## **Comandos de Manipulação de Dados (DML)**

### `INSERT`
Adiciona uma ou mais linhas em uma tabela existente.

#### Sintaxe:
```sql
INSERT INTO tabela (atributo1, atributo2, ..., atributon)
VALUES (valor1, valor2, ..., valorn);
```

#### Exemplo com colunas específicas:
```sql
INSERT INTO Empregado (matricula, nomeemp, depart, salario)
VALUES (2, 'Jose Lopes', 1, 2500);
```

#### Exemplo com todos os atributos (na ordem da tabela):
```sql
INSERT INTO Empregado
VALUES (1, 'Maria dos Santos', 'Rua Carlos Gomes, n.20', 1, 3000);
```

---

### `DELETE`
Remove uma ou mais linhas de uma tabela com base em uma condição.

#### Sintaxe:
```sql
DELETE FROM tabela WHERE <condição>;
```

#### Exemplos:
- Remove todos os registros:
```sql
DELETE FROM Empregado;
```

- Remove apenas registros com condição específica:
```sql
DELETE FROM Empregado WHERE nome = 'Maria dos Santos';
```

---

### `UPDATE`
Atualiza valores de um ou mais atributos em uma ou mais linhas de uma tabela.

#### Sintaxe:
```sql
UPDATE tabela
SET atributo = novo_valor
WHERE <condição>;
```

#### Exemplos:
- Atualiza salário dos empregados do departamento 1:
```sql
UPDATE Empregado SET salario = 2000 WHERE depart = 1;
```

- Aumenta o salário de todos os empregados em 10%:
```sql
UPDATE Empregado SET salario = salario * 1.1;
```

- Atualiza horas de um funcionário em um projeto:
```sql
UPDATE TrabalhaEm SET horas = 20 WHERE codproj = 01 AND matemp = 11111;
```

---

## **Comandos de Transação (DTL)**

- `COMMIT`: Confirma as alterações feitas na transação atual.
- `ROLLBACK`: Desfaz todas as alterações realizadas na transação atual.

---

## **Consultas de Dados (DQL)**

### `SELECT`
Comando básico para consultar dados armazenados no banco de dados.

#### Sintaxe:
```sql
SELECT <lista de atributos ou funções>
FROM <tabela(s)>
[WHERE <condições>];
```

#### Exemplo básico:
```sql
SELECT nome, salario FROM Empregado WHERE salario > 2000;
```

#### Com uso de funções:
```sql
SELECT COUNT(*), AVG(salario) FROM Empregado;
```
