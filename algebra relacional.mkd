# Modelo Relacional

## Revisão

### Banco de Dados - Álgebra Relacional

> "Conjunto básico de operações do modelo relacional, que possibilitam especificar solicitações básicas de recuperação. O resultado de uma recuperação é uma nova relação, que pode ter sido formada a partir de uma ou mais relações." - **Elsmari & Navathe**

## Álgebra Relacional

### Introdução

A álgebra relacional é um sistema formal de manipulação de dados baseado na teoria dos conjuntos. Ela fornece um conjunto de operações que permitem consultar e modificar dados armazenados em bancos de dados relacionais. Cada operação recebe uma ou mais relações como entrada e produz uma nova relação como saída.

Os operadores da álgebra relacional podem ser classificados em:

- **Operadores fundamentais**: Seleção, projeção, produto cartesiano, união e diferença.
- **Operadores derivados**: Interseção, junção e divisão.

Esses operadores são fundamentais para a manipulação e recuperação de informações dentro de um banco de dados.

**Exercícios:**
1. Explique a diferença entre operadores fundamentais e derivados na álgebra relacional.
2. Cite três operações da álgebra relacional e descreva seu funcionamento.

---

## Operações da Álgebra Relacional

### **Seleção (Restrição)** - Detalhamento

A operação de **seleção** é uma das operações fundamentais da Álgebra Relacional. Ela é representada pelo símbolo **σ** (sigma) e serve para **filtrar** as tuplas (linhas) de uma relação (tabela) que atendem a uma condição específica. A operação retorna um subconjunto da relação original, contendo apenas as tuplas que satisfazem a condição fornecida.

A forma geral de uma operação de seleção é:

```
σ<condição>(R)
```

Onde:
- **σ** é o operador de seleção.
- **condição** é a condição de filtragem que as tuplas devem atender.
- **R** é a relação (tabela) de onde as tuplas serão extraídas.

### Características da Seleção:
- **Preserva as colunas**: A operação de seleção **não modifica** as colunas da tabela original, ela apenas retorna as tuplas que atendem à condição especificada.
- **Aplica uma condição**: A condição é uma expressão lógica que pode envolver os valores das colunas e operadores como igual ( = ), maior que ( > ), menor que ( < ), entre outros.
- **Retorna um conjunto de tuplas**: O resultado da operação de seleção é uma nova relação que contém as tuplas da tabela original que atendem à condição.

### Exemplo Prático

#### 1. **Seleção Simples**
Vamos utilizar o banco de dados do exemplo anterior, onde temos a tabela `Clientes`. Digamos que queremos **selecionar todos os clientes da cidade de "Salvador"**.

**Operação**:
```sql
σ(Cidade = 'Salvador')(Clientes)
```

**Resultado**:

| ClienteID | Nome   | Cidade   |
|-----------|--------|----------|
| 1         | João   | Salvador |
| 3         | José   | Salvador |

Aqui, a seleção foi aplicada para filtrar apenas os clientes cujas tuplas possuem a cidade igual a "Salvador".

#### 2. **Seleção com Múltiplas Condições**
Agora, vamos adicionar mais uma condição à seleção. Digamos que queremos **selecionar todos os pedidos feitos pelos clientes de "Salvador" com valor superior a 1500**.

**Operação**:
```sql
σ(Cidade = 'Salvador' AND Valor > 1500)(Clientes ⨝ Pedidos)
```

**Resultado**:

| ClienteID | Nome   | Cidade   | PedidoID | ProdutoID | Produto    | Valor | DataPedido  |
|-----------|--------|----------|----------|-----------|------------|-------|-------------|
| 1         | João   | Salvador | 101      | 201       | Laptop     | 3000  | 2025-03-01  |

Neste exemplo, a operação de seleção usa duas condições:
1. Filtra os clientes da cidade "Salvador".
2. Filtra os pedidos cujo valor é maior que 1500.

#### 3. **Seleção por Intervalo**
Outra possibilidade é usar uma condição para selecionar tuplas dentro de um intervalo de valores. Por exemplo, vamos **selecionar todos os pedidos com valores entre 1000 e 2000**.

**Operação**:
```sql
σ(Valor >= 1000 AND Valor <= 2000)(Pedidos)
```

**Resultado**:

| PedidoID | ClienteID | ProdutoID | FuncionarioID | DataPedido  | Valor |
|----------|-----------|-----------|---------------|-------------|-------|
| 103      | 3         | 203       | 301           | 2025-03-03  | 1200  |
| 104      | 4         | 204       | 303           | 2025-03-04  | 2000  |

Neste caso, a condição filtra os pedidos cujo valor está entre 1000 e 2000.

#### 4. **Seleção com Comparação de Data**
Você também pode fazer seleções com base em uma condição de data. Vamos **selecionar todos os pedidos feitos antes de 2025-03-03**.

**Operação**:
```sql
σ(DataPedido < '2025-03-03')(Pedidos)
```

**Resultado**:

| PedidoID | ClienteID | ProdutoID | FuncionarioID | DataPedido  | Valor |
|----------|-----------|-----------|---------------|-------------|-------|
| 101      | 1         | 201       | 301           | 2025-03-01  | 3000  |
| 102      | 2         | 202       | 302           | 2025-03-02  | 1500  |

Neste exemplo, a seleção retorna os pedidos feitos antes de uma data específica.

#### 5. **Seleção em Tabelas com Junção**
Podemos realizar a operação de seleção após uma junção de várias tabelas. Suponha que queremos **selecionar todos os pedidos feitos por clientes de Salvador, que foram processados por funcionários com o cargo "Vendedor"**.

**Operação**:
```sql
σ(Cidade = 'Salvador' AND Cargo = 'Vendedor')(Clientes ⨝ Pedidos ⨝ Funcionários)
```

**Resultado**:

| ClienteID | Nome   | Cidade   | PedidoID | ProdutoID | Produto    | Valor | DataPedido  | FuncionarioID | NomeFuncionario | Cargo    |
|-----------|--------|----------|----------|-----------|------------|-------|-------------|---------------|-----------------|----------|
| 1         | João   | Salvador | 101      | 201       | Laptop     | 3000  | 2025-03-01  | 301           | Carlos          | Vendedor |
| 3         | José   | Salvador | 103      | 203       | Tablet     | 1200  | 2025-03-03  | 301           | Carlos          | Vendedor |

Neste exemplo, usamos a junção entre as tabelas `Clientes`, `Pedidos` e `Funcionários` e, em seguida, aplicamos a seleção para filtrar os clientes da cidade "Salvador" que foram atendidos por um funcionário com cargo "Vendedor".

