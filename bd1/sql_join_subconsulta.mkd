# Junções em SQL - Exercícios Resolvidos

## Conceitos Básicos de Junções

Antes de resolver os exercícios, vamos revisar os conceitos apresentados:

1. Junções combinam dados de duas ou mais tabelas
2. Podem ser entre tabelas do mesmo banco ou de bancos diferentes
3. Atributos comparados devem ter valores similares (tipos compatíveis)
4. Valores NULL não participam da junção
5. Atributos na condição de junção não precisam aparecer no SELECT

## Exercícios Resolvidos

### 1. Mostre nome do departamento e todos os seus empregados classificados por nome do departamento e nome do empregado

```sql
SELECT d.nome AS nome_departamento, e.nome AS nome_empregado
FROM departamento d
JOIN empregado e ON d.cod = e.coddepart
ORDER BY d.nome, e.nome;
```

### 2. Mostre o nome e salário de cada empregado que trabalha no projeto "Gestão do Conhecimento"

```sql
SELECT e.nome, e.salario
FROM empregado e
JOIN trabalha_em t ON e.cod = t.codemp
JOIN projeto p ON t.codproj = p.cod
WHERE p.nome = 'Gestão do Conhecimento';
```

### 3. Recupere os nomes do departamento, nome do empregado e nome do projeto ordenados por departamento e nome

```sql
SELECT d.nome AS nome_departamento, e.nome AS nome_empregado, p.nome AS nome_projeto
FROM departamento d
JOIN empregado e ON d.cod = e.coddepart
JOIN trabalha_em t ON e.cod = t.codemp
JOIN projeto p ON t.codproj = p.cod
ORDER BY d.nome, e.nome;
```

## Observações

1. Utilizei a sintaxe moderna de JOIN (com a palavra-chave JOIN) que é mais clara que a sintaxe antiga com vírgulas e WHERE
2. Adicionei aliases (AS) para tornar os resultados mais legíveis
3. As junções assumem que existem relacionamentos entre as tabelas através das chaves primárias e estrangeiras mencionadas
4. A ordenação é feita conforme solicitado em cada exercício


# Junções em SQL - Exercícios Resolvidos (Parte 2)

Vamos resolver os exercícios utilizando os diferentes tipos de JOIN:

## 1. Listar empregados com dependentes (nome e sexo), ordenados por sexo do dependente
```sql
SELECT e.nome AS empregado, d.nome AS dependente, d.sexo
FROM empregado e
LEFT OUTER JOIN dependente d ON e.mat = d.mat
WHERE d.nome IS NOT NULL
ORDER BY d.sexo;
```

## 2. Mostrar total de salários por departamento, ordenado por total
```sql
SELECT d.nome AS departamento, SUM(e.salario) AS total_salarios
FROM departamento d
LEFT JOIN empregado e ON d.cod = e.coddepart
GROUP BY d.nome
ORDER BY total_salarios;
```

## 3. Empregados que ganham mais que seus gerentes (salário + comissão)
```sql
SELECT e.matricula, e.nome, (e.salario + COALESCE(e.comissao, 0)) AS salario_total
FROM empregado e
JOIN departamento d ON e.coddepart = d.cod
JOIN empregado g ON d.matgerente = g.matricula
WHERE (e.salario + COALESCE(e.comissao, 0)) > (g.salario + COALESCE(g.comissao, 0));
```

## 4. Empregados no projeto "Sistema de Pagamento" do departamento "Informática"
```sql
SELECT e.nome, e.funcao
FROM empregado e
JOIN departamento d ON e.coddepart = d.cod AND d.nome = 'Informática'
JOIN trabalha_em t ON e.mat = t.codemp
JOIN projeto p ON t.codproj = p.cod AND p.nome = 'Sistema de Pagamento';
```

## 5. Departamentos com seus gerentes e salários, ordenados por salário descendente
```sql
SELECT d.nome AS departamento, g.nome AS gerente, g.salario
FROM departamento d
JOIN empregado g ON d.matgerente = g.matricula
ORDER BY g.salario DESC;
```

## 6. Projetos em que "Ana Santos" trabalhou (nome, horas, situação)
```sql
SELECT p.nome, t.horas, p.situacao
FROM projeto p
JOIN trabalha_em t ON p.cod = t.codproj
JOIN empregado e ON t.codemp = e.mat AND e.nome = 'Ana Santos';
```

## 7. Quantidade de projetos por situação
```sql
SELECT situacao, COUNT(*) AS quantidade
FROM projeto
GROUP BY situacao;
```

## 8. Empregados com mais de 1 dependente
```sql
SELECT e.nome, COUNT(d.mat) AS qtd_dependentes
FROM empregado e
JOIN dependente d ON e.mat = d.mat
GROUP BY e.nome
HAVING COUNT(d.mat) > 1;
```

## 9. Todos os empregados com seus dependentes (se existirem)
```sql
SELECT e.nome AS empregado, d.nome AS dependente
FROM empregado e
LEFT OUTER JOIN dependente d ON e.mat = d.mat;
```

## 10. Todos os empregados e projetos em que estão envolvidos
```sql
SELECT e.nome AS empregado, p.nome AS projeto
FROM empregado e
LEFT JOIN trabalha_em t ON e.mat = t.codemp
LEFT JOIN projeto p ON t.codproj = p.cod;
```

## 11. Empregados sem dependentes
```sql
SELECT e.nome
FROM empregado e
LEFT JOIN dependente d ON e.mat = d.mat
WHERE d.mat IS NULL;
```

## 12. Quantidade de empregados com dependentes
```sql
SELECT COUNT(DISTINCT e.mat) AS empregados_com_dependentes
FROM empregado e
JOIN dependente d ON e.mat = d.mat;
```

## 13. Departamentos com mais de 5 empregados
```sql
SELECT d.nome, COUNT(e.mat) AS qtd_empregados
FROM departamento d
JOIN empregado e ON d.cod = e.coddepart
GROUP BY d.nome
HAVING COUNT(e.mat) > 5;
```

## 14. Departamentos com média salarial > R$800
```sql
SELECT d.nome, AVG(e.salario) AS media_salarial
FROM departamento d
JOIN empregado e ON d.cod = e.coddepart
GROUP BY d.nome
HAVING AVG(e.salario) > 800;
```

## 15. Departamentos sem empregados
```sql
SELECT d.nome
FROM departamento d
LEFT JOIN empregado e ON d.cod = e.coddepart
WHERE e.mat IS NULL;
```

Observações:
1. Utilizei LEFT JOIN para incluir todos os registros da tabela à esquerda, mesmo quando não há correspondência
2. COALESCE foi usado para tratar valores NULL na comissão
3. HAVING é usado para filtrar resultados de funções de agregação
4. WHERE d.nome IS NOT NULL (no exercício 1) filtra apenas empregados com dependentes


# Structured Query Language (SQL) - Subconsultas e Visões

## 1. Introdução a Subconsultas

Subconsultas são declarações SELECT aninhadas dentro de outras consultas SQL, podendo ser usadas em SELECT, UPDATE, INSERT ou DELETE.

### 1.1 Tipos de Subconsultas

1. **Operador de comparação**: Subconsulta retorna um único valor
   ```sql
   SELECT e.nome FROM empregado e
   WHERE salario = (SELECT MIN(salario) FROM empregado);
   ```

2. **[NOT] IN**: Verifica se um valor pertence ao conjunto retornado
   ```sql
   SELECT mat FROM trabalhaem
   WHERE (codproj, horas) IN 
     (SELECT codproj, horas FROM trabalhaem WHERE mat = 111);
   ```

3. **Operador de comparação [ANY/SOME/ALL]**: Compara com múltiplos valores
   ```sql
   SELECT nome FROM empregado
   WHERE salario > ALL
     (SELECT DISTINCT salario FROM empregado WHERE coddepart = 5);
   ```

4. **[NOT] EXISTS**: Testa existência de registros
   ```sql
   SELECT e.nome FROM empregado e
   WHERE EXISTS
     (SELECT d.nome FROM dependente d WHERE d.matricula = e.matricula);
   ```

## 2. Exemplos Práticos de Subconsultas

### 2.1 Exercícios Resolvidos

1. Empregados com salários maiores que a média do departamento 1:
   ```sql
   SELECT nome, salario FROM empregado
   WHERE salario > (SELECT AVG(salario) FROM empregado WHERE coddepart = 1);
   ```

2. Empregados sem dependentes:
   ```sql
   SELECT e.nome FROM empregado e
   WHERE NOT EXISTS
     (SELECT d.nome FROM dependente d WHERE d.matricula = e.matricula);
   ```

3. Departamentos sem empregados:
   ```sql
   SELECT d.nome FROM departamento d
   WHERE cod NOT IN (SELECT coddepart FROM empregado);
   ```

## 3. Visões em SQL

Visões são tabelas virtuais definidas por consultas SQL, sem armazenamento físico.

### 3.1 Criação de Visões

```sql
CREATE VIEW infodepart (nomedepart, totempregados, totsalarios) AS
SELECT d.nome, COUNT(*), SUM(e.salario) 
FROM Departamento d JOIN Empregado e ON d.cod = e.coddepart
GROUP BY d.nome;
```

### 3.2 Atualizações em Visões

- **WITH CHECK OPTION**: Garante que atualizações não violem condições da visão
- **INSERT**: Só funciona em visões de uma tabela com todos atributos NOT NULL
- **UPDATE**: Só pode afetar atributos de uma única tabela
- **DELETE**: Só funciona em visões de uma única tabela

### 3.3 Exemplo com WITH CHECK OPTION

```sql
CREATE VIEW MaioresSalarios AS
SELECT matricula, funcao, salario FROM empregado
WHERE salario > 3000 WITH CHECK OPTION;

-- Esta inserção falharia se salario for NOT NULL na tabela empregado
INSERT INTO MaioresSalarios (matricula, funcao, salario) 
VALUES (999, 'Analista', 3500);
```

## 4. Boas Práticas em Consultas SQL

1. Evitar usar `*` na lista de seleção
2. Qualificar sempre os atributos com nomes/aliases das tabelas
3. Preferir JOINs a subconsultas quando possível
4. Usar apenas tabelas e atributos necessários
5. Evitar consultas que varrem toda a tabela

## 5. Exercícios Adicionais

1. Crie uma visão que mostre empregados com mais de 5 anos de empresa
2. Escreva uma consulta que encontre projetos sem nenhum empregado alocado
3. Desenvolva uma subconsulta para listar departamentos com salário médio acima de R$5000

## 6. Conclusão

Subconsultas e visões são recursos poderosos do SQL que permitem:
- Simplificar consultas complexas
- Criar abstrações sobre os dados
- Melhorar a segurança e organização do banco de dados
- Aumentar a produtividade no desenvolvimento

Dominar esses conceitos é essencial para trabalhar eficientemente com bancos de dados relacionais.


## Exercícios

1. Recupere os nomes e salários dos empregados cujos salários sejam maiores que a média do departamento 1.
2. Recupere os nomes dos empregados que não possuem dependentes
3. Que empregados moram no mesmo bairro de Luis Inácio?
4. Quais empregados ganham mais que o salário médio dos empregados?
5. Que empregados ganham comissão acima das dos empregados do departamento ‘Administração’?
6. Que empregados participaram de projeto já concluídos (Nome e Função)?
7. Que dependentes têm o mesmo parentesco do dependente Antonio Carlos?
8. Que empregados possuem algum dependente com parentesco semelhante aos dos dependentes de ‘Ana Maria’?
9. Quais departamentos não têm empregados ?
10. Que empregados não estão alocados em projetos ?
11. Que empregados ganham menos que os de função auxiliar ?
12. Recupere o nome do departamento, a função, o total de empregados e o total de salários por departamento e função cujo total de salários seja maior que a médias dos sálarios ordenados por departamento e função.
13. Selecionar todos os empregados do departamento Informática que desempenham papel de Coordenação por mais de 40 hs.
