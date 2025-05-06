## Sistemas de Banco de Dados

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

# **Material Didático: Comandos SELECT em SQL**  

## **1. Introdução**  
O comando **SELECT** é a instrução básica para recuperar informações em um banco de dados relacional. Ele retorna um conjunto de resultados (*result set*) e permite filtrar, ordenar e agrupar dados conforme necessário.  

---

## **2. Estrutura Básica do SELECT**  
```sql
SELECT <lista de atributos e funções>
FROM <lista de tabelas>
[WHERE <condições>]
[GROUP BY <atributos de agrupamento>]
[HAVING <condição de agrupamento>]
[ORDER BY <lista de atributos>];
```

### **Exemplos Simples**  
#### **Selecionando colunas específicas (Projeção)**  
```sql
SELECT nome, rua, bairro FROM empregado;
```

#### **Selecionando todas as colunas**  
```sql
SELECT * FROM empregado;
```

#### **Eliminando duplicatas (DISTINCT)**  
```sql
SELECT DISTINCT salario FROM empregado;
```

---

## **3. Cláusula WHERE (Filtragem de Dados)**  
Permite selecionar registros que atendam a uma condição específica.  

### **Operadores de Comparação**  
| Operador | Significado |  
|----------|------------|  
| `=` | Igual |  
| `>` | Maior que |  
| `<` | Menor que |  
| `>=` | Maior ou igual |  
| `<=` | Menor ou igual |  
| `!=` ou `<>` | Diferente |  
| `!>` | Não maior que |  
| `!<` | Não menor que |  

#### **Exemplos**  
1. **Salários maiores que 3.000**  
   ```sql
   SELECT nome, salario FROM empregado WHERE salario > 3000;
   ```

2. **Empregados do departamento 3 com salário = 2.500**  
   ```sql
   SELECT nome FROM empregado WHERE coddepart = 3 AND salario = 2500;
   ```

3. **Horas trabalhadas acima de 30**  
   ```sql
   SELECT codproj, matricula, horas FROM trabalhaem WHERE horas > 30;
   ```

4. **Dependentes do sexo feminino**  
   ```sql
   SELECT nome, parentesco FROM dependente WHERE sexo = 'F';
   ```

---

## **4. Operadores Especiais**  

### **BETWEEN (Faixas de Valores)**  
```sql
SELECT matricula, nome FROM empregado 
WHERE coddepart BETWEEN 1 AND 4;
```

### **NOT BETWEEN (Fora da Faixa)**  
```sql
SELECT matricula, nome, salario FROM empregado 
WHERE salario NOT BETWEEN 1000 AND 3000;
```

### **LIKE (Correspondência de Texto)**  
| Curinga | Significado |  
|---------|------------|  
| `%` | Qualquer string (0 ou mais caracteres) |  
| `_` | Um único caractere |  
| `[ ]` | Um caractere dentro da faixa |  
| `[^]` | Um caractere fora da faixa |  

#### **Exemplos**  
1. **Nomes que começam com "MAR"**  
   ```sql
   SELECT nome FROM empregado WHERE nome LIKE 'Mar%';
   ```

2. **Nomes com 5 letras começando com "MAR"**  
   ```sql
   SELECT nome FROM empregado WHERE nome LIKE 'Mar__';
   ```

---

## **5. Operadores IN e NOT IN (Listas)**  
```sql
SELECT matricula, nome, bairro 
FROM empregado 
WHERE matricula IN (111, 115, 118);
```

```sql
SELECT matricula, nome, bairro 
FROM empregado 
WHERE matricula NOT IN (1, 2, 3);
```

---

## **6. Operadores Lógicos (AND, OR, NOT)**  
- **AND**: Todas as condições devem ser verdadeiras.  
- **OR**: Pelo menos uma condição deve ser verdadeira.  

#### **Exemplos**  
1. **Departamento 1 OU nome "Administração"**  
   ```sql
   SELECT cod, nome FROM departamento 
   WHERE cod = 1 OR nome = 'Administração';
   ```

2. **Departamento 3 E nome "Informática"**  
   ```sql
   SELECT cod, nome FROM departamento 
   WHERE cod = 3 AND nome = 'Informática';
   ```