### Importância da Seleção na Álgebra Relacional

A operação de **seleção** é fundamental para realizar consultas específicas no banco de dados, permitindo que você extraia apenas os dados que atendem a critérios definidos. Em sistemas de gerenciamento de banco de dados, as seleções são frequentemente usadas para criar consultas dinâmicas que filtram dados conforme as necessidades do usuário. Ela é uma das operações mais comuns e utilizadas em SQL, onde é representada pela cláusula **WHERE**.

### Performance da Seleção
A seleção, especialmente em grandes conjuntos de dados, pode impactar a performance de uma consulta. O uso de índices apropriados nas colunas filtradas pode acelerar significativamente a execução da operação de seleção, pois permite que o banco de dados localize rapidamente as tuplas que atendem à condição sem ter que examinar cada uma delas.


Com isso, a operação de **Seleção (Restrição)** na Álgebra Relacional se revela uma ferramenta essencial para realizar filtragens eficazes de dados em um banco de dados, tanto de maneira simples quanto complexa, permitindo consultas e extrações precisas de informações.

**Exemplos:**
1. Selecione os empregados que ganham mais de R$ 3.000,00:
```markdown
σ salario > 3000 (Empregado)
```
2. Selecione os clientes que possuem telefone cadastrado:
```markdown
σ telefone IS NOT NULL (Cliente)
```

**Exercícios:**
1. Selecione todos os empregados do departamento de TI.
2. Liste os filmes lançados após o ano 2000.

---

### **Projeção (π)** - Detalhamento

A **projeção** (π) é uma operação que retorna um subconjunto de **atributos** (colunas) de uma relação (tabela). Diferente da operação de **seleção**, que filtra tuplas com base em uma condição, a **projeção** escolhe apenas as **colunas relevantes**, descartando as demais.

A forma geral de uma operação de projeção é:

```
π<atributos>(R)
```

Onde:
- **π** é o operador de projeção.
- **atributos** é uma lista de atributos (colunas) que você deseja incluir no resultado.
- **R** é a relação (tabela) da qual as colunas serão projetadas.

### Características da Projeção:
- **Reduz o número de colunas**: A operação de projeção retira as colunas que não são especificadas na lista de atributos.
- **Não altera as tuplas**: A projeção mantém todas as tuplas que atendem à condição de incluir apenas os atributos desejados. Ou seja, o número de linhas da relação pode se manter o mesmo, mas o número de colunas será reduzido.
- **Elimina duplicatas**: Quando a projeção resulta em uma coluna que possui valores repetidos, ela elimina as duplicatas, retornando apenas valores distintos.

### Exemplo Prático

#### 1. **Projeção Simples**
Suponha que temos a seguinte tabela `Clientes` e queremos **projetar apenas o nome e a cidade** dos clientes:

**Tabela: Clientes**

| ClienteID | Nome   | Cidade   |
|-----------|--------|----------|
| 1         | João   | Salvador |
| 2         | Maria  | São Paulo|
| 3         | José   | Salvador |
| 4         | Ana    | Rio de Janeiro |

**Operação de Projeção**:
```sql
π(Nome, Cidade)(Clientes)
```

**Resultado**:

| Nome   | Cidade       |
|--------|--------------|
| João   | Salvador     |
| Maria  | São Paulo    |
| José   | Salvador     |
| Ana    | Rio de Janeiro|

Neste exemplo, a projeção extrai apenas as colunas `Nome` e `Cidade` da tabela `Clientes`. O número de colunas na tabela resultante é reduzido de 3 para 2, mas o número de linhas permanece o mesmo.

#### 2. **Projeção com Eliminação de Duplicatas**
Agora, vamos projetar a coluna **Cidade** da tabela `Clientes`. Note que algumas cidades se repetem. O resultado da projeção vai eliminar as duplicatas e devolver apenas valores distintos.

**Operação de Projeção**:
```sql
π(Cidade)(Clientes)
```

**Resultado**:

| Cidade       |
|--------------|
| Salvador     |
| São Paulo    |
| Rio de Janeiro|

Como a coluna `Cidade` possui valores duplicados (Salvador), a projeção elimina as duplicatas e retorna apenas as cidades únicas.

#### 3. **Projeção Após Junção**
A projeção pode ser utilizada após uma operação de **junção** (como o **produto cartesiano** ou **junção natural**) para extrair apenas os atributos necessários de várias relações.

Suponha que temos as tabelas `Clientes` e `Pedidos`, e queremos projetar o nome dos clientes junto com os IDs dos seus pedidos.

**Tabela: Pedidos**

| PedidoID | ClienteID | ProdutoID | Valor |
|----------|-----------|-----------|-------|
| 101      | 1         | 201       | 3000  |
| 102      | 2         | 202       | 1500  |
| 103      | 3         | 203       | 1200  |

**Operação de Junção e Projeção**:
```sql
π(Nome, PedidoID)(Clientes ⨝ Pedidos)
```

**Resultado**:

| Nome   | PedidoID |
|--------|----------|
| João   | 101      |
| Maria  | 102      |
| José   | 103      |

Neste exemplo, a operação de **junção** entre as tabelas `Clientes` e `Pedidos` é realizada com base no atributo `ClienteID`, e, em seguida, a **projeção** seleciona apenas as colunas `Nome` e `PedidoID` das tuplas resultantes.

#### 4. **Projeção com Colunas de Tabelas Diferentes**
Vamos fazer uma projeção em uma relação que resulta de múltiplas junções. Suponha que temos as tabelas `Clientes`, `Pedidos`, e `Funcionários` e queremos projetar o nome do cliente, o nome do funcionário e o valor do pedido.

**Operação de Junção e Projeção**:
```sql
π(NomeCliente, NomeFuncionario, Valor)(Clientes ⨝ Pedidos ⨝ Funcionários)
```

**Resultado**:

| NomeCliente | NomeFuncionario | Valor |
|-------------|-----------------|-------|
| João        | Carlos          | 3000  |
| Maria       | Ana             | 1500  |
| José        | Carlos          | 1200  |

Aqui, a junção entre as três tabelas é feita, e a projeção retorna apenas os atributos `NomeCliente`, `NomeFuncionario` e `Valor` dos pedidos.

#### 5. **Projeção com Operadores de Comparação**
Outra forma de usar a projeção é associá-la com outras operações, como a **seleção**. Por exemplo, podemos primeiro selecionar pedidos com valor maior que 1500 e depois projetar apenas os **IDs dos pedidos** e **nomes dos clientes**.

