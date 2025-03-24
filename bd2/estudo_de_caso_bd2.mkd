## Banco de Dados: Sistema de Pedidos

Este banco de dados foi projetado para registrar e gerenciar as compras feitas por clientes, garantindo que todas as informações sobre os pedidos e os produtos adquiridos sejam devidamente armazenadas e acessíveis para futuras consultas. Ele é composto por quatro tabelas principais: `clientes`, `pedidos`, `produtos` e `itens_pedido`, que se relacionam entre si para fornecer um histórico completo das transações.

### Estrutura das Tabelas

#### 1. Tabela `clientes`
A tabela `clientes` contém os dados cadastrais dos clientes, permitindo a identificação de quem realizou cada pedido.

Campos:
- `id_cliente`: Identificador único do cliente.
- `nome`: Nome completo do cliente.
- `email`: Endereço de e-mail do cliente, que deve ser único.
- `telefone`: Número de telefone para contato.
- `endereco`: Endereço completo do cliente.
- `data_cadastro`: Data e hora em que o cliente foi cadastrado.

```sql
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 2. Tabela `pedidos`
A tabela `pedidos` armazena as informações dos pedidos realizados pelos clientes, vinculando-os à tabela `clientes`.

Campos:
- `id_pedido`: Identificador único do pedido.
- `id_cliente`: Referência ao cliente que fez o pedido.
- `data_pedido`: Data e hora em que o pedido foi realizado.
- `total`: Valor total do pedido.
- `status`: Status do pedido (por exemplo, "Em processamento").

```sql
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
```

#### 3. Tabela `produtos`
A tabela `produtos` armazena os produtos disponíveis para venda.

Campos:
- `id_produto`: Identificador único do produto.
- `nome`: Nome do produto.
- `preco`: Preço unitário do produto.
- `descricao`: Descrição opcional do produto.

```sql
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    descricao TEXT
);
```

#### 4. Tabela `itens_pedido`
A tabela `itens_pedido` registra os produtos incluídos em cada pedido, possibilitando o detalhamento do que foi comprado.

Campos:
- `id_item`: Identificador único do item no pedido.
- `id_pedido`: Referência ao pedido ao qual o item pertence.
- `id_produto`: Referência ao produto adquirido.
- `quantidade`: Quantidade do produto no pedido.
- `subtotal`: Valor total do item no pedido (quantidade multiplicada pelo preço unitário).

```sql
CREATE TABLE itens_pedido (
    id_item INT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
```

### Consultas SQL

#### 1. Listar os pedidos e seus clientes (INNER JOIN)
```sql
SELECT pedidos.id_pedido, clientes.nome, pedidos.data_pedido, pedidos.total 
FROM pedidos 
INNER JOIN clientes ON pedidos.id_cliente = clientes.id_cliente;
```

#### 2. Obter os itens de um pedido específico junto com os detalhes do cliente e dos produtos (INNER JOIN)
```sql
SELECT clientes.nome, pedidos.id_pedido, produtos.nome AS produto, itens_pedido.quantidade, itens_pedido.subtotal
FROM itens_pedido
INNER JOIN pedidos ON itens_pedido.id_pedido = pedidos.id_pedido
INNER JOIN clientes ON pedidos.id_cliente = clientes.id_cliente
INNER JOIN produtos ON itens_pedido.id_produto = produtos.id_produto
WHERE pedidos.id_pedido = 1;
```

#### 3. Listar todos os clientes e seus pedidos, incluindo aqueles que ainda não fizeram pedidos (LEFT JOIN)
```sql
SELECT clientes.nome, pedidos.id_pedido, pedidos.total 
FROM clientes 
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;
```

#### 4. Listar todos os pedidos e seus clientes, incluindo pedidos sem clientes (RIGHT JOIN)
```sql
SELECT pedidos.id_pedido, clientes.nome, pedidos.total 
FROM pedidos 
RIGHT JOIN clientes ON pedidos.id_cliente = clientes.id_cliente;
```

#### 5. Listar todos os clientes e seus pedidos, mostrando também os clientes sem pedidos e pedidos sem clientes (FULL JOIN)
```sql
SELECT clientes.nome, pedidos.id_pedido, pedidos.total 
FROM clientes 
FULL JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;
```
 

#### 6. Liste todos os produtos que nunca foram comprados. (LEFT JOIN)

```sql
SELECT p.id_produto, p.nome
FROM produtos p
LEFT JOIN itens_pedido ip ON p.id_produto = ip.id_produto
WHERE ip.id_produto IS NULL;
```

#### 7. Liste todos os clientes que nunca fizeram um pedido. (LEFT JOIN)
```sql
SELECT c.id_cliente, c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;
```

#### 8. Quais são os pedidos que possuem pelo menos um item cadastrado? (INNER JOIN)
```sql
SELECT DISTINCT p.id_pedido, p.status
FROM pedidos p
INNER JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido;

```

#### 9. Liste todos os pedidos, mesmo aqueles sem itens. (LEFT JOIN)
```sql
SELECT p.id_pedido, p.status
FROM pedidos p
LEFT JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido;
```


#### 10. Liste todos os produtos e os pedidos em que foram comprados, incluindo produtos nunca vendidos. (LEFT JOIN)
```sql
SELECT p.id_produto, p.nome, p.preco, pd.id_pedido
FROM produtos p
LEFT JOIN itens_pedido ip ON p.id_produto = ip.id_produto
LEFT JOIN pedidos pd ON ip.id_pedido = pd.id_pedido;
```


#### 11. Liste todos os produtos comprados em um determinado período de tempo. (INNER JOIN com filtro de data)
```sql
SELECT p.id_produto, p.nome, ip.quantidade, ip.subtotal
FROM itens_pedido ip
INNER JOIN pedidos pe ON ip.id_pedido = pe.id_pedido
INNER JOIN produtos p ON ip.id_produto = p.id_produto
WHERE pe.data_pedido BETWEEN '2025-01-01' AND '2025-01-31';
```


#### 12. Liste todos os clientes e os produtos que compraram, incluindo clientes que nunca compraram nada. (LEFT JOIN)
```sql
SELECT c.id_cliente, c.nome, p.id_produto, p.nome AS produto
FROM clientes c
LEFT JOIN pedidos pd ON c.id_cliente = pd.id_cliente
LEFT JOIN itens_pedido ip ON pd.id_pedido = ip.id_pedido
LEFT JOIN produtos p ON ip.id_produto = p.id_produto;
```


#### 13. Quais clientes fizeram pedidos e quais pedidos não possuem clientes registrados? (FULL JOIN)
```sql
SELECT c.id_cliente, c.nome, p.id_pedido, p.status
FROM clientes c
FULL JOIN pedidos p ON c.id_cliente = p.id_cliente;
```


#### 14. Liste todos os pedidos e os produtos neles, incluindo pedidos sem produtos. (LEFT JOIN)
```sql
SELECT p.id_pedido, p.status, ip.id_produto, prod.nome
FROM pedidos p
LEFT JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
LEFT JOIN produtos prod ON ip.id_produto = prod.id_produto;
```


### Subconsultas

#### 1. **Obter o total de um pedido específico com base no id_cliente (Subconsulta)**

A subconsulta retorna o total de um pedido específico para um determinado cliente. Caso o cliente tenha vários pedidos, a subconsulta calcula o total de cada um.

```sql
SELECT nome, email, 
    (SELECT SUM(subtotal) FROM itens_pedido 
     WHERE id_pedido = p.id_pedido) AS total_pedido
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE c.id_cliente = 1;
```

#### 2. Obter os clientes que realizaram pedidos com total superior a um valor específico (Subconsulta no WHERE)
Aqui, a subconsulta é usada para verificar se o total de um pedido supera um valor específico, retornando apenas os clientes que atenderam a essa condição.
```sql
SELECT nome, email
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM pedidos
    WHERE total > 200
);
```

#### 3.  Listar os produtos que não foram comprados em nenhum pedido (Subconsulta com NOT EXISTS)
```sql
SELECT nome
FROM produtos p
WHERE NOT EXISTS (
    SELECT 1
    FROM itens_pedido i
    WHERE i.id_produto = p.id_produto
);
```

#### 4. Listar os clientes que nunca fizeram um pedido (Subconsulta com NOT EXISTS)
```sql
SELECT nome, email
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.id_cliente = c.id_cliente
);
```

#### 5. Obter os produtos mais vendidos (Subconsulta no SELECT)
```sql
SELECT nome, 
       (SELECT SUM(quantidade) 
        FROM itens_pedido 
        WHERE id_produto = p.id_produto) AS total_vendido
