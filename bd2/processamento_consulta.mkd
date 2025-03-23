# Processamento de Consulta

   A otimização de consultas em bancos de dados é um processo crucial para garantir que as operações de consulta sejam executadas de forma eficiente, reduzindo o tempo de resposta e o consumo de recursos. Vamos explorar mais detalhadamente os conceitos mencionados e como eles se relacionam com o processamento de consultas em um Sistema de Gerenciamento de Banco de Dados (SGBD).

### 1. **Consulta SQL Adequada para Uso Humano vs. Processamento pelo SGBD**

- **Consulta SQL Adequada para Uso Humano**: 
  - As consultas SQL são escritas de forma que sejam compreensíveis para os desenvolvedores e analistas de dados. Elas são declarativas, ou seja, descrevem **o que** deve ser recuperado, mas não **como** isso deve ser feito.
  - Exemplo: `SELECT nome, salario FROM funcionarios WHERE departamento = 'Vendas' AND salario > 5000;`
  - Essa consulta é fácil de entender para um humano, mas não especifica como o SGBD deve acessar os dados ou qual estratégia de execução deve ser usada.

- **Consulta SQL Não Adequada para Processamento pelo SGBD**:
  - O SGBD não executa a consulta diretamente como escrita. Em vez disso, ele precisa transformar a consulta em uma série de operações de baixo nível que possam ser executadas eficientemente.
  - O SGBD precisa decidir, por exemplo, se deve usar um índice, realizar uma varredura completa da tabela, ou como juntar tabelas de forma eficiente.

### 2. **Processador de Consultas**

O **Processador de Consultas** é um módulo do SGBD responsável por traduzir a consulta SQL em uma série de operações que podem ser executadas pelo sistema. Esse processo envolve várias etapas:

- **Análise e Verificação**: 
  - O SGBD verifica a sintaxe da consulta e se as tabelas e colunas referenciadas existem.
  - Também verifica permissões de acesso.

- **Tradução para uma Forma Intermediária**:
  - A consulta SQL é convertida em uma representação interna, como uma **árvore de consulta**, que descreve as operações necessárias para executar a consulta.

- **Otimização**:
  - O otimizador de consultas é responsável por gerar diferentes planos de execução e escolher o mais eficiente.
  - O otimizador considera fatores como:
    - **Custos de I/O**: Quantas operações de leitura/escrita em disco serão necessárias.
    - **Uso de Índices**: Se índices podem ser usados para acelerar a consulta.
    - **Algoritmos de Junção**: Qual algoritmo de junção (e.g., nested loop, hash join, merge join) é mais adequado para a consulta.
    - **Estatísticas sobre os Dados**: O otimizador usa estatísticas sobre os dados (e.g., número de linhas, distribuição de valores) para estimar o custo de diferentes estratégias.

- **Geração do Plano de Execução**:
  - O plano de execução é uma sequência de operações de baixo nível que o SGBD executará para retornar os resultados da consulta.
  - Exemplo de plano de execução:
    1. Usar um índice na coluna `departamento` para filtrar funcionários do departamento de Vendas.
    2. Aplicar um filtro adicional na coluna `salario` para retornar apenas funcionários com salário maior que 5000.
    3. Retornar os valores das colunas `nome` e `salario`.

### 3. **Estratégia de Acesso e Algoritmos Predefinidos**

O SGBD utiliza algoritmos predefinidos para implementar as operações necessárias para processar a consulta. Alguns desses algoritmos incluem:

- **Busca Sequencial vs. Busca com Índice**:
  - Se a consulta envolve uma condição de filtro (e.g., `WHERE departamento = 'Vendas'`), o SGBD pode optar por usar um índice para acelerar a busca, em vez de realizar uma varredura completa da tabela.