**Operação de Seleção e Projeção**:
```sql
π(Nome, PedidoID)(σ(Valor > 1500)(Clientes ⨝ Pedidos))
```

**Resultado**:

| Nome   | PedidoID |
|--------|----------|
| João   | 101      |

Aqui, a **seleção** é aplicada para filtrar apenas os pedidos com valor superior a 1500, e, em seguida, a **projeção** seleciona o nome do cliente e o ID do pedido.

### Importância da Projeção na Álgebra Relacional

A **projeção** é uma operação essencial para **simplificar** e **personalizar** as consultas, permitindo que o usuário recupere apenas as colunas necessárias de uma relação. Isso é particularmente útil em cenários em que há grandes volumes de dados, pois ajuda a reduzir o volume de informações retornadas e, consequentemente, melhora a performance das consultas.

Além disso, a projeção permite:
- **Reduzir dados desnecessários**: Evitar retornar colunas que não são relevantes para a consulta.
- **Eliminação de duplicatas**: Como as colunas projetadas eliminam valores repetidos, ela assegura que apenas valores distintos sejam retornados.
- **Facilidade de leitura**: As consultas podem ser simplificadas, exibindo apenas os dados necessários.

### Considerações de Performance

Quando você utiliza projeção em consultas sobre grandes bases de dados, a **eliminação de duplicatas** pode ser um processo custoso, especialmente se o número de valores distintos em uma coluna for grande. Isso é algo que deve ser considerado ao projetar consultas que envolvem operações de projeção.

Se for possível, considere o uso de **índices** nas colunas projetadas, pois eles podem acelerar a execução da consulta ao permitir um acesso mais rápido aos dados.


Com isso, a operação de **Projeção** na Álgebra Relacional se mostra uma ferramenta poderosa e essencial para a seleção eficiente de dados, permitindo que você recupere apenas as colunas de interesse de uma relação, além de simplificar e otimizar consultas.


### Operações da Teoria dos Conjuntos

As operações da Teoria dos Conjuntos são operações matemáticas fundamentais que manipulam conjuntos, ou seja, coleções de elementos distintos. Essas operações são essenciais para o entendimento de como os dados podem ser manipulados, especialmente em álgebra relacional e bancos de dados. Elas se baseiam em conceitos da teoria dos conjuntos e são usadas para combinar, comparar, ou modificar conjuntos de forma precisa.

### **União (∪)** - Detalhamento

A **união** (∪) é uma operação fundamental na álgebra relacional, permitindo combinar as tuplas de duas relações compatíveis. A operação de união retorna todas as tuplas de ambas as relações, mas **elimina duplicatas**. Ou seja, se uma tupla aparece em ambas as relações, ela será apresentada apenas uma vez no resultado final.

#### Características da União:
- **Compatibilidade de relações**: Para realizar uma união entre duas relações, as relações precisam ser **compatíveis**. Isso significa que:
  - As duas relações devem ter o **mesmo número de atributos**.
  - Os **atributos devem ter os mesmos tipos de dados**.
  
- **Eliminação de duplicatas**: Quando as tuplas de ambas as relações contêm valores idênticos, a operação de união remove as duplicatas, garantindo que o conjunto final de tuplas seja único.

- **Relação de fechamento**: A união de duas relações gera uma nova relação, que é uma combinação de todas as tuplas de ambas as relações. Ela segue a **propriedade comutativa** e **associativa**, ou seja:
  - \( R \cup S = S \cup R \) (comutatividade).
  - \( (R \cup S) \cup T = R \cup (S \cup T) \) (associatividade).

A operação de união é muitas vezes utilizada para **combinar dados** que pertencem a fontes diferentes, mas que têm a mesma estrutura.

### Exemplo Prático

#### 1. **União Simples**
Suponha que temos duas tabelas: `Clientes_Ativos` e `Clientes_Inativos`. Ambas contêm a lista de clientes, mas com status diferente. Queremos uma lista completa de todos os clientes, combinando os dados das duas tabelas, mas sem duplicatas.

**Tabela: Clientes_Ativos**

| ClienteID | Nome   | Status     |
|-----------|--------|------------|
| 1         | João   | Ativo      |
| 2         | Maria  | Ativo      |
| 3         | José   | Ativo      |

**Tabela: Clientes_Inativos**

| ClienteID | Nome   | Status     |
|-----------|--------|------------|
| 4         | Ana    | Inativo    |
| 2         | Maria  | Inativo    |
| 5         | Paulo  | Inativo    |

**Operação de União**:
```sql
Clientes_Ativos ∪ Clientes_Inativos
```

**Resultado**:

| ClienteID | Nome   | Status     |
|-----------|--------|------------|
| 1         | João   | Ativo      |
| 2         | Maria  | Ativo      |
| 3         | José   | Ativo      |
| 4         | Ana    | Inativo    |
| 5         | Paulo  | Inativo    |

**Explicação**:
- A operação de **união** combina todas as tuplas de `Clientes_Ativos` e `Clientes_Inativos`.
- A tupla de `Maria` foi removida da tabela resultante, pois ela aparece em ambas as tabelas (uma vez com o status "Ativo" e outra com o status "Inativo").
- Como as tuplas são compatíveis (mesmo número de atributos e tipos de dados), a união pode ser realizada.

#### 2. **União de Tabelas com a Mesma Estrutura**
Para que duas tabelas possam ser unidas, elas precisam ter a **mesma estrutura**, ou seja, o mesmo número e tipo de colunas. Suponha que temos duas tabelas que contêm dados sobre clientes, mas uma tem um atributo extra.

**Tabela: Clientes_Ativos**

| ClienteID | Nome   | Status     |
|-----------|--------|------------|
| 1         | João   | Ativo      |
| 2         | Maria  | Ativo      |

**Tabela: Clientes_Inativos**

| ClienteID | Nome   | Status     |
|-----------|--------|------------|
| 3         | José   | Inativo    |
| 4         | Ana    | Inativo    |

Aqui, as duas tabelas têm a **mesma estrutura**, ou seja, os mesmos três atributos: `ClienteID`, `Nome` e `Status`, e podemos realizar a operação de união.

**Operação de União**:
```sql
Clientes_Ativos ∪ Clientes_Inativos
```

**Resultado**:

| ClienteID | Nome   | Status     |
|-----------|--------|------------|
| 1         | João   | Ativo      |
| 2         | Maria  | Ativo      |
| 3         | José   | Inativo    |
| 4         | Ana    | Inativo    |

Aqui, a união simplesmente combina as tuplas das duas tabelas, resultando em uma única tabela sem duplicatas.

#### 3. **União com Junção**
A união pode ser aplicada após uma operação de **junção** entre duas ou mais tabelas. Por exemplo, podemos juntar as tabelas `Pedidos_Ativos` e `Pedidos_Encerrados`, que contêm informações sobre pedidos de clientes, e unir as tuplas que resultam dessa junção.

**Tabela: Pedidos_Ativos**

| PedidoID | ClienteID | Status     |
|----------|-----------|------------|
| 101      | 1         | Ativo      |
| 102      | 2         | Ativo      |

**Tabela: Pedidos_Encerrados**

| PedidoID | ClienteID | Status     |
|----------|-----------|------------|
| 103      | 3         | Encerrado  |
| 104      | 4         | Encerrado  |

**Operação de Junção e União**:
```sql
(Pedidos_Ativos ⨝ Clientes) ∪ (Pedidos_Encerrados ⨝ Clientes)
```

Aqui, as tuplas dos pedidos ativos são unidas com as tuplas dos pedidos encerrados, e a operação de união garante que os pedidos duplicados (caso existam) sejam eliminados.

#### 4. **União com Diferença**
É possível combinar as operações de união com a operação de **diferença** (−) para refinar a consulta. Suponha que queremos todos os pedidos feitos, mas **excluindo** aqueles que já foram entregues (com status "Encerrado").

**Operação de União e Diferença**:
```sql
(Pedidos_Ativos ⨝ Clientes) ∪ (Pedidos_Encerrados ⨝ Clientes) − (Pedidos_Encerrados ⨝ Clientes)
```

Essa operação retorna todos os pedidos, exceto aqueles que já estão encerrados, efetivamente filtrando os pedidos em andamento.

### Regras Importantes da União

1. **Compatibilidade**: As duas relações devem ter o mesmo número de atributos e tipos de dados compatíveis. Caso contrário, a união não pode ser realizada.
2. **Eliminação de Duplicatas**: Após combinar as tuplas das duas relações, a operação de união elimina as tuplas duplicadas, retornando apenas os valores distintos.
3. **A ordem das tuplas não é garantida**: O resultado da união pode ter uma ordem diferente, mas isso não afeta o resultado final, pois estamos lidando com conjuntos, e a ordem dos elementos em um conjunto não importa.

### Considerações de Performance

Embora a operação de **união** seja simples em termos de conceito, ela pode ser **custosa** em termos de tempo de processamento, principalmente quando o número de tuplas nas relações for grande. Isso ocorre porque a união exige:
- A **leitura** de todas as tuplas de ambas as relações.
- A **comparação** para eliminar duplicatas.

Por isso, é recomendado garantir que as relações estejam adequadamente **indexadas** nas colunas envolvidas, para otimizar o tempo de execução da operação de união.

A operação de **união** na álgebra relacional é uma ferramenta poderosa para combinar dados de fontes diferentes, assegurando a integridade dos resultados por meio da eliminação de duplicatas. Essa operação é frequentemente utilizada em consultas de integração de dados e é um componente chave no processamento de informações em sistemas de banco de dados relacionais.
#### Interseção

### Interseção (∩)

A **interseção** (denotada como \( \cap \)) é uma operação fundamental na teoria dos conjuntos e na álgebra relacional. No contexto da álgebra relacional, a operação de interseção retorna as tuplas que são comuns a duas ou mais relações, ou seja, as tuplas que aparecem em ambas as relações envolvidas na operação.

#### Definição Formal

Em termos formais, a interseção de duas relações \( R \) e \( S \) (denotada \( R \cap S \)) é o conjunto de todas as tuplas que estão em ambas as relações \( R \) e \( S \). Em outras palavras, a operação de interseção compara as duas relações e retorna as tuplas que têm exatamente os mesmos valores nos mesmos atributos em ambas as relações.

**Condição de Compatibilidade:**
Para realizar uma interseção entre duas relações, as duas relações precisam ser **compatíveis**, ou seja, elas devem ter o mesmo número de atributos e os mesmos tipos de dados para cada atributo correspondente.

#### Exemplo de Interseção

Vamos supor que temos duas tabelas, **Clientes_1** e **Clientes_2**, que armazenam informações sobre clientes de diferentes filiais de uma empresa.

**Tabela Clientes_1:**

| ID_Cliente | Nome      | Cidade     |
|------------|-----------|------------|
| 1          | João      | Salvador   |
| 2          | Maria     | Recife     |
| 3          | Pedro     | São Paulo |
| 4          | Ana       | Salvador   |

**Tabela Clientes_2:**

| ID_Cliente | Nome      | Cidade     |
|------------|-----------|------------|
| 2          | Maria     | Recife     |
| 3          | Pedro     | São Paulo |
| 5          | Lucas     | Rio de Janeiro |
| 6          | Júlia     | Salvador   |

#### Interseção entre **Clientes_1** e **Clientes_2**:

Neste caso, a interseção \( Clientes_1 \cap Clientes_2 \) resultaria nas tuplas que aparecem em **ambas** as tabelas, ou seja, nas tuplas em que **ID_Cliente**, **Nome** e **Cidade** são idênticos nas duas relações.

**Resultado da Interseção:**

| ID_Cliente | Nome  | Cidade    |
|------------|-------|-----------|
| 2          | Maria | Recife    |
| 3          | Pedro | São Paulo |

Essas são as tuplas que aparecem tanto em **Clientes_1** quanto em **Clientes_2**.

#### Características da Interseção

1. **Operação Comutativa:**
   A interseção é uma operação comutativa, o que significa que a ordem das relações não afeta o resultado. Ou seja, \( R \cap S = S \cap R \).

2. **Operação Associativa:**
   A interseção também é associativa, o que significa que, ao realizar a interseção de mais de duas relações, a ordem em que as operações são realizadas não altera o resultado. Ou seja, \( (R \cap S) \cap T = R \cap (S \cap T) \).

3. **Resultado sem Duplicatas:**
   Quando realizamos uma interseção, o resultado não inclui duplicatas. O conjunto de resultados é sempre composto por tuplas únicas.

4. **Aplicação Prática:**
   A interseção é muito útil quando se deseja encontrar elementos que estão presentes em dois ou mais conjuntos de dados. Por exemplo, em um banco de dados, podemos usar a interseção para encontrar clientes que compraram produtos de diferentes categorias, ou para encontrar registros que coincidem em múltiplas tabelas.

#### Interseção em um Banco de Dados Relacional

No contexto de bancos de dados, as operações de interseção podem ser realizadas usando SQL (Structured Query Language) ou operações de álgebra relacional. Em SQL, a operação de interseção é expressa com o comando `INTERSECT`, que retorna o conjunto de resultados comuns entre duas ou mais consultas.

**Exemplo de SQL para Interseção:**

```sql
SELECT ID_Cliente, Nome, Cidade
FROM Clientes_1
INTERSECT
SELECT ID_Cliente, Nome, Cidade
FROM Clientes_2;
```

Este comando SQL retornaria as tuplas que estão presentes em ambas as tabelas **Clientes_1** e **Clientes_2**, com base nos valores de **ID_Cliente**, **Nome** e **Cidade**.


A operação de **interseção** é essencial para encontrar a sobreposição entre duas relações, retornando as tuplas que estão presentes em ambas as relações envolvidas. Essa operação pode ser muito útil para identificar registros comuns, comparar conjuntos de dados e realizar consultas complexas que exigem a combinação de informações de diferentes fontes.

### Diferença (−)

A **diferença** (denotada como \( R - S \)) é uma operação fundamental na teoria dos conjuntos e na álgebra relacional. No contexto da álgebra relacional, a operação de **diferença** retorna as tuplas que pertencem a uma relação, mas **não pertencem** a outra. Ou seja, ela exclui as tuplas de uma relação que também aparecem em outra.

#### Definição Formal

Formalmente, a diferença de duas relações \( R \) e \( S \) (denotada como \( R - S \)) resulta em um conjunto de tuplas que estão presentes em \( R \), mas não em \( S \). Em outras palavras, para cada tupla \( t \) de \( R \), a tupla \( t \) será incluída no resultado de \( R - S \) se e somente se \( t \) **não** estiver presente em \( S \).

**Condição de Compatibilidade:**
Assim como na interseção e na união, as duas relações envolvidas na diferença precisam ser **compatíveis**, ou seja, devem ter o mesmo número de atributos e os mesmos tipos de dados para cada atributo correspondente.

#### Exemplo de Diferença

Vamos supor que temos duas tabelas de **Clientes** de diferentes filiais de uma empresa. A primeira tabela, **Clientes_1**, contém uma lista de todos os clientes de uma filial, e a segunda tabela, **Clientes_2**, contém uma lista de clientes de outra filial.

**Tabela Clientes_1:**

| ID_Cliente | Nome      | Cidade     |
|------------|-----------|------------|
| 1          | João      | Salvador   |
| 2          | Maria     | Recife     |
| 3          | Pedro     | São Paulo |
| 4          | Ana       | Salvador   |

**Tabela Clientes_2:**

| ID_Cliente | Nome      | Cidade     |
|------------|-----------|------------|
| 2          | Maria     | Recife     |
| 3          | Pedro     | São Paulo |
| 5          | Lucas     | Rio de Janeiro |
| 6          | Júlia     | Salvador   |

#### Diferença entre **Clientes_1** e **Clientes_2**:

Neste caso, a operação de diferença \( Clientes_1 - Clientes_2 \) retornaria as tuplas que estão em **Clientes_1**, mas **não estão** em **Clientes_2**.

**Resultado da Diferença:**

| ID_Cliente | Nome  | Cidade    |
|------------|-------|-----------|
| 1          | João  | Salvador  |
| 4          | Ana   | Salvador  |

Essas são as tuplas que aparecem em **Clientes_1** e **não** aparecem em **Clientes_2**.

#### Características da Diferença

1. **Operação Não Comutativa:**
   A operação de diferença **não é comutativa**, o que significa que a ordem das relações na operação importa. Ou seja, \( R - S \neq S - R \). O que é retirado de \( R \) não é necessariamente o que é retirado de \( S \).

2. **Operação Não Associativa:**
   A operação de diferença também **não é associativa**, ou seja, a ordem em que a diferença é aplicada em múltiplas relações pode afetar o resultado. Por exemplo, \( (R - S) - T \) pode ser diferente de \( R - (S - T) \).

3. **Resultado sem Duplicatas:**
   Como as operações em álgebra relacional, a diferença também retorna um conjunto sem duplicatas. Se uma tupla aparece várias vezes em \( R \), mas não em \( S \), ela será incluída uma vez no resultado.

4. **Aplicação Prática:**
   A operação de diferença é útil quando se deseja encontrar tuplas que estão em uma tabela, mas não em outra. Ela pode ser usada para, por exemplo, encontrar registros em uma tabela de clientes que não aparecem em outra, ou para comparar duas listas de dados e encontrar elementos únicos a uma delas.

#### Diferença em um Banco de Dados Relacional

Em bancos de dados relacionais, a operação de diferença pode ser realizada utilizando SQL, através do operador `EXCEPT` (ou `MINUS` em alguns sistemas de gerenciamento de banco de dados, como o Oracle). O comando `EXCEPT` retorna as tuplas da primeira consulta que **não estão presentes** na segunda consulta.

**Exemplo de SQL para Diferença:**

```sql
SELECT ID_Cliente, Nome, Cidade
FROM Clientes_1
EXCEPT
SELECT ID_Cliente, Nome, Cidade
FROM Clientes_2;
```

Este comando SQL retornaria as tuplas que estão presentes na tabela **Clientes_1**, mas não na tabela **Clientes_2**, com base nos valores de **ID_Cliente**, **Nome** e **Cidade**.


A operação de **diferença** é fundamental quando se deseja encontrar tuplas exclusivas de uma relação, ou seja, aquelas que estão em uma relação, mas não em outra. Ela é amplamente utilizada para comparar conjuntos de dados e identificar elementos exclusivos. Essa operação não é comutativa e nem associativa, o que implica que a ordem das operações e das relações importa. Na prática, pode ser utilizada para realizar consultas em bancos de dados e comparar listas de registros, excluindo as tuplas que aparecem em uma tabela, mas não em outra.

### Produto Cartesiano

### Produto Cartesiano (×)

O **produto cartesiano** (denotado como \( R \times S \)) é uma operação fundamental na álgebra relacional que combina todas as tuplas de duas relações \( R \) e \( S \), formando uma nova relação composta por todas as combinações possíveis de tuplas das duas relações.

#### Definição Formal