---

## **7. Renomeando Colunas e Strings no Resultado**  
```sql
SELECT nome AS "Nome do Empregado" FROM empregado;
```

```sql
SELECT 'Nome:', nome, 'Bairro:', bairro FROM empregado;
```

---

## **8. Expressões Aritméticas**  
| Operador | Função |  
|----------|--------|  
| `+` | Adição |  
| `-` | Subtração |  
| `*` | Multiplicação |  
| `/` | Divisão |  

#### **Exemplos**  
1. **Aumento de 20% no salário**  
   ```sql
   SELECT nome, salario, salario * 1.2 FROM empregado;
   ```

2. **Salário diário (dividido por 30 dias)**  
   ```sql
   SELECT nome, salario / 30 FROM empregado;
   ```

---

## **9. Exercícios Práticos**  
1. **Departamentos sem gerente**  
   ```sql
   SELECT * FROM departamento WHERE gerente IS NULL;
   ```

2. **Empregados admitidos antes de 01/10/1998**  
   ```sql
   SELECT nome FROM empregado WHERE data_admissao < '1998-10-01';
   ```

3. **Projetos com "Engenharia" no nome**  
   ```sql
   SELECT * FROM projeto WHERE nome LIKE '%Engenharia%';
   ```

---


## Para os exemplos abaixo execute os serguintes scripts
```sql
CREATE TABLE departamento (
    cod INT PRIMARY KEY,
    nome VARCHAR(50),
    gerente INT -- pode ser NULL
);

CREATE TABLE empregado (
    matricula INT PRIMARY KEY,
    nome VARCHAR(50),
    rua VARCHAR(100),
    bairro VARCHAR(50),
    salario DECIMAL(10, 2),
    coddepart INT,
    data_admissao DATE,
    FOREIGN KEY (coddepart) REFERENCES departamento(cod)
);

CREATE TABLE trabalhaem (
    codproj INT,
    matricula INT,
    horas INT,
    PRIMARY KEY (codproj, matricula),
    FOREIGN KEY (matricula) REFERENCES empregado(matricula)
);

CREATE TABLE dependente (
    id INT PRIMARY KEY,
    matricula INT,
    nome VARCHAR(50),
    parentesco VARCHAR(50),
    sexo CHAR(1),
    FOREIGN KEY (matricula) REFERENCES empregado(matricula)
);

```

```sql
-- Departamentos
INSERT INTO departamento (cod, nome, gerente) VALUES
(1, 'Administração', NULL),
(2, 'Recursos Humanos', 112),
(3, 'Informática', 115),
(4, 'Financeiro', NULL);

-- Empregados
INSERT INTO empregado (matricula, nome, rua, bairro, salario, coddepart, data_admissao) VALUES
(111, 'Maria', 'Rua A', 'Centro', 2800, 1, '1995-03-15'),
(112, 'Carlos', 'Rua B', 'Jardins', 3200, 2, '1999-07-10'),
(113, 'Joana', 'Rua C', 'Centro', 4500, 3, '1997-01-01'),
(114, 'Marcos', 'Rua D', 'Vila Nova', 2500, 3, '1998-09-15'),
(115, 'Marilene', 'Rua E', 'Centro', 3700, 3, '1996-04-12'),
(116, 'João', 'Rua F', 'Bela Vista', 1200, 4, '2001-02-25'),
(117, 'Marta', 'Rua G', 'Jardins', 3100, 2, '2000-08-08'),
(118, 'Mario', 'Rua H', 'Centro', 900, 1, '2005-06-06');

-- TrabalhaEm
INSERT INTO trabalhaem (codproj, matricula, horas) VALUES
(101, 111, 20),
(102, 112, 35),
(103, 113, 40),
(104, 114, 30),
(105, 115, 32);

-- Dependentes
INSERT INTO dependente (id, matricula, nome, parentesco, sexo) VALUES
(1, 111, 'Ana', 'Filha', 'F'),
(2, 112, 'Pedro', 'Filho', 'M'),
(3, 113, 'Clara', 'Esposa', 'F'),
(4, 114, 'Rita', 'Mãe', 'F');

```