- **Algoritmos de Junção**:
  - Dependendo do tamanho das tabelas e da disponibilidade de índices, o SGBD pode escolher entre diferentes algoritmos de junção, como:
    - **Nested Loop Join**: Adequado para tabelas pequenas ou quando um índice está disponível.
    - **Hash Join**: Eficiente para junções de grandes volumes de dados.
    - **Merge Join**: Útil quando as tabelas já estão ordenadas.

- **Ordenação e Agrupamento**:
  - Se a consulta envolve `ORDER BY` ou `GROUP BY`, o SGBD pode usar algoritmos de ordenação (e.g., quicksort, merge sort) ou técnicas de agrupamento para processar os dados.

### 4. **Estimativas sobre os Dados**

O otimizador de consultas depende de **estatísticas sobre os dados** para tomar decisões informadas. Essas estatísticas podem incluir:

- **Número de Linhas**: Quantas linhas existem em cada tabela.
- **Distribuição de Valores**: Como os valores estão distribuídos nas colunas (e.g., quantos funcionários estão em cada departamento).
- **Tamanho dos Dados**: O tamanho médio das linhas e o espaço ocupado pelos dados.

Com base nessas estatísticas, o otimizador pode estimar o custo de diferentes estratégias de execução e escolher a mais eficiente.

### 5. **Vale a Pena Otimizar?**

A otimização de consultas pode parecer um processo complexo e demorado, mas os benefícios geralmente superam os custos:

- **Tx (Tempo para Definir e Executar uma Estratégia Otimizada)**:
  - O tempo gasto pelo SGBD para gerar um plano de execução otimizado é geralmente muito menor do que o tempo que seria gasto executando uma estratégia não otimizada.

- **Ty (Tempo para Executar uma Estratégia Não Otimizada)**:
  - Estratégias não otimizadas podem resultar em varreduras completas de tabelas, junções ineficientes e operações desnecessárias, levando a tempos de execução muito maiores.

- **Conclusão**:
  - Na maioria dos casos, **Tx << Ty**, ou seja, o tempo gasto na otimização é insignificante comparado ao tempo economizado na execução da consulta.

### 6. **Exemplo Prático**

Considere a seguinte consulta:

```sql
SELECT nome, salario 
FROM funcionarios 
WHERE departamento = 'Vendas' 
  AND salario > 5000;
```

- **Estratégia Não Otimizada**:
  - O SGBD pode realizar uma varredura completa da tabela `funcionarios`, lendo todas as linhas e aplicando os filtros `departamento = 'Vendas'` e `salario > 5000` em cada linha.
  - Isso pode ser extremamente lento se a tabela tiver milhões de linhas.

- **Estratégia Otimizada**:
  - O SGBD pode usar um índice na coluna `departamento` para rapidamente localizar os funcionários do departamento de Vendas.
  - Em seguida, pode aplicar o filtro `salario > 5000` apenas nas linhas já filtradas.
  - Isso reduz drasticamente o número de operações de I/O e o tempo de execução.


## Etapas de Processamento

![texto](./imagens/proc1.png)

### Tradução

A etapa de **tradução** no processamento de consultas em um Sistema de Gerenciamento de Banco de Dados (SGBD) é um passo crucial que converte a consulta SQL em uma **representação interna**, geralmente uma **árvore algébrica da consulta**. Essa representação interna é uma forma intermediária que descreve a consulta em termos de operações da álgebra relacional, permitindo que o SGBD realize otimizações e gere um plano de execução eficiente.

Vamos detalhar essa etapa:

---

#### 1. **Objetivo da Tradução**

O objetivo principal da tradução é transformar a consulta SQL, que é uma linguagem de alto nível e declarativa, em uma representação interna que possa ser manipulada e otimizada pelo SGBD. Essa representação interna é geralmente uma **árvore algébrica**, onde:

- **Nodos Folha**: Representam as tabelas ou relações do banco de dados.
- **Nodos Internos**: Representam as operações da álgebra relacional (e.g., seleção, projeção, junção, agregação).

---

#### 2. **Processo de Tradução**

O processo de tradução envolve os seguintes passos:

1. **Análise Léxica e Sintática**:
   - O SGBD verifica se a consulta SQL está sintaticamente correta.
   - Identifica as palavras-chave, tabelas, colunas, condições, etc.

2. **Verificação Semântica**:
   - O SGBD verifica se as tabelas e colunas referenciadas na consulta existem no banco de dados.
   - Verifica se o usuário tem permissão para acessar os dados solicitados.

3. **Conversão para Álgebra Relacional**:
   - A consulta SQL é convertida em uma expressão da álgebra relacional.
   - Exemplo:
     - Consulta SQL:
       ```sql
       SELECT nome, salario 
       FROM funcionarios 
       WHERE departamento = 'Vendas' 
         AND salario > 5000;
       ```
     - Expressão em Álgebra Relacional:
       ```
       π(nome, salario) 
       (σ(departamento = 'Vendas' ∧ salario > 5000) 
       (funcionarios)
       ```

4. **Geração da Árvore Algébrica**:
   - A expressão da álgebra relacional é organizada em uma árvore, onde:
     - Os nodos folha representam as tabelas.
     - Os nodos internos representam as operações (e.g., seleção, projeção, junção).

---

#### 3. **Exemplo de Tradução**

Considere a seguinte consulta SQL:

```sql
SELECT nome, salario 
FROM funcionarios 
WHERE departamento = 'Vendas' 
  AND salario > 5000;
```

#### Passos de Tradução:

1. **Análise Léxica e Sintática**:
   - Identifica as palavras-chave (`SELECT`, `FROM`, `WHERE`), tabelas (`funcionarios`), colunas (`nome`, `salario`, `departamento`), e condições (`departamento = 'Vendas'`, `salario > 5000`).

2. **Verificação Semântica**:
   - Verifica se a tabela `funcionarios` existe e se as colunas `nome`, `salario` e `departamento` estão presentes nessa tabela.

3. **Conversão para Álgebra Relacional**:
   - A consulta é convertida em:
     ```
     π(nome, salario) 
     (σ(departamento = 'Vendas' ∧ salario > 5000) 
     (funcionarios)
     ```

4. **Geração da Árvore Algébrica**:
   - A árvore resultante é:
     ```
           π(nome, salario)
               |
           σ(departamento = 'Vendas' ∧ salario > 5000)
               |
           funcionarios
     ```

---

#### 4. **Importância da Tradução**

- **Base para Otimização**:
  - A árvore algébrica gerada na etapa de tradução serve como entrada para o **otimizador de consultas**, que reorganiza e transforma a árvore para gerar um plano de execução eficiente.

- **Independência de Linguagem**:
  - A tradução permite que o SGBD trabalhe com uma representação interna independente da linguagem de consulta (SQL), facilitando a implementação de otimizações e extensões.

- **Preparação para Execução**:
  - A árvore algébrica é usada para definir o **plano de execução**, que especifica como as operações serão realizadas (e.g., uso de índices, algoritmos de junção).


![texto](./imagens/proc2.png)

### Árvore da Consulta

A estrutura que representa o mapeamento de uma consulta SQL para a **álgebra relacional** é geralmente uma **árvore de consulta** (ou **árvore de expressão relacional**). Essa árvore é uma representação hierárquica das operações que precisam ser realizadas para processar a consulta. Vamos detalhar como essa estrutura funciona e como o processamento ocorre.

---

#### 1. **Árvore de Consulta na Álgebra Relacional**

A árvore de consulta é composta por:

- **Nodos Folha**:
  - Representam as **relações** (tabelas do banco de dados) ou **resultados intermediários** de subconsultas.
  - Exemplo: Se a consulta envolve a tabela `funcionarios`, o nodo folha será a relação `funcionarios`.

- **Nodos Internos**:
  - Representam as **operações da álgebra relacional** que precisam ser aplicadas aos dados.
  - Exemplos de operações:
    - **Seleção (σ)**: Filtra linhas com base em uma condição (e.g., `σ(salario > 5000)`).
    - **Projeção (π)**: Seleciona colunas específicas (e.g., `π(nome, salario)`).
    - **Junção (⨝)**: Combina duas tabelas com base em uma condição (e.g., `funcionarios ⨝ departamentos`).
    - **Agregação (γ)**: Realiza cálculos como soma, média, contagem, etc. (e.g., `γ(avg(salario))`).
    - **Renomeação (ρ)**: Renomeia atributos ou relações.
    - **Operações Estendidas**: Podem incluir funções de agregação, atributos calculados, ou operações personalizadas.

- **Nodo Raiz**:
  - Representa a operação final que produz o resultado da consulta.
  - Exemplo: A projeção final que retorna os dados solicitados.

---

#### 2. **Exemplo de Árvore de Consulta**

Considere a seguinte consulta SQL:

```sql
SELECT nome, salario 
FROM funcionarios 
WHERE departamento = 'Vendas' 
  AND salario > 5000;
```

A árvore de consulta correspondente em álgebra relacional seria:

```
        π(nome, salario)
            |
        σ(departamento = 'Vendas' ∧ salario > 5000)
            |
        funcionarios
```

- **Nodo Folha**: `funcionarios` (tabela do banco de dados).
- **Nodo Interno**: `σ(departamento = 'Vendas' ∧ salario > 5000)` (operação de seleção).
- **Nodo Raiz**: `π(nome, salario)` (operação de projeção).

---

#### 3. **Processamento da Árvore de Consulta**

O processamento da árvore de consulta ocorre de baixo para cima (bottom-up), onde cada nodo interno é executado quando seus operandos (nodos filhos) estão disponíveis. O processo pode ser descrito da seguinte forma:

1. **Execução dos Nodos Folha**:
   - As relações base (tabelas do banco de dados) são carregadas ou acessadas.
   - Se o nodo folha for um resultado intermediário de uma subconsulta, ele já estará disponível.

2. **Execução dos Nodos Internos**:
   - Cada operação da álgebra relacional é aplicada aos dados provenientes dos nodos filhos.
   - O resultado de cada operação é uma nova relação (resultado intermediário), que substitui o nodo interno na árvore.

3. **Substituição dos Nodos**:
   - Conforme os nodos internos são executados, eles são substituídos pelas relações resultantes.
   - A árvore é "reduzida" à medida que os nodos são processados.

4. **Execução do Nodo Raiz**:
   - Quando o nodo raiz é executado, ele produz o resultado final da consulta.
   - A execução termina quando o nodo raiz é processado.

---

#### 4. **Exemplo de Processamento**

Vamos expandir o exemplo anterior com uma consulta mais complexa:

```sql
SELECT d.nome_departamento, AVG(f.salario) AS media_salario
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
WHERE d.localizacao = 'São Paulo'
GROUP BY d.nome_departamento;
```

A árvore de consulta correspondente seria:

```
        γ(nome_departamento, AVG(salario) AS media_salario)
            |
        σ(localizacao = 'São Paulo')
            |
        funcionarios ⨝ departamentos
        /             \
  funcionarios     departamentos
```

##### Passos de Processamento:

1. **Nodos Folha**:
   - Carregar as tabelas `funcionarios` e `departamentos`.

2. **Junção (⨝)**:
   - Realizar a junção entre `funcionarios` e `departamentos` com base na condição `f.departamento_id = d.id`.
   - O resultado é uma nova relação temporária com todas as colunas de ambas as tabelas.

3. **Seleção (σ)**:
   - Aplicar o filtro `localizacao = 'São Paulo'` na relação resultante da junção.
   - O resultado é uma relação menor, contendo apenas os funcionários que trabalham em departamentos localizados em São Paulo.

4. **Agregação (γ)**:
   - Agrupar os dados por `nome_departamento` e calcular a média do salário (`AVG(salario)`).
   - O resultado final é uma relação com duas colunas: `nome_departamento` e `media_salario`.

5. **Nodo Raiz**:
   - O nodo raiz retorna o resultado final da consulta.

---

#### 5. **Vantagens da Árvore de Consulta**

- **Modularidade**: Cada operação é representada por um nodo, o que facilita a compreensão e a otimização da consulta.
- **Flexibilidade**: A árvore pode ser reorganizada ou reescrita para melhorar o desempenho (e.g., aplicar seleções antes de junções).
- **Otimização**: O SGBD pode usar a árvore para gerar diferentes planos de execução e escolher o mais eficiente.


![texto](./imagens/proc3.png)

### Transformação

A etapa de **transformação** no processamento de consultas em um Sistema de Gerenciamento de Banco de Dados (SGBD) é uma fase crítica que ocorre após a tradução da consulta SQL para uma representação interna (como uma árvore algébrica). Nessa etapa, a consulta é **reescrita** ou **reorganizada** para melhorar sua eficiência, sem alterar o resultado final. O objetivo principal é gerar uma **árvore otimizada algebricamente**, que será usada para definir o plano de execução.

Vamos detalhar essa etapa:

---

### 1. **Objetivo da Transformação**

O objetivo da transformação é **melhorar o desempenho da consulta** por meio de técnicas de reescrita e reorganização da árvore algébrica. Isso envolve:

- **Redução de Custo**: Minimizar o tempo de execução e o uso de recursos (e.g., I/O, CPU).
- **Simplificação**: Remover operações desnecessárias ou redundantes.
- **Reordenação**: Aplicar operações na ordem mais eficiente (e.g., filtrar antes de juntar).

---

### 2. **Técnicas de Transformação**

A transformação utiliza várias técnicas de reescrita e otimização, incluindo:

#### a) **Aplicação de Regras de Equivalência**
   - A álgebra relacional possui regras que permitem reescrever expressões de forma equivalente, mas mais eficiente.
   - Exemplos:
     - **Comutatividade da Seleção**: `σ(A ∧ B)(R) ≡ σ(B ∧ A)(R)`.
     - **Associatividade da Junção**: `(R ⨝ S) ⨝ T ≡ R ⨝ (S ⨝ T)`.
     - **Pushdown de Seleção**: Aplicar seleções o mais cedo possível para reduzir o número de linhas processadas.

#### b) **Pushdown de Seleções e Projeções**
   - **Pushdown de Seleção**: Mover operações de seleção (`σ`) para o mais próximo possível das tabelas base, reduzindo o volume de dados processados.
     - Exemplo:
       - Antes: `π(nome) (σ(salario > 5000) (funcionarios ⨝ departamentos)`.
       - Depois: `π(nome) ((σ(salario > 5000) (funcionarios)) ⨝ departamentos)`.
   - **Pushdown de Projeção**: Mover operações de projeção (`π`) para eliminar colunas desnecessárias o mais cedo possível.

#### c) **Reordenação de Junções**
   - Reordenar as junções para minimizar o tamanho dos resultados intermediários.
   - Exemplo:
     - Se `R` é pequena e `S` é grande, é mais eficiente fazer `R ⨝ S` do que `S ⨝ R`.

#### d) **Eliminação de Operações Redundantes**
   - Remover operações desnecessárias, como seleções ou projeções redundantes.
   - Exemplo:
     - Se uma projeção já foi aplicada, não é necessário aplicá-la novamente.

#### e) **Uso de Vistas Materializadas**
   - Substituir partes da consulta por vistas materializadas pré-calculadas, se disponíveis.

---

### 3. **Exemplo de Transformação**

Considere a seguinte consulta SQL:

```sql
SELECT nome, salario 
FROM funcionarios 
WHERE departamento = 'Vendas' 
  AND salario > 5000;
```

#### Árvore Algébrica Inicial (Após Tradução):

```
        π(nome, salario)
            |
        σ(departamento = 'Vendas' ∧ salario > 5000)
            |
        funcionarios
```

#### Transformações Aplicadas:

1. **Pushdown de Seleção**:
   - A seleção `σ(departamento = 'Vendas' ∧ salario > 5000)` já está próxima da tabela base, então não há necessidade de alteração.

2. **Simplificação**:
   - Neste caso, a árvore já está simplificada, mas em consultas mais complexas, operações redundantes seriam removidas.

3. **Reordenação de Condições**:
   - Se houvesse múltiplas condições, elas poderiam ser reordenadas para aplicar primeiro a condição mais restritiva.

#### Árvore Otimizada:

A árvore permanece a mesma, mas em consultas mais complexas, a transformação resultaria em uma árvore significativamente diferente e mais eficiente.

Vamos substituir o exemplo anterior por um mais complexo, que envolve múltiplas tabelas, junções, seleções e projeções. Isso permitirá ilustrar melhor as técnicas de transformação aplicadas em consultas mais elaboradas.

---

#### 3.1 **Exemplo de Transformação (Complexo)**

Considere a seguinte consulta SQL:

```sql
SELECT d.nome_departamento, AVG(f.salario) AS media_salario
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
WHERE d.localizacao = 'São Paulo'
  AND f.salario > 5000
GROUP BY d.nome_departamento;
```

#### Árvore Algébrica Inicial (Após Tradução):

A consulta é convertida em uma árvore algébrica inicial, que pode ser representada da seguinte forma:

```
        γ(nome_departamento, AVG(salario) AS media_salario)
            |
        σ(localizacao = 'São Paulo' ∧ salario > 5000)
            |
        funcionarios ⨝ departamentos
        /             \
  funcionarios     departamentos
```

#### Transformações Aplicadas:

1. **Pushdown de Seleção**:
   - Aplicar as seleções o mais cedo possível para reduzir o volume de dados processados.
   - A seleção `σ(localizacao = 'São Paulo')` pode ser aplicada diretamente na tabela `departamentos`.
   - A seleção `σ(salario > 5000)` pode ser aplicada diretamente na tabela `funcionarios`.

   Árvore após pushdown de seleção:

   ```
           γ(nome_departamento, AVG(salario) AS media_salario)
               |
           (σ(salario > 5000)(funcionarios) ⨝ (σ(localizacao = 'São Paulo')(departamentos))
           /                                     \
   funcionarios                             departamentos
   ```

2. **Reordenação de Junções**:
   - Se a tabela `departamentos` após a seleção `σ(localizacao = 'São Paulo')` for significativamente menor que a tabela `funcionarios`, a junção pode ser reordenada para processar primeiro a tabela menor.

   Árvore após reordenação de junções:

   ```
           γ(nome_departamento, AVG(salario) AS media_salario)
               |
           (σ(localizacao = 'São Paulo')(departamentos) ⨝ (σ(salario > 5000)(funcionarios))
           /                                     \
   departamentos                             funcionarios
   ```

3. **Pushdown de Projeção**:
   - A projeção pode ser aplicada para eliminar colunas desnecessárias antes da junção.
   - Na tabela `funcionarios`, apenas as colunas `departamento_id` e `salario` são necessárias.
   - Na tabela `departamentos`, apenas as colunas `id` e `nome_departamento` são necessárias.

   Árvore após pushdown de projeção:

   ```
           γ(nome_departamento, AVG(salario) AS media_salario)
               |
           (π(id, nome_departamento)(σ(localizacao = 'São Paulo')(departamentos))) 
           ⨝ 
           (π(departamento_id, salario)(σ(salario > 5000)(funcionarios)))
           /                                     \
   departamentos                             funcionarios
   ```

4. **Simplificação**:
   - Verificar se há operações redundantes ou desnecessárias. Neste caso, a árvore já está simplificada.

---

#### 4. **Árvore Otimizada**

Após as transformações, a árvore otimizada final é:

```
           γ(nome_departamento, AVG(salario) AS media_salario)
               |
           (π(id, nome_departamento)(σ(localizacao = 'São Paulo')(departamentos))) 
           ⨝ 
           (π(departamento_id, salario)(σ(salario > 5000)(funcionarios)))
           /                                     \
   departamentos                             funcionarios
```

---

#### 5. **Explicação das Transformações**

- **Pushdown de Seleção**:
  - As seleções foram aplicadas diretamente nas tabelas base, reduzindo o número de linhas processadas antes da junção.
  - Isso diminui o custo da junção, pois menos dados precisam ser combinados.

- **Reordenação de Junções**:
  - A junção foi reordenada para processar primeiro a tabela menor (`departamentos` após a seleção), o que é mais eficiente.

- **Pushdown de Projeção**:
  - A projeção eliminou colunas desnecessárias antes da junção, reduzindo o tamanho dos dados manipulados.

---

#### 6. **Resultado da Transformação**

A árvore otimizada resultante é mais eficiente do que a árvore original, pois:

- Reduz o volume de dados processados nas operações de seleção e junção.
- Minimiza o uso de memória e I/O durante a execução.
- Prepara a consulta para a geração de um plano de execução eficiente.

---

### 4. **Importância da Transformação**

- **Melhoria de Desempenho**:
  - A transformação pode reduzir drasticamente o tempo de execução e o uso de recursos, especialmente em consultas complexas.

- **Flexibilidade**:
  - A árvore transformada pode ser adaptada para diferentes cenários, como a disponibilidade de índices ou estatísticas atualizadas.

- **Preparação para o Plano de Execução**:
  - A árvore otimizada serve como entrada para a geração do plano de execução, que define como as operações serão implementadas fisicamente.


![texto](./imagens/proc4.png)

### Exemplo

![texto](./imagens/proc5.png)

### Definição do Plano de Execução

A etapa de **Definição do Plano de Execução** é uma fase crítica no processamento de consultas em um Sistema de Gerenciamento de Banco de Dados (SGBD). Nessa etapa, a **árvore otimizada** (resultante da etapa de transformação) é convertida em um **plano de execução** detalhado, que especifica como as operações da consulta serão implementadas fisicamente. O plano de execução inclui estratégias de acesso aos dados, algoritmos específicos para operações como junções e ordenações, e a ordem em que as operações serão executadas.

Vamos detalhar essa etapa:

---

### 1. **Objetivo da Definição do Plano de Execução**

O objetivo principal é **traduzir a árvore otimizada em um plano concreto** que o SGBD possa executar de forma eficiente. Isso envolve:

- **Escolha de Estratégias de Acesso**:
  - Decidir como os dados serão acessados (e.g., uso de índices, varredura completa da tabela).
- **Seleção de Algoritmos**:
  - Escolher algoritmos eficientes para operações como junções, ordenações e agregações.
- **Ordem de Execução**:
  - Definir a sequência em que as operações serão realizadas para minimizar o custo de execução.

---

### 2. **Componentes do Plano de Execução**

Um plano de execução é composto por:

#### a) **Estratégias de Acesso**
   - Define como os dados serão recuperados das tabelas.
   - Exemplos:
     - **Varredura Completa (Full Table Scan)**: Ler todas as linhas de uma tabela.
     - **Uso de Índices**: Usar um índice para acessar diretamente as linhas que atendem a uma condição.
     - **Acesso por Chave Primária**: Acessar uma linha específica usando a chave primária.

#### b) **Algoritmos para Operações**
   - Define os algoritmos que serão usados para implementar operações da álgebra relacional.
   - Exemplos:
     - **Junções**:
       - **Nested Loop Join**: Adequado para tabelas pequenas ou quando um índice está disponível.
       - **Hash Join**: Eficiente para junções de grandes volumes de dados.
       - **Merge Join**: Útil quando as tabelas já estão ordenadas.
     - **Ordenações**:
       - **QuickSort**, **MergeSort**: Algoritmos para ordenar dados.
     - **Agregações**:
       - Algoritmos para calcular funções como `SUM`, `AVG`, `COUNT`, etc.

#### c) **Ordem de Execução**
   - Define a sequência em que as operações serão realizadas.
   - Exemplo:
     - Aplicar seleções antes de junções para reduzir o volume de dados.

#### d) **Estimativas de Custo**
   - O SGBD usa estatísticas sobre os dados (e.g., número de linhas, distribuição de valores) para estimar o custo de diferentes estratégias e escolher a mais eficiente.

---

### 3. **Exemplo de Definição do Plano de Execução**

Considere a seguinte consulta SQL:

```sql
SELECT d.nome_departamento, AVG(f.salario) AS media_salario
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.id
WHERE d.localizacao = 'São Paulo'
  AND f.salario > 5000
GROUP BY d.nome_departamento;
```

#### Árvore Otimizada (Após Transformação):

```
           γ(nome_departamento, AVG(salario) AS media_salario)
               |
           (π(id, nome_departamento)(σ(localizacao = 'São Paulo')(departamentos))) 
           ⨝ 
           (π(departamento_id, salario)(σ(salario > 5000)(funcionarios)))
           /                                     \
   departamentos                             funcionarios
```

#### Plano de Execução Gerado:

1. **Acesso aos Dados**:
   - **Tabela `departamentos`**:
     - Usar um índice na coluna `localizacao` para aplicar a seleção `σ(localizacao = 'São Paulo')`.
     - Projetar apenas as colunas `id` e `nome_departamento`.
   - **Tabela `funcionarios`**:
     - Usar um índice na coluna `salario` para aplicar a seleção `σ(salario > 5000)`.
     - Projetar apenas as colunas `departamento_id` e `salario`.

2. **Junção**:
   - Usar **Hash Join** para juntar as tabelas `departamentos` e `funcionarios` na condição `f.departamento_id = d.id`.
   - O Hash Join é escolhido porque as seleções já reduziram o tamanho das tabelas, e esse algoritmo é eficiente para junções de volumes moderados de dados.

3. **Agregação**:
   - Usar um algoritmo de agregação para calcular `AVG(salario)` agrupado por `nome_departamento`.
   - O SGBD pode usar uma estrutura de dados temporária (e.g., uma tabela hash) para armazenar os grupos e calcular a média.

4. **Ordenação (Opcional)**:
   - Se a consulta incluísse `ORDER BY`, o SGBD poderia usar um algoritmo de ordenação (e.g., MergeSort) para ordenar os resultados finais.

---

### 4. **Importância da Definição do Plano de Execução**

- **Eficiência**:
  - Um bom plano de execução minimiza o tempo de resposta e o uso de recursos (e.g., I/O, CPU).
- **Adaptabilidade**:
  - O plano pode ser ajustado com base em estatísticas atualizadas sobre os dados.
- **Transparência**:
  - O plano de execução permite que os administradores de banco de dados entendam e otimizem consultas complexas.

---

### 5. **Ferramentas para Análise do Plano de Execução**

Muitos SGBDs oferecem ferramentas para visualizar e analisar o plano de execução gerado. Exemplos:

- **EXPLAIN** (em SQL):
  - Comando que exibe o plano de execução de uma consulta sem executá-la.
  - Exemplo:
    ```sql
    EXPLAIN
    SELECT d.nome_departamento, AVG(f.salario) AS media_salario
    FROM funcionarios f
    JOIN departamentos d ON f.departamento_id = d.id
    WHERE d.localizacao = 'São Paulo'
      AND f.salario > 5000
    GROUP BY d.nome_departamento;
    ```

- **Ferramentas Gráficas**:
  - Alguns SGBDs (e.g., PostgreSQL, MySQL) fornecem interfaces gráficas para visualizar o plano de execução.


![texto](./imagens/proc6.png)

### Exemplo

![texto](./imagens/proc7.png)

### Final do Processamento

![texto](./imagens/proc8.png)