O **produto cartesiano** entre duas relações \( R \) e \( S \), denotado como \( R \times S \), é o conjunto de todas as tuplas possíveis onde cada tupla consiste em uma combinação de uma tupla de \( R \) e uma tupla de \( S \).

Se \( R \) tem \( n \) atributos e \( S \) tem \( m \) atributos, então o resultado do produto cartesiano terá \( n + m \) atributos. O número de tuplas no resultado será o produto do número de tuplas nas duas relações, ou seja, se \( R \) tem \( r \) tuplas e \( S \) tem \( s \) tuplas, o produto cartesiano terá \( r \times s \) tuplas.

#### Características do Produto Cartesiano

1. **Número de Tuplas no Resultado:**
   Se \( R \) contém \( r \) tuplas e \( S \) contém \( s \) tuplas, então o produto cartesiano \( R \times S \) terá \( r \times s \) tuplas. O número de tuplas cresce rapidamente conforme o número de tuplas nas relações aumenta.

2. **Número de Atributos no Resultado:**
   O número de atributos no resultado do produto cartesiano será a soma do número de atributos de \( R \) e \( S \). Se \( R \) tem \( n \) atributos e \( S \) tem \( m \) atributos, o resultado terá \( n + m \) atributos.

3. **Operação Não Comutativa:**
   O produto cartesiano é uma operação **não comutativa**, o que significa que a ordem das relações afeta o resultado. Ou seja, \( R \times S \neq S \times R \), já que as tuplas de \( R \) são combinadas com as de \( S \), e não o contrário.

4. **Aplicações Práticas:**
   O produto cartesiano pode ser útil em várias situações, como para combinar todas as possibilidades de registros de diferentes tabelas. No entanto, em bancos de dados práticos, o produto cartesiano é geralmente usado com a operação de **junção** para evitar a explosão de resultados, combinando as tuplas de maneira mais relevante (por exemplo, usando uma condição de junção).

#### Exemplo de Produto Cartesiano

Vamos supor que temos duas tabelas, **Funcionários** e **Departamentos**, e queremos calcular todas as possíveis combinações de um funcionário com um departamento, ou seja, o produto cartesiano entre as duas tabelas.

**Tabela Funcionários:**

| ID_Funcionario | Nome      |
|-----------------|-----------|
| 1               | João      |
| 2               | Maria     |

**Tabela Departamentos:**

| ID_Departamento | Departamento |
|-----------------|--------------|
| 10              | TI           |
| 20              | RH           |

#### Produto Cartesiano entre **Funcionários** e **Departamentos**:

O produto cartesiano entre as tabelas **Funcionários** e **Departamentos** irá combinar cada tupla de **Funcionários** com cada tupla de **Departamentos**, gerando o seguinte resultado:

**Resultado do Produto Cartesiano:**

| ID_Funcionario | Nome  | ID_Departamento | Departamento |
|-----------------|-------|-----------------|--------------|
| 1               | João  | 10              | TI           |
| 1               | João  | 20              | RH           |
| 2               | Maria | 10              | TI           |
| 2               | Maria | 20              | RH           |

Neste exemplo, o produto cartesiano resultou em 4 tuplas, porque temos 2 tuplas na tabela **Funcionários** e 2 tuplas na tabela **Departamentos**, gerando 2 * 2 = 4 combinações possíveis.

#### Produto Cartesiano em um Banco de Dados Relacional

No contexto de um banco de dados relacional, o produto cartesiano pode ser realizado utilizando SQL, e o comando correspondente é simplesmente a **junção implícita** de duas tabelas sem qualquer condição de junção. Isso, no entanto, é raramente usado em aplicações práticas, uma vez que pode resultar em um número muito grande de tuplas. A operação de junção com uma condição de combinação específica (como uma chave primária ou estrangeira) é mais comum para limitar o número de tuplas retornadas.

**Exemplo de SQL para Produto Cartesiano:**

```sql
SELECT * 
FROM Funcionarios, Departamentos;
```

Este comando SQL retornaria o produto cartesiano entre as tabelas **Funcionários** e **Departamentos**, conforme descrito no exemplo.

#### Considerações Importantes

- **Evitar Excesso de Dados:** O produto cartesiano pode rapidamente gerar um grande número de tuplas. Quando utilizado sem uma junção condicional (como uma chave primária e estrangeira), ele pode levar a um grande desperdício de recursos e a resultados pouco úteis. Por isso, é mais comum que a operação de produto cartesiano seja seguida por uma **junção** com uma condição específica.
  
- **Uso em Junções:** Embora o produto cartesiano possa ser uma operação útil, ele é raramente utilizado isoladamente. Em vez disso, ele é frequentemente usado como parte de uma junção (ex: junção interna, junção externa), onde as tuplas são combinadas com base em uma condição lógica.


O **produto cartesiano** é uma operação fundamental na álgebra relacional que combina todas as tuplas de duas relações, criando todas as combinações possíveis. Embora essa operação seja útil em alguns casos, ela tende a gerar um número grande de tuplas, o que pode ser impraticável sem um filtro adicional. Em sistemas de bancos de dados relacionais, o produto cartesiano é muitas vezes combinado com uma condição de junção para limitar as combinações a tuplas que fazem sentido em um contexto de dados.

### Junção (Join)

### Junção (⨝)

A **junção** (denotada como \( R \bowtie S \)) é uma das operações mais poderosas e frequentemente utilizadas na álgebra relacional. Ela permite combinar tuplas de duas relações com base em um atributo comum, criando uma nova relação que inclui apenas as tuplas que satisfazem a condição de junção.

#### Definição Formal

A operação de **junção** entre duas relações \( R \) e \( S \) é realizada com base em uma condição que normalmente envolve um ou mais atributos comuns entre as duas relações. Quando as tuplas de \( R \) e \( S \) compartilham um ou mais atributos com valores correspondentes, essas tuplas são combinadas em uma nova tupla no resultado da junção.

Por exemplo, se as relações \( R \) e \( S \) possuem um atributo comum \( A \), então a junção \( R \bowtie S \) combinará as tuplas de \( R \) e \( S \) onde os valores de \( A \) são iguais.

#### Tipos de Junção

1. **Junção Natural (Natural Join)**:
   A **junção natural** (denotada como \( R \bowtie S \)) é uma junção onde as tuplas de \( R \) e \( S \) são combinadas com base em todos os atributos que possuem o mesmo nome em ambas as relações. Essa operação automaticamente elimina os atributos duplicados do resultado da junção.

2. **Junção Equijunção (Equi Join)**:
   A **equijunção** (ou **junção equi**), que é uma forma de junção baseada em uma condição de igualdade (\( = \)), combina tuplas de \( R \) e \( S \) onde os valores dos atributos comuns são iguais. A equi junção pode ser expressa como \( R \bowtie_{R.A = S.A} S \), onde \( R.A \) e \( S.A \) são atributos com o mesmo nome e a condição é que seus valores sejam iguais.

3. **Junção Interna (Inner Join)**:
   A **junção interna** (denotada como \( R \bowtie S \)) retorna apenas as tuplas de \( R \) e \( S \) que possuem valores correspondentes nos atributos comuns. Ou seja, somente as tuplas que têm uma correspondência em ambas as relações são incluídas no resultado. Em SQL, isso é feito usando a cláusula `INNER JOIN`.

4. **Junção Externa (Outer Join)**:
   A **junção externa** inclui todas as tuplas de uma ou ambas as relações, mesmo que não haja correspondência em todos os atributos. Existem três tipos de junções externas:
   - **Junção Externa à Esquerda (Left Outer Join)**: Inclui todas as tuplas de \( R \) e as tuplas correspondentes de \( S \). Se não houver correspondência, as colunas de \( S \) são preenchidas com valores nulos.
   - **Junção Externa à Direita (Right Outer Join)**: Inclui todas as tuplas de \( S \) e as tuplas correspondentes de \( R \). Se não houver correspondência, as colunas de \( R \) são preenchidas com valores nulos.
   - **Junção Externa Completa (Full Outer Join)**: Inclui todas as tuplas de \( R \) e \( S \), preenchendo com valores nulos onde não há correspondência.

5. **Junção Cruzada (Cross Join)**:
   O **produto cartesiano** sem condições de junção é considerado uma **junção cruzada**, que resulta em todas as combinações possíveis entre as tuplas de \( R \) e \( S \). Esta operação é equivalente a \( R \times S \), mas é chamada de junção cruzada em SQL. No entanto, é menos utilizada, pois tende a gerar um número muito grande de tuplas.

#### Exemplo de Junção

Vamos supor que temos duas tabelas, **Funcionários** e **Departamentos**, e queremos realizar uma junção para combinar as informações de cada funcionário com o departamento ao qual ele pertence. Ambas as tabelas possuem o atributo **ID_Departamento**.

**Tabela Funcionários:**

| ID_Funcionario | Nome  | ID_Departamento |
|-----------------|-------|-----------------|
| 1               | João  | 10              |
| 2               | Maria | 20              |
| 3               | Pedro | 10              |
| 4               | Ana   | 30              |

**Tabela Departamentos:**

| ID_Departamento | Departamento |
|-----------------|--------------|
| 10              | TI           |
| 20              | RH           |
| 30              | Marketing    |

#### Junção entre **Funcionários** e **Departamentos** com base no **ID_Departamento**:

Realizando uma **junção natural** entre as duas tabelas usando o atributo **ID_Departamento**, obtemos o seguinte resultado:

**Resultado da Junção Natural (Funcionários ⨝ Departamentos):**

| ID_Funcionario | Nome  | ID_Departamento | Departamento |
|-----------------|-------|-----------------|--------------|
| 1               | João  | 10              | TI           |
| 2               | Maria | 20              | RH           |
| 3               | Pedro | 10              | TI           |
| 4               | Ana   | 30              | Marketing    |

Neste exemplo, a junção combinou as tuplas de **Funcionários** com as tuplas de **Departamentos** onde o valor de **ID_Departamento** é o mesmo em ambas as tabelas. O resultado contém apenas as tuplas que possuem correspondência no atributo **ID_Departamento**.

#### Junção em Banco de Dados Relacional