FROM produtos p
ORDER BY total_vendido DESC;
```
#### 6. Listar pedidos com produtos que não estão mais disponíveis (Subconsulta com NOT IN)
```sql
SELECT p.id_pedido, i.produto, i.quantidade
FROM pedidos p
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
WHERE i.id_produto NOT IN (
    SELECT id_produto
    FROM produtos
    WHERE descricao IS NOT NULL
);
```

#### 7. Obter o total de pedidos feitos por cliente (Subconsulta no SELECT)
```sql
SELECT c.nome, 
    (SELECT COUNT(*) 
     FROM pedidos 
     WHERE id_cliente = c.id_cliente) AS total_pedidos
FROM clientes c;
```

#### 8. Obter o cliente que fez o pedido de maior valor (Subconsulta com LIMIT)
```sql
SELECT nome, email
FROM clientes
WHERE id_cliente = (
    SELECT id_cliente
    FROM pedidos
    ORDER BY total DESC
    LIMIT 1
);
```

#### 9. Listar todos os pedidos e seus itens, incluindo produtos de pedidos sem itens (Subconsulta com LEFT JOIN)
```sql
SELECT p.id_pedido, 
       (SELECT nome FROM produtos WHERE id_produto = i.id_produto) AS produto, 
       i.quantidade
FROM pedidos p
LEFT JOIN itens_pedido i ON p.id_pedido = i.id_pedido;
```

#### 10. Obter a soma total de todos os pedidos de um cliente (Subconsulta no SELECT)
```sql
SELECT nome, 
       (SELECT SUM(total) 
        FROM pedidos 
        WHERE id_cliente = c.id_cliente) AS total_compras
FROM clientes c
WHERE c.id_cliente = 1;
```

# Visões em Banco de Dados

## Definição
Uma **visão** é uma tabela virtual cujo conteúdo é definido por uma consulta SQL. Ela não possui existência física, ou seja, não armazena dados próprios. Em vez disso, a visão é derivada de uma ou mais tabelas ou outras visões. Sua existência se resume à sua definição, que é armazenada como uma consulta `SELECT`. O conteúdo da visão é calculado dinamicamente no momento em que é referenciada.

---

## Características
1. **Não possui existência física**:
   - A visão não armazena dados diretamente. Ela apenas armazena a definição da consulta SQL.
   - Os dados são gerados dinamicamente quando a visão é consultada.

2. **Derivada de tabelas ou outras visões**:
   - Uma visão pode ser criada a partir de uma ou mais tabelas ou outras visões existentes.
   - Exemplo: Uma visão pode combinar dados de duas tabelas relacionadas.

3. **Conteúdo calculado no momento**:
   - Sempre que a visão é consultada, o banco de dados executa a consulta SQL associada e retorna os resultados.

4. **Referenciada em comandos SQL**:
   - Os usuários podem utilizar a visão referenciando seu nome na cláusula `FROM` de comandos SQL-DML (SELECT, INSERT, UPDATE, DELETE).

---

## Utilização
As visões são amplamente utilizadas por oferecerem benefícios significativos:

1. **Independência lógica de dados**:
   - Permite que os usuários acessem dados sem precisar conhecer a estrutura física do banco de dados.
   - Exemplo: Se a estrutura física de uma tabela mudar, a visão pode ser ajustada para manter a compatibilidade com as aplicações existentes.

2. **Segurança**:
   - Restringe o acesso a determinados dados, expondo apenas o necessário.
   - Exemplo: Uma visão pode mostrar apenas os dados de um departamento específico, ocultando informações sensíveis de outros departamentos.

3. **Simplicidade**:
   - Facilita consultas complexas, encapsulando-as em uma visão.
   - Exemplo: Em vez de escrever uma consulta complexa repetidamente, o usuário pode simplesmente consultar a visão.

4. **Flexibilidade**:
   - Permite a reutilização de consultas e a adaptação às necessidades dos usuários.
   - Exemplo: Diferentes visões podem ser criadas para diferentes tipos de usuários, como gerentes e funcionários.

---

## Sintaxe para Criação de Visões
A sintaxe básica para criar uma visão é a seguinte:

```sql
CREATE VIEW <nome da visão> [(atributo1, atributo2, ...)]
AS SELECT ...
[WITH CHECK OPTION];
```

- **WITH CHECK OPTION**: Garante que as modificações (INSERT, UPDATE, DELETE) realizadas na visão não violem os critérios da cláusula `WHERE` do `SELECT`.

---

## Exemplo de Criação de Visão

### Tabelas Base
Antes de criar uma visão, é necessário criar as tabelas base. Vamos criar as tabelas `Departamento` e `Empregado`:

#### Tabela `Departamento`
```sql
CREATE TABLE Departamento (
    cod INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
```
```sql
INSERT INTO Departamento (cod, nome) VALUES
(1, 'Vendas'),
(2, 'TI'),
(3, 'Recursos Humanos'),
(4, 'Financeiro');
```

#### Tabela `Empregado`
```sql
CREATE TABLE Empregado (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    funcao VARCHAR(50),
    salario DECIMAL(10, 2),
    comissao DECIMAL(10, 2),
    coddepart INT,
    FOREIGN KEY (coddepart) REFERENCES Departamento(cod)
);
```

```sql
INSERT INTO Empregado (matricula, nome, funcao, salario, comissao, coddepart) VALUES
(101, 'João Silva', 'Analista', 5000.00, 1000.00, 2),
(102, 'Maria Oliveira', 'Gerente', 8000.00, 2000.00, 1),
(103, 'Carlos Souza', 'Programador', 4500.00, 800.00, 2),
(104, 'Ana Costa', 'Analista', 5500.00, 1200.00, 2),
(105, 'Pedro Rocha', 'Assistente', 2500.00, 500.00, 3),
(106, 'Fernanda Lima', 'Analista', 6000.00, 1500.00, 4),
(107, 'Ricardo Santos', 'Programador', 4000.00, 900.00, 2),
(108, 'Juliana Alves', 'Analista', 5200.00, 1100.00, 1);
```

### Visão `InfoDepart`
Agora, vamos criar uma visão que mostra o nome do departamento, o total de empregados e a soma dos salários por departamento:

```sql
CREATE VIEW InfoDepart (NomeDepart, TotEmpregados, TotSalarios)
AS
SELECT d.nome, COUNT(*), SUM(e.salario)
FROM Departamento d, Empregado e
WHERE d.cod = e.coddepart
GROUP BY d.nome;
```

---

## Atualizações sobre Visões - Limitações
As operações de atualização (INSERT, UPDATE, DELETE) em visões têm algumas limitações:

1. **WITH CHECK OPTION**:
   - Garante que as atualizações não violem as condições impostas na cláusula `WHERE` da visão.
   - Exemplo: Se a visão filtra empregados com salário maior que R$ 3000, o `WITH CHECK OPTION` impede a inserção de um empregado com salário menor.

2. **INSERT**:
   - Pode ser executado em visões que manipulem apenas uma tabela.
   - Todos os atributos `NOT NULL` da tabela base devem estar presentes na visão.
   - Exemplo: Se a tabela base exige que o campo `salario` seja `NOT NULL`, a visão deve incluir esse campo para permitir inserções.

3. **UPDATE**:
   - Pode ser executado em visões que manipulem apenas uma tabela.
   - Em visões que envolvem múltiplas tabelas, o comando `UPDATE` só pode afetar atributos de uma única tabela.

4. **DELETE**:
   - Pode ser executado em visões que manipulem uma única tabela.

---

## Eliminação de Visões
Para eliminar uma visão, utiliza-se o comando:

```sql
DROP VIEW <nome da visão>;
```

Exemplo:
```sql
DROP VIEW InfoDepart;
```

---

## Exercícios

### Exercício 1
Crie uma visão contendo matrícula, nome e função dos empregados com a função "Analista".

#### Script da Visão
```sql
CREATE VIEW Analista AS
SELECT matricula, nome, funcao, Salario, Comissao
FROM Empregado
WHERE funcao = 'Analista'
WITH CHECK OPTION;
```

#### Teste de Atualização
```sql
UPDATE Analista 
SET funcao = 'Programador' 
WHERE matricula = 117;
```
**Resultado**: Erro, pois viola a cláusula `WHERE` da visão devido ao `WITH CHECK OPTION`.

#### Teste de Inserção
```sql
INSERT INTO Analista (matricula, nome, funcao) 
VALUES (222, 'Carlos Antonio', 'Analista');
```
**Resultado**: Erro, pois os atributos `Salario` e `Comissao` são obrigatórios (`NOT NULL`).

---

### Exercício 2
Crie uma visão (`MaioresSalarios`) contendo a matrícula, função, salário e comissão dos empregados que ganham mais de R$ 3000, utilizando a opção `WITH CHECK OPTION`.

#### Script da Visão
```sql
CREATE VIEW MaioresSalarios AS
SELECT matricula, funcao, salario, comissao
FROM Empregado
WHERE salario > 3000
WITH CHECK OPTION;
```

#### Teste de Inserção
```sql
INSERT INTO MaioresSalarios (matricula, funcao, salario, comissao)
VALUES (999, 'Analista', 3500, 400);
```
**Resultado**: O comando será executado com sucesso, pois os valores inseridos atendem à condição `salario > 3000` definida na visão. O `WITH CHECK OPTION` garante que a inserção não viole a cláusula `WHERE`.

---

## Considerações Finais
As visões são ferramentas poderosas para simplificar consultas, garantir segurança e proporcionar flexibilidade no acesso aos dados. No entanto, é importante estar ciente das limitações ao realizar operações de atualização, inserção e exclusão em visões. A criação das tabelas base (`Departamento` e `Empregado`) é essencial para que os exemplos funcionem corretamente. Com o uso adequado, as visões podem melhorar significativamente a eficiência e a segurança do banco de dados.

--- 

### Trigger

1. Trigger: Atualiza o status do pedido quando o total for alterado

Este exercício cria uma Trigger que será acionada toda vez que o total de um pedido (total) for alterado. Se o valor total do pedido for maior que 500, o status do pedido será alterado para "Em Processamento", caso contrário, será alterado para "Aguardando Pagamento".

```sql
CREATE OR REPLACE TRIGGER atualiza_status_pedido
AFTER UPDATE OF total ON pedidos
FOR EACH ROW
BEGIN
    IF :NEW.total > 500 THEN
        UPDATE pedidos
        SET status = 'Em Processamento'
        WHERE id_pedido = :NEW.id_pedido;
    ELSE
        UPDATE pedidos
        SET status = 'Aguardando Pagamento'
        WHERE id_pedido = :NEW.id_pedido;
    END IF;
END atualiza_status_pedido;

```

### Mysql

```sql

DELIMITER $$

CREATE TRIGGER atualiza_status_pedido
BEFORE  UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.total > 500 THEN
        SET NEW.status = 'Em Processamento';
    ELSE
        SET NEW.status = 'Aguardando';
    END IF;
END $$

DELIMITER ;
```

#### Principais mudanças:

- Mudança de AFTER UPDATE para BEFORE UPDATE: No MySQL, AFTER UPDATE não pode modificar a mesma tabela que acionou a trigger. BEFORE UPDATE permite modificar a linha antes que o UPDATE finalize.

- Uso correto de NEW: Em MySQL, usamos SET NEW.campo = valor para alterar os valores antes de serem escritos no banco. Em Oracle, usamos :NEW.campo, mas no MySQL, os dois pontos (:) não são necessários.

- Removemos UPDATE pedidos SET ... WHERE id_pedido = :NEW.id_pedido; Em Oracle, você precisaria de um UPDATE, mas no MySQL, podemos modificar NEW.status diretamente.

2. Trigger: Impede a exclusão de um cliente se ele tiver pedidos
Esta trigger impedirá a exclusão de um cliente da tabela clientes se ele tiver feito um ou mais pedidos. Ela verifica se o cliente possui registros na tabela pedidos antes de permitir a exclusão

```sql
CREATE OR REPLACE TRIGGER impede_exclusao_cliente
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    DECLARE
        v_count INTEGER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM pedidos
        WHERE id_cliente = :OLD.id_cliente;
        
        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Não é possível excluir o cliente. Ele possui pedidos associados.');
        END IF;
    END;
END impede_exclusao_cliente;
```

3. Procedure: Atualiza o preço de um produto
Aqui está um exemplo de Procedure que permite ajustar o preço de um produto com base em um percentual informado. A procedure recebe dois parâmetros: o id_produto e o percentual de reajuste.

```sql
CREATE OR REPLACE PROCEDURE reajustar_preco_produto (
    p_id_produto INT,
    p_percentual DECIMAL
) AS
BEGIN
    UPDATE produtos
    SET preco = preco + (preco * p_percentual / 100)
    WHERE id_produto = p_id_produto;
    COMMIT;
END reajustar_preco_produto;

```

#### MySql

```sql
DELIMITER $$

CREATE PROCEDURE reajustar_preco_produto (
    IN p_id_produto INT,
    IN p_percentual DECIMAL(10,2)
)
BEGIN
    UPDATE produtos
    SET preco = preco + (preco * p_percentual / 100)
    WHERE id_produto = p_id_produto;
    
    COMMIT;
END $$

DELIMITER ;
```

- Uso de DELIMITER: O MySQL usa ; como delimitador padrão. Para evitar conflitos dentro do CREATE PROCEDURE, trocamos temporariamente o delimitador para $$ ou outro símbolo.
- IN antes dos parâmetros: No MySQL, os parâmetros precisam de um prefixo (IN, OUT ou INOUT).
- Remoção de AS: O MySQL não usa AS antes de BEGIN em PROCEDURE.
- Correção da definição do tipo DECIMAL: Defini um tamanho (DECIMAL(10,2)) para evitar problemas.

```sql
CALL reajustar_preco_produto(1, 10);
```

4. Procedure: Registra um novo pedido
Esta Procedure cria um novo pedido e insere os itens correspondentes. Ela recebe o id_cliente e um array de produtos com suas quantidades.

```sql
CREATE OR REPLACE PROCEDURE registrar_pedido (
    p_id_cliente INT,
    p_produtos IN SYS.ODCINUMBERLIST, -- Tipo de dado para armazenar lista de números (ID dos produtos)
    p_quantidades IN SYS.ODCINUMBERLIST -- Tipo de dado para armazenar lista de quantidades
) AS
    v_id_pedido INT;
    v_total DECIMAL(10,2) := 0;
BEGIN
    -- Insere o pedido na tabela pedidos
    INSERT INTO pedidos (id_cliente, total, status)
    VALUES (p_id_cliente, 0, 'Aguardando Pagamento')
    RETURNING id_pedido INTO v_id_pedido;
    
    -- Insere os itens do pedido
    FOR i IN 1..p_produtos.COUNT LOOP
        INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, subtotal)
        VALUES (v_id_pedido, p_produtos(i), p_quantidades(i), p_quantidades(i) * (SELECT preco FROM produtos WHERE id_produto = p_produtos(i)));
        
        -- Calcula o total do pedido
        SELECT preco * p_quantidades(i) INTO v_total
        FROM produtos
        WHERE id_produto = p_produtos(i);
    END LOOP;
    
    -- Atualiza o total do pedido
    UPDATE pedidos
    SET total = v_total
    WHERE id_pedido = v_id_pedido;
    
    COMMIT;
END registrar_pedido;

```