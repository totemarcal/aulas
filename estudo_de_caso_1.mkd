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