Em um banco de dados relacional, a junção é geralmente realizada utilizando SQL. O operador de junção é amplamente utilizado com as cláusulas `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, ou `FULL OUTER JOIN`, dependendo do tipo de junção que desejamos.

**Exemplo de SQL para Junção Interna:**

```sql
SELECT Funcionarios.ID_Funcionario, Funcionarios.Nome, Departamentos.Departamento
FROM Funcionarios
INNER JOIN Departamentos
ON Funcionarios.ID_Departamento = Departamentos.ID_Departamento;
```

**Exemplo de SQL para Junção Externa à Esquerda:**

```sql
SELECT Funcionarios.ID_Funcionario, Funcionarios.Nome, Departamentos.Departamento
FROM Funcionarios
LEFT JOIN Departamentos
ON Funcionarios.ID_Departamento = Departamentos.ID_Departamento;
```

#### Considerações Importantes

1. **Desempenho de Junção:**
   O desempenho das operações de junção pode ser impactado pelo tamanho das tabelas e pela quantidade de dados a serem combinados. Junções grandes podem resultar em um aumento significativo no tempo de resposta de uma consulta, especialmente quando não são indexadas.

2. **Índices em Atributos Comuns:**
   Para otimizar o desempenho da junção, é recomendável criar índices nos atributos comuns que são usados para realizar as junções, como as chaves primárias e estrangeiras. Isso pode acelerar a busca e a combinação de tuplas durante a operação de junção.

3. **Evitar Duplicação de Dados:**
   Em uma junção natural, os atributos comuns são combinados e os duplicados são removidos automaticamente. No entanto, em uma junção equi ou externa, você pode precisar de cuidados adicionais para evitar a duplicação de dados em uma tabela com valores repetidos.


A **junção** é uma operação fundamental na álgebra relacional, permitindo combinar tuplas de duas relações com base em um atributo comum. Ela é amplamente utilizada para combinar dados de tabelas diferentes em um banco de dados relacional. A junção pode ser de vários tipos, incluindo a junção natural, equi, interna e externa, dependendo das condições de combinação e dos resultados desejados. A junção é essencial para consultas complexas, que envolvem múltiplas tabelas, e é uma das operações mais comuns em SQL.


## Estudo de Caso: Álgebra Relacional com 5 Tabelas

### Introdução

Neste estudo de caso, vamos trabalhar com um sistema de gerenciamento de vendas, onde temos as seguintes tabelas:

1. **Clientes**: Contém informações sobre os clientes.
2. **Pedidos**: Contém informações sobre os pedidos feitos pelos clientes.
3. **Produtos**: Contém informações sobre os produtos disponíveis para venda.
4. **Funcionários**: Contém informações sobre os funcionários que processam os pedidos.
5. **Pagamentos**: Contém informações sobre os pagamentos realizados pelos clientes.

### Estrutura das Tabelas

#### Tabela `Clientes`

| ClienteID | Nome     | Cidade     |
|-----------|----------|------------|
| 1         | João     | Salvador   |
| 2         | Maria    | Aracaju    |
| 3         | José     | Salvador   |
| 4         | Ana      | Recife     |

#### Tabela `Pedidos`

| PedidoID | ClienteID | ProdutoID | FuncionarioID | DataPedido  | Valor |
|----------|-----------|-----------|---------------|-------------|-------|
| 101      | 1         | 201       | 301           | 2025-03-01  | 3000  |
| 102      | 2         | 202       | 302           | 2025-03-02  | 1500  |
| 103      | 3         | 203       | 301           | 2025-03-03  | 1200  |
| 104      | 4         | 204       | 303           | 2025-03-04  | 2000  |

#### Tabela `Produtos`

| ProdutoID | Produto        | Categoria     |
|-----------|----------------|---------------|
| 201       | Laptop         | Eletrônicos   |
| 202       | Smartphone     | Eletrônicos   |
| 203       | Tablet         | Eletrônicos   |
| 204       | Smartwatch     | Acessórios    |

#### Tabela `Funcionários`

| FuncionarioID | Nome        | Cargo      |
|---------------|-------------|------------|
| 301           | Carlos      | Vendedor   |
| 302           | João        | Vendedor   |
| 303           | Ana         | Gerente    |

#### Tabela `Pagamentos`

| PagamentoID | PedidoID | DataPagamento | ValorPago |
|-------------|----------|---------------|-----------|
| 501         | 101      | 2025-03-01    | 3000      |
| 502         | 102      | 2025-03-02    | 1500      |
| 503         | 103      | 2025-03-03    | 1200      |

## Operações da Álgebra Relacional

### 1. Junção (Join)

Vamos realizar uma junção entre as tabelas `Clientes`, `Pedidos`, e `Produtos` para obter uma lista de pedidos feitos pelos clientes, com o nome do cliente e o nome do produto.

**Operação**:
```sql
Clientes ⨝ Pedidos ⨝ Produtos
```

**Resultado**:

| ClienteID | Nome   | Cidade   | PedidoID | ProdutoID | Produto    | Valor | DataPedido  |
|-----------|--------|----------|----------|-----------|------------|-------|-------------|
| 1         | João   | Salvador | 101      | 201       | Laptop     | 3000  | 2025-03-01  |
| 2         | Maria  | Aracaju  | 102      | 202       | Smartphone | 1500  | 2025-03-02  |
| 3         | José   | Salvador | 103      | 203       | Tablet     | 1200  | 2025-03-03  |
| 4         | Ana    | Recife   | 104      | 204       | Smartwatch | 2000  | 2025-03-04  |

### 2. Produto Cartesiano (Cross Product)

O produto cartesiano entre as tabelas `Clientes` e `Pedidos` gera todas as combinações possíveis entre os registros das duas tabelas.

**Operação**:
```sql
Clientes × Pedidos
```

**Resultado** (apenas uma parte do resultado):

| ClienteID | Nome   | Cidade   | PedidoID | ClienteID | ProdutoID | Valor |
|-----------|--------|----------|----------|-----------|-----------|-------|
| 1         | João   | Salvador | 101      | 1         | 201       | 3000  |
| 1         | João   | Salvador | 101      | 2         | 202       | 1500  |
| ...       | ...    | ...      | ...      | ...       | ...       | ...   |

### 3. Diferença (Difference)

A operação de **diferença** entre as tabelas `Clientes` e `Pedidos` retorna os clientes que não têm pedidos registrados.

**Operação**:
```sql
Clientes - Pedidos
```

**Resultado** (clientes sem pedidos):

| ClienteID | Nome  | Cidade   |
|-----------|-------|----------|
| 5         | Carla | São Paulo |

### 4. Interseção (Intersection)

A operação de **interseção** entre as tabelas `Clientes` e `Pedidos` retorna os clientes que têm pedidos registrados.

**Operação**:
```sql
Clientes ∩ Pedidos
```

**Resultado** (clientes que fizeram pedidos):

| ClienteID | Nome  | Cidade   |
|-----------|-------|----------|
| 1         | João  | Salvador |
| 2         | Maria | Aracaju  |
| 3         | José  | Salvador |
| 4         | Ana   | Recife   |

### 5. União (Union)

A operação de **união** entre duas tabelas retorna todos os registros de ambas, sem duplicatas. Para isso, as tabelas precisam ter a mesma estrutura.

**Operação**:
```sql
Clientes ∪ Pedidos
```

**Resultado** (união de clientes e pedidos):

| ClienteID | Nome  | Cidade   |
|-----------|-------|----------|
| 1         | João  | Salvador |
| 2         | Maria | Aracaju  |
| 3         | José  | Salvador |
| 4         | Ana   | Recife   |
| 101       | NULL  | NULL     |
| 102       | NULL  | NULL     |

### 6. Projeção (Projection)

A operação de **projeção** retorna apenas as colunas selecionadas de uma tabela. Por exemplo, para obter apenas os nomes dos clientes e os valores dos pedidos:

**Operação**:
```sql
π(Nome, Valor)(Clientes ⨝ Pedidos)
```

**Resultado**:

| Nome   | Valor |
|--------|-------|
| João   | 3000  |
| Maria  | 1500  |
| José   | 1200  |
| Ana    | 2000  |

### 7. Seleção (Restrição)

A operação de **seleção (restrição)** retorna apenas os registros que atendem a uma condição. Por exemplo, queremos selecionar os pedidos realizados por clientes da cidade "Salvador":

**Operação**:
```sql
σ(Cidade = 'Salvador')(Clientes ⨝ Pedidos)
```

**Resultado**:

| ClienteID | Nome  | Cidade   | PedidoID | ProdutoID | Produto    | Valor | DataPedido  |
|-----------|-------|----------|----------|-----------|------------|-------|-------------|
| 1         | João  | Salvador | 101      | 201       | Laptop     | 3000  | 2025-03-01  |
| 3         | José  | Salvador | 103      | 203       | Tablet     | 1200  | 2025-03-03  |

## Conclusão

Neste estudo de caso, mostramos como realizar diversas operações da Álgebra Relacional em um banco de dados com 5 tabelas. As operações de **junção**, **produto cartesiano**, **diferença**, **interseção**, **união**, **projeção** e **seleção** são essenciais para a manipulação eficiente dos dados e a construção de consultas complexas em sistemas de gerenciamento de banco de dados relacionais.