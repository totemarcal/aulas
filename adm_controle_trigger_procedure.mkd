# Controle de Dados

## GRANT/REVOKE

Os comandos `GRANT` e `REVOKE` são utilizados no SQL para conceder e revogar permissões de acesso a objetos do banco de dados, garantindo um controle adequado sobre a segurança dos dados.

- Cada objeto do banco de dados tem um dono (*owner*), que é o seu criador.
- Apenas o criador ou dono pode acessar os objetos inicialmente.
- O SQL oferece um esquema de permissões através dos comandos `GRANT` e `REVOKE` para permitir ou restringir o acesso a outros usuários.

## GRANT

O comando `GRANT` é utilizado para conceder permissões a usuários específicos ou públicos para realizar determinadas operações no banco de dados.

### Permissão de comandos DDL
O `GRANT` pode ser usado para conceder permissões sobre comandos de manipulação da estrutura do banco de dados (DDL - *Data Definition Language*).

```sql
GRANT {comando} TO {usuário};
```

### Permissão de acesso a objetos
O `GRANT` também permite definir permissões específicas sobre tabelas, visões e outros objetos do banco de dados.

```sql
GRANT {comando} ON {object} TO {usuário} [WITH GRANT OPTION];
```

- **MS SQL Server** – Especifica colunas após `{object}`.
- **Oracle** – Especifica colunas após `{comando}`.

### Opção `WITH GRANT OPTION`
Ao adicionar `WITH GRANT OPTION`, o usuário que recebeu a permissão pode conceder a mesma permissão a outros usuários.

### Exemplos de `GRANT`
```sql
GRANT ALTER ON empregado TO alan;
GRANT SELECT, INSERT, UPDATE, DELETE ON empregado TO alan;
GRANT ALL ON empregado TO alan;
GRANT SELECT ON departamento TO alan WITH GRANT OPTION;
```

## REVOKE

O comando `REVOKE` é utilizado para retirar as permissões previamente concedidas a um usuário.

```sql
REVOKE {comando} ON {object} FROM {usuário};
```

### Importância do `REVOKE`
- Permite revogar acessos de usuários quando não são mais necessários.
- Pode ser usado para restringir privilégios que foram concedidos acidentalmente ou que não são mais adequados.
- Se um usuário perder uma permissão que recebeu com `WITH GRANT OPTION`, todas as permissões concedidas por ele a outros usuários também serão removidas.

### Exemplos de `REVOKE`
```sql
REVOKE DELETE ON empregado FROM alan;
REVOKE ALL ON empregado FROM alan;
REVOKE ALL ON empregado FROM PUBLIC;
```
---

## Especificação de Restrições Básicas em SQL

Além das restrições de chave, é possível incluir restrições adicionais de domínio para garantir a integridade dos dados.

### CHECK Constraint
A restrição `CHECK` é usada para definir uma condição que os valores de uma coluna devem satisfazer. Se um valor não atender à condição especificada, a inserção ou atualização da linha será rejeitada.

### Restrições sobre Campos
As restrições podem ser aplicadas diretamente nas colunas da tabela para impor regras de integridade.

```sql
CREATE TABLE Produto (
    Codigo VARCHAR(20),
    Nome VARCHAR(50),
    Saldo NUMBER,
    CHECK (Saldo BETWEEN 0 AND 40)
);
```

- CREATE TABLE Produto (: Cria uma nova tabela chamada Produto.
- Codigo VARCHAR(20),: Define a coluna Codigo como um tipo de dado VARCHAR (texto variável) com comprimento máximo de 20 caracteres.
- Nome VARCHAR(50),: Define a coluna Nome como um tipo de dado VARCHAR com comprimento máximo de 50 caracteres.
- Saldo NUMBER,: Define a coluna Saldo como um tipo de dado numérico (NUMBER), que pode armazenar valores numéricos.
- CHECK (Saldo BETWEEN 0 AND 40): Aplica uma restrição de verificação (CHECK) na coluna Saldo, garantindo que os valores inseridos nesta coluna estejam entre 0 e 40 (inclusive).
- ): Finaliza a definição da tabela.

### Restrições sobre Tuplas
As restrições também podem ser adicionadas para garantir relações entre os valores das colunas.

```sql
ALTER TABLE entrega ADD
    CHECK (DataSaida <= DataChegada);
```

---

## Gatilhos ou Triggers

Os *Triggers* são procedimentos armazenados que são automaticamente executados em resposta a eventos específicos em uma tabela, como operações `INSERT`, `UPDATE` ou `DELETE`.

### Tipos de Triggers

1. **BEFORE TRIGGER**: Executa antes da operação (`INSERT`, `UPDATE`, `DELETE`).
2. **AFTER TRIGGER**: Executa após a operação.
3. **INSTEAD OF TRIGGER**: Substitui a operação original, muito útil para `VIEWs`.

### Criando um Trigger para Auditoria de Alterações no Salário

O exemplo abaixo cria um *trigger* que registra todas as alterações feitas no atributo `salario` de um empregado na tabela `Audit_Salario`.

```sql
CREATE TABLE Audit_Salario (
    ID NUMBER(6),
    data DATE,
    new_sal NUMBER(8,2),
    old_sal NUMBER(8,2)
);

CREATE OR REPLACE TRIGGER Audit_sal
AFTER UPDATE OF salario ON Empregado FOR EACH ROW
BEGIN
    INSERT INTO Audit_Salario VALUES(:OLD.Matricula, SYSDATE, :NEW.salario, :OLD.salario);
END;
```

CREATE TABLE Audit_Salario: Esse comando cria uma nova tabela chamada Audit_Salario no banco de dados. O propósito dessa tabela é armazenar as alterações nos salários dos empregados.

- ID NUMBER(6): A coluna ID é do tipo NUMBER(6), ou seja, pode armazenar números com até 6 dígitos. Essa coluna é usada para registrar o identificador do empregado, que provavelmente seria o número de matrícula do empregado (exemplo: Matricula na tabela Empregado).

- data DATE: A coluna data armazena a data em que a alteração foi realizada. O tipo de dado é DATE, que armazena data e hora.

- new_sal NUMBER(8,2): A coluna new_sal armazena o novo salário do empregado. O tipo de dado NUMBER(8,2) significa que o valor pode ter até 8 dígitos no total, sendo 2 deles após o ponto decimal (por exemplo, 999999.99).

- old_sal NUMBER(8,2): A coluna old_sal armazena o salário anterior do empregado, no mesmo formato do new_sal.

- CREATE OR REPLACE TRIGGER Audit_sal: Este comando cria ou substitui o trigger chamado Audit_sal. Um trigger é um tipo de objeto do banco de dados que executa automaticamente uma ação quando ocorre um evento específico (como uma atualização, inserção ou exclusão).

- AFTER UPDATE OF salario ON Empregado: Define que o trigger será acionado depois de uma atualização na tabela Empregado, especificamente quando a coluna salario for alterada. Ou seja, sempre que o salário de um empregado for modificado, o trigger será executado.

- FOR EACH ROW: Esta cláusula indica que o trigger será executado para cada linha afetada pela atualização. Isso significa que, se a atualização alterar múltiplas linhas, o trigger será executado uma vez para cada linha afetada.

- BEGIN ... END;: O código entre BEGIN e END define o que o trigger irá fazer quando for acionado. No caso deste trigger, ele executa uma ação de inserção na tabela Audit_Salario.

- INSERT INTO Audit_Salario (ID, data, new_sal, old_sal): O trigger insere uma nova linha na tabela Audit_Salario, registrando os dados relacionados à alteração do salário.

- VALUES(:OLD.Matricula, SYSDATE, :NEW.salario, :OLD.salario);: O comando INSERT insere os valores nas colunas da tabela Audit_Salario:

- :OLD.Matricula: Refere-se ao valor antigo da coluna Matricula (matrícula do empregado) na linha antes de ser alterada.
SYSDATE: Retorna a data e hora atuais do sistema, que é registrada como a data da alteração.
- :NEW.salario: Refere-se ao novo valor da coluna salario na linha após a atualização.
- :OLD.salario: Refere-se ao valor antigo da coluna salario antes da atualização.

Para testar o *trigger*, podemos executar o seguinte comando:

```sql
UPDATE empregado SET salario = salario * 1.01 WHERE Bairro = 'Pituba';
```

Em seguida, podemos verificar os registros na tabela de auditoria:

```sql
SELECT * FROM Audit_Salario;
```

### Criando Triggers para Atualizar o Campo `TotalSal` na Tabela `Departamento`

```sql
    ALTER TABLE Departamento ADD TotalSal NUMBER;
    UPDATE Departamento SET TotalSal = 0;

    CREATE TRIGGER TotalSalario
    AFTER INSERT ON empregado FOR EACH ROW
    BEGIN
        UPDATE departamento
        SET totalsal = totalsal + :new.salario
        WHERE cod = :new.coddepart;
    END;
```

- Acrescenta a coluna TotalSal na tabela Departamento para armazenar o total dos salários dos empregados de cada departamento.
- Garante que todos os departamentos começam com um total de salários igual a 0.
- Esse trigger é acionado depois (AFTER) de uma inserção (INSERT) na tabela Empregado.
Para cada nova linha adicionada (FOR EACH ROW), ele:
- Atualiza a tabela Departamento, somando o valor do salário recém-inserido (:NEW.- salario) ao total acumulado (TotalSal).
- Usa :NEW.coddepart para garantir que a atualização seja feita no departamento correto.



### Exemplo de INSTEAD OF TRIGGER para VIEW

Se tivermos uma `VIEW` chamada `Empregado_Departamento`, podemos criar um `INSTEAD OF TRIGGER` para gerenciar inserções:

```sql
CREATE VIEW Empregado_Departamento AS
SELECT e.Matricula, e.Nome, d.Nome AS Departamento
FROM Empregado e
JOIN Departamento d ON e.CodDepart = d.Cod;

CREATE TRIGGER InsteadOfInsertEmpDept
INSTEAD OF INSERT ON Empregado_Departamento
FOR EACH ROW
BEGIN
    INSERT INTO Empregado (Matricula, Nome, CodDepart)
    VALUES (:NEW.Matricula, :NEW.Nome, (SELECT Cod FROM Departamento WHERE Nome = :NEW.Departamento));
END;
```

- A view exibe informações dos empregados junto com o nome de seu respectivo departamento.
- Os dados vêm de uma junção (JOIN) entre as tabelas Empregado e Departamento.
- A coluna CodDepart da tabela Empregado é usada para ligar com a coluna Cod da tabela Departamento.
- Esse trigger é do tipo INSTEAD OF INSERT, que substitui a tentativa de inserção direta na view por outra ação.
- Ele intercepta qualquer comando INSERT na view Empregado_Departamento e, em vez disso, insere os dados diretamente na tabela Empregado.
- Como a view não possui a coluna CodDepart (somente Departamento), o trigger faz uma subconsulta para buscar o código (Cod) correspondente ao nome do departamento (:NEW.Departamento).
- Assim, o novo empregado é inserido corretamente na tabela Empregado, mantendo a integridade dos dados.


Esse `INSTEAD OF TRIGGER` permite que insiramos dados na `VIEW`, e o banco de dados automaticamente os distribua para as tabelas correspondentes.

Os *triggers* são ferramentas poderosas para garantir integridade, automação de regras de negócio e auditoria dentro de um banco de dados relacional.

---


# Procedimentos Armazenados ou Stored Procedures

## Definição

Procedimentos armazenados, ou *Stored Procedures*, são um conjunto de instruções SQL que são armazenadas e executadas no banco de dados. Elas são acionadas por um comando `EXECUTE`.

Um procedimento armazenado forma uma unidade lógica que executa uma tarefa específica no banco de dados. São usados para encapsular operações ou acessos para execução em um servidor de banco de dados.

Podem ser compiladas e executadas com diferentes parâmetros e resultados, além de suportar qualquer combinação de parâmetros de entrada e saída. São compatíveis com a maioria dos SGBDs, mas a sintaxe e as capacidades podem variar entre eles.

### Exemplos de linguagens usadas para Procedimentos Armazenados

- **ORACLE**: PL/SQL ou Java
- **SYBASE**: TRANSACT-SQL
- **MS SQL SERVER**: TRANSACT-SQL

## Benefícios dos Procedimentos Armazenados

- **Promoção da programação modular**: Facilitam a organização do código, permitindo que partes específicas da lógica sejam reutilizadas.
- **Execução mais rápida**: Como são compilados e otimizados previamente, procedimentos armazenados têm um desempenho superior em relação a instruções SQL executadas diretamente.
- **Redução do tráfego na rede**: Como a lógica é executada no servidor de banco de dados, não há necessidade de enviar múltiplas instruções SQL pela rede.

Procedimentos armazenados podem ser alterados com o comando `ALTER` ou excluídos com o comando `DROP`.

## Exemplo 1: Criação de uma Stored Procedure

```sql
CREATE OR REPLACE PROCEDURE data_atual AS
BEGIN
    -- Mostra a data do sistema em um formato completo
    DBMS_OUTPUT.PUT_LINE('Hoje é ' || TO_CHAR(SYSDATE, 'DL'));
END data_atual;
```

1. CREATE OR REPLACE PROCEDURE data_atual AS:

- Esse comando cria um novo procedimento armazenado chamado data_atual, ou substitui um procedimento existente com esse nome, caso já exista no banco de dados.
- CREATE OR REPLACE: A palavra-chave CREATE cria um novo objeto, enquanto REPLACE substitui qualquer objeto existente com o mesmo nome.
- PROCEDURE data_atual: A palavra-chave PROCEDURE indica que estamos criando um procedimento armazenado e data_atual é o nome do procedimento.

2. BEGIN:

- Inicia o bloco do código que contém as instruções que o procedimento vai executar. Todo o código do procedimento deve estar entre BEGIN e END.

3. -- Mostra a data do sistema em um formato completo:

- Este é um comentário no código. O texto após -- não é executado, serve apenas para fornecer informações ao desenvolvedor sobre o que o código faz.

4. DBMS_OUTPUT.PUT_LINE('Hoje é ' || TO_CHAR(SYSDATE, 'DL'));:

- DBMS_OUTPUT.PUT_LINE: Este comando é usado para exibir ou imprimir informações no console de saída do Oracle, uma funcionalidade útil para debug ou simplesmente para mostrar informações ao usuário.
- 'Hoje é ': Esta é uma string literal que será exibida antes da data.
- ||: O operador de concatenação de strings no Oracle, utilizado para juntar várias partes de texto.
- TO_CHAR(SYSDATE, 'DL'): O comando TO_CHAR converte a data do sistema (SYSDATE) para uma string, no formato especificado. O formato 'DL' não é um formato padrão, mas poderia ser personalizado conforme a necessidade (um exemplo típico seria 'DD/MM/YYYY' para uma data no formato dia/mês/ano). Aqui, parece que a intenção era mostrar a data completa do sistema.
- O resultado final será algo como: Hoje é 09/03/2025, dependendo da data do sistema.

5. END data_atual;:

- Finaliza o bloco do procedimento, indicando que não há mais instruções a serem executadas.
O nome data_atual após END é opcional e serve apenas para reforçar o nome do procedimento no final, facilitando a leitura e identificação.

### Chamada da Procedure

```sql
BEGIN
    data_atual(); -- Os parênteses são opcionais
END;
```

## Exemplo 2: Criação de uma Stored Procedure para Reajuste de Salário

```sql
CREATE PROCEDURE Reajusta_Salario (SAL NUMBER) AS
BEGIN
    UPDATE Empregado SET Salario = Salario * SAL;
    COMMIT;
END Reajusta_Salario;
```
- CREATE PROCEDURE Reajusta_Salario (SAL NUMBER) AS: Cria o procedimento Reajusta_Salario, que recebe um parâmetro SAL do tipo NUMBER, representando o fator de reajuste salarial.
- BEGIN: Inicia o bloco de instruções do procedimento.
- UPDATE Empregado SET Salario = Salario * SAL;: Atualiza o salário de todos os empregados na tabela Empregado, multiplicando o salário atual de cada um pelo valor de SAL passado como parâmetro.
- COMMIT;: Confirma a transação, garantindo que as alterações no banco de dados sejam salvas.
- END Reajusta_Salario;: Finaliza o procedimento.

### Chamada da Procedure

```sql
BEGIN
    Reajusta_Salario(1.2); -- Reajusta o salário em 20%
END;
```

### Consulta após o reajuste

```sql
SELECT Salario FROM Empregado WHERE Coddepart = 1;
```

## Exemplo 3: Criando uma Rotina para Processar Pedidos

### Criação da Tabela e Alteração

```sql
CREATE TABLE PEDIDO (
    Codigo CHAR(20),
    Nome CHAR(20),
    Quantidade INT
);

ALTER TABLE PRODUTO ADD SaldoMinimo INT; -- Adicionando atributo saldo mínimo na tabela Produto
```

### Criação do Procedimento para Processar Pedidos

```sql
CREATE PROCEDURE Processa_Pedido AS
BEGIN
    INSERT INTO Pedido
    (SELECT Codigo, Nome, SaldoMinimo FROM Produto WHERE Saldo < SaldoMinimo);
END Processa_Pedido;
```

- CREATE PROCEDURE Processa_Pedido AS: Cria o procedimento armazenado Processa_Pedido, que não recebe parâmetros de entrada.
- BEGIN: Inicia o bloco de instruções do procedimento.
- INSERT INTO Pedido (SELECT Codigo, Nome, SaldoMinimo FROM Produto WHERE Saldo < SaldoMinimo);: Este comando insere dados na tabela Pedido a partir de um SELECT na tabela Produto. Ele seleciona o Codigo, Nome, e SaldoMinimo de todos os produtos onde o Saldo é menor que o SaldoMinimo.
- END Processa_Pedido;: Finaliza o procedimento.

### Chamada do Procedimento

```sql
BEGIN
    Processa_Pedido;
END;
```

### Consulta após a execução

```sql
SELECT * FROM Pedido;
```

### Atualização de Dados

```sql
UPDATE PRODUTO SET SaldoMinimo = 20; -- TESTAR NOVAMENTE A CHAMADA DA PROCEDURE
```

## Resumo

Os procedimentos armazenados são uma ferramenta poderosa para centralizar a lógica de negócios no banco de dados, proporcionando maior eficiência, segurança e modularidade. Eles são amplamente utilizados para automatizar tarefas repetitivas, garantir consistência de dados e reduzir o tráfego de rede.


## Apresentação:
# Critérios para Avaliação da Apresentação

A avaliação será dividida em três partes: apresentação teórica, estudo de caso e exercícios práticos. O total de pontos será 10.

## 1. Apresentação Teórica (50 minutos) - **Total: 4 pontos**

- **Completude, Clareza e Domínio dos Conceitos** (2 pontos)
  - Todos os conceitos são apresentados de maneira clara e detalhada.
  - Exemplos práticos são fornecidos para ilustrar cada conceito.
  - A explicação é lógica e segue uma sequência didática.
  - O grupo demonstra domínio sobre os conceitos, respondendo de forma precisa a eventuais perguntas.

- **Qualidade dos Exemplos** (1 ponto)
  - Os exemplos usados são relevantes e bem escolhidos.
  - Cada conceito é claramente ilustrado com exemplos práticos.

- **Clareza na Apresentação Visual** (1 ponto)
  - A apresentação visual (slides, diagramas, gráficos) é bem organizada e facilita o entendimento.

## 2. Estudo de Caso (30 minutos) - **Total: 3 pontos**
- **Relevância e Aplicação Prática** (1 ponto)
  - O estudo de caso está diretamente relacionado aos conceitos apresentados na teoria.
  - O estudo de caso demonstra como os conceitos do modelo conceitual são aplicados de maneira clara.

- **Completação do Estudo de Caso** (1 ponto)
  - O estudo de caso aborda todos os aspectos solicitados.

- **Resolução e Conclusão do Caso** (1 ponto)
  - O estudo de caso é concluído com uma análise clara das soluções obtidas.

## 3. Exercícios Práticos (30 minutos) - **Total: 2 pontos**
- **Desafio e Clareza das Perguntas** (0,5 ponto)
  - Os exercícios são bem formulados e desafiam os colegas a aplicar os conceitos discutidos.

- **Participação e Engajamento da Audiência** (0,5 ponto)
  - Durante a resolução dos exercícios, os colegas são incentivados a participar ativamente e a esclarecer dúvidas.

- **Solução dos Exercícios** (1 ponto)
  - As soluções dos exercícios são apresentadas de forma clara, com explicações passo a passo.

## 4. Apresentação Geral - **Total: 1 ponto**
- **Organização e Distribuição de Tarefas na Squad** (0,5 ponto)
  - A apresentação foi bem organizada, com todos os membros da equipe participando de maneira equilibrada.

- **Tempo de Apresentação** (0,5 ponto)
  - O tempo total foi bem gerido, respeitando os tempos estipulados para cada seção.

---

**Total de Pontos: 10 pontos**

A avaliação será realizada com base nos critérios acima, e a nota final será a soma dos pontos obtidos em cada parte da apresentação.

A avaliação será individual e o trabalho vale 10 pts, que será a nota da AV2.

---


