# **Normalização de Dados: Conceitos e Aprofundamento**

## **1. Introdução à Normalização**
A normalização é um processo fundamental no projeto de bancos de dados relacionais, visando organizar os dados de forma eficiente, reduzir redundâncias e garantir a integridade dos dados. Foi proposta por **Edgar F. Codd** em 1970 como parte de sua teoria sobre o modelo relacional.

A Normalização substitui, gradativamente, um conjunto de Relações (Entidades e Relacionamentos) por um outro mais consistente, evitando anomalias de atualização (inclusão, alteração e exclusão).
A decomposição deve ser sem perdas, significando que precisa ser reversível, sem que nenhuma informação seja perdida.

---

## **2. Objetivos da Normalização**
A normalização busca:
- **Eliminar redundâncias**: Evitar a repetição desnecessária de dados.
- **Minimizar valores nulos**: Reduzir a ocorrência de campos sem informação.
- **Facilitar a manutenção**: Evitar anomalias em operações de inserção, atualização e exclusão.
- **Garantir consistência**: Evitar dados inconsistentes devido a atualizações parciais.
- **Evitar perda de espaço**: Evitar que a mesma informação esteja armazenada em lugares diferentes.
- **Evitar duplicidade de atualização**: Evitar que seja nescessário atualizar a mesma informações em lugares diferentes. 
- **Evita a redundância**: Elaborar esquemas onde seja evitada a redundância de informações e conseqüentemente a inconsistência na atualização dos dados

---

## **3. Semântica dos Atributos**
A semântica refere-se ao **significado** e ao **relacionamento lógico** entre os atributos. Um esquema bem normalizado deve:
- **Agrupar atributos logicamente relacionados** (ex.: dados de um cliente em uma tabela `Cliente`, dados de um produto em `Produto`).
- **Evitar misturar atributos de entidades diferentes** em uma única tabela (ex.: não colocar `Nome_Cliente` e `Preço_Produto` na mesma tabela sem uma relação clara).

---

## **4. Problemas Causados pela Falta de Normalização**
### **4.1. Redundância de Dados**
- Ocorre quando a mesma informação é armazenada múltiplas vezes.
- **Exemplo**: Em uma tabela `Pedidos` que repete o endereço do cliente em cada pedido, qualquer mudança exige atualização em vários registros.

### **4.2. Anomalias de Atualização**
- **Inserção**: Dificuldade em adicionar dados sem informações complementares (ex.: cadastrar um cliente sem um pedido).
- **Exclusão**: Perda acidental de dados (ex.: apagar um pedido e perder informações do cliente).
- **Modificação**: Necessidade de atualizar múltiplos registros para uma única alteração (ex.: mudar o preço de um produto em vários pedidos).

### **4.3. Valores Nulos Excessivos**
- Campos sem dados podem ocupar espaço e dificultar consultas.

---

## **5. Formas Normais (Níveis de Normalização)**
A normalização é aplicada em etapas, conhecidas como **formas normais**:

| **Forma Normal** | **Descrição** | **Exemplo de Problema Resolvido** |
|-----------------|--------------|----------------------------------|
| **1FN** (Primeira Forma Normal) | Todos os atributos devem ser atômicos (indivisíveis). | Evitar múltiplos valores em um campo (ex.: "Telefone1, Telefone2"). |
| **2FN** (Segunda Forma Normal) | Deve estar na 1FN e todos os atributos não-chave devem depender **totalmente** da chave primária. | Remover dependências parciais (ex.: em `Pedido_Item`, `Preço_Produto` deve depender do `ID_Produto`, não do `ID_Pedido`). |
| **3FN** (Terceira Forma Normal) | Deve estar na 2FN e nenhum atributo não-chave pode depender de outro não-chave (eliminar dependências transitivas). | Separar `Cliente` e `Cidade` se `Cidade` depender do `CEP` e não diretamente do `ID_Cliente`. |
| **BCNF** (Boyce-Codd) | Versão reforçada da 3FN, onde toda dependência funcional deve ter uma **superchave** como determinante. | Garantir que nenhum atributo não-chave determine parte da chave. |
| **4FN** e **5FN** | Lidam com dependências multivaloradas e junções. | Casos mais complexos, como relações muitos-para-muitos com atributos adicionais. |

---

## **6. Vantagens da Normalização**
✔ **Economia de armazenamento** (menos dados repetidos).  
✔ **Consultas mais eficientes** (estrutura organizada).  
✔ **Facilidade de manutenção** (alterações consistentes).  
✔ **Integridade dos dados** (evita inconsistências).  

---

## **7. Desvantagens e Quando Desnormalizar**
Em alguns casos, a normalização excessiva pode:
- Aumentar a complexidade de consultas (muitos `JOINs`).  
- Reduzir desempenho em sistemas com muitas operações de leitura.  

**Soluções**:
- **Desnormalização controlada**: Duplicar alguns dados para otimizar consultas.  
- **Uso de views e índices**: Melhorar performance sem comprometer a estrutura.  

--- 

# **Primeira Forma Normal (1FN)**

## **1. Definição Formal da 1FN**
Uma relação está na **Primeira Forma Normal (1FN)** se e somente se:
- Todos os atributos contêm **valores atômicos** (indivisíveis).
- Não existem **grupos repetitivos** (listas, conjuntos ou múltiplos valores em um único campo).

---

## **2. Procedimento para Normalização na 1FN**
### **Passo a Passo**
1. **Identificar grupos repetitivos** (atributos multivalorados).  
   - Ex.: `Telefones` em `Empregado(Matrícula, Nome, Telefones*)`.  
2. **Transformar em atributos distintos** (se possível).  
   - Ex.: Criar `Telefone1`, `Telefone2`, etc. (solução limitada).  
3. **Se não for viável**, criar uma **nova tabela** com:  
   - A **chave primária da tabela original** (`Matrícula`).  
   - O **atributo multivalorado** (`Número`).  
4. **Definir a chave primária da nova tabela**:  
   - Concatenar a chave da tabela original + o atributo multivalorado.  
   - Ex.: `Telefone_Empregado(Matrícula, Número)` → Chave primária = `(Matrícula, Número)`.  

---

## **3. Exemplo Prático**
### **Antes da 1FN (Violação)**
| **Matrícula** | **Nome**      | **Telefones**            |
|---------------|--------------|--------------------------|
| 101           | João Silva   | (11) 9999-1111, (11) 8888-2222 |
| 102           | Maria Souza  | (11) 7777-3333                  |

**Problema**: O campo `Telefones` armazena múltiplos valores (não atômico).

### **Depois da 1FN (Solução Correta)**
**Tabela `Empregado`**  
| **Matrícula** | **Nome**      |
|---------------|--------------|
| 101           | João Silva   |
| 102           | Maria Souza  |

**Tabela `Telefone_Empregado`**  
| **Matrícula** | **Número**       |
|---------------|------------------|
| 101           | (11) 9999-1111   |
| 101           | (11) 8888-2222   |
| 102           | (11) 7777-3333   |

**Chave primária de `Telefone_Empregado`**: `(Matrícula, Número)`.

---

## **4. Outros Exemplos de Atributos Multivalorados**
### **4.1. Endereços de E-mail**
- **Antes**: `Cliente(ID, Nome, Emails*)` → `Emails = "joao@exemplo.com; joao2@exemplo.com"`.  
- **Depois**:  
  - `Cliente(ID, Nome)`  
  - `Email_Cliente(ID, Email)`  

### **4.2. Habilidades de Funcionários**
- **Antes**: `Funcionário(ID, Nome, Habilidades*)` → `Habilidades = "Java, SQL, Python"`.  
- **Depois**:  
  - `Funcionário(ID, Nome)`  
  - `Habilidade_Funcionário(ID, Habilidade)`  

### **4.3. Itens de Pedido**
- **Antes**: `Pedido(Num_Pedido, Cliente, Itens*)` → `Itens = "Notebook, Mouse, Teclado"`.  
- **Depois**:  
  - `Pedido(Num_Pedido, Cliente)`  
  - `Item_Pedido(Num_Pedido, Item)`  

---

## **5. Casos Especiais e Considerações**
### **5.1. Quando Não Decompor?**
- Se o atributo multivalorado for raramente consultado ou não causar redundância (ex.: `Tags` em um blog).  
- Alternativa: Armazenar como **JSON** ou **array** (em bancos NoSQL).  

### **5.2. Problemas Comuns**
- **Chave primária composta muito grande**: Pode impactar desempenho.  
- **Consulta mais complexa**: Necessidade de `JOIN` para recuperar dados completos.  

---

## **6. Exercício Proposto**
Normalize a seguinte tabela para 1FN:  
`Aluno(RA, Nome, Cursos*)`  
Onde `Cursos` armazena múltiplos cursos matriculados (ex.: "Engenharia, Medicina, Direito").  

**Solução Esperada**:  
- `Aluno(RA, Nome)`  
- `Matricula_Aluno(RA, Curso)`  

---

## **7. Conclusão**
A **1FN** é a base da normalização, garantindo que os dados sejam **atômicos** e **livres de repetições**. A decomposição correta evita:  
❌ Redundâncias.  
❌ Dificuldades em consultas.  
❌ Anomalias de atualização.  

Aplicar a 1FN é o **primeiro passo** para um esquema de banco de dados eficiente e consistente.

# **Dependência Funcional (DF) - Análise Detalhada**

## **1. Conceito Fundamental**
Uma **dependência funcional (DF)** é uma restrição que estabelece uma relação de determinação entre atributos em uma tabela. Formalmente:
- **Notação**: `X → Y` (leia-se: "X determina Y" ou "Y é funcionalmente dependente de X").
- **Definição**: Para quaisquer duas tuplas, se os valores de **X** são iguais, então os valores de **Y** também devem ser iguais.

---

## **2. Exemplo Prático**
Considere a tabela de funcionários:

| **CPF**  | **Nome**   | **Função**          | **Salário_Base** |
|----------|------------|---------------------|------------------|
| 1235     | Carlos     | Programador I       | R$ 1.500,00      |
| 1412     | Marta      | DBA Senior          | R$ 4.000,00      |
| 1311     | José       | DBA Senior          | R$ 4.000,00      |
| 2152     | Eduardo    | Programador I       | R$ 1.500,00      |

### **DFs Identificadas**:
1. `CPF → Nome` (Cada CPF determina um único nome).  
2. `CPF → Função` (Cada CPF está associado a uma única função).  
3. `Função → Salário_Base` (Cada função tem um salário fixo).  

---

## **3. Análise do Exercício Proposto**
Dada a relação **R(A, B, C, D, E)** com as tuplas:

| **A** | **B** | **C** | **D** | **E** |
|-------|-------|-------|-------|-------|
| a1    | b1    | c1    | d1    | e4    |
| a1    | b2    | c2    | d2    | e4    |
| a2    | b1    | c3    | d3    | e2    |
| a2    | b1    | c4    | d3    | e2    |
| a3    | b2    | c5    | d1    | e1    |

### **Verificação das Proposições**:
1. **DF: A → D**  
   - **Falso**: Para `A = a1`, há `D = d1` e `D = d2`.  
     - Violação: Um valor de `A` não determina um único `D`.  

2. **DF: AB → D**  
   - **Verdadeiro**:  
     - `(a1, b1)` → `d1`  
     - `(a1, b2)` → `d2`  
     - `(a2, b1)` → `d3`  
     - `(a3, b2)` → `d1`  
   - Cada combinação de `(A, B)` determina um único `D`.  

3. **DF: D → C**  
   - **Falso**: Para `D = d3`, há `C = c3` e `C = c4`.  

4. **DF: E → D**  
   - **Falso**: Para `E = e4`, há `D = d1` e `D = d2`.  

5. **DF: A → E**  
   - **Verdadeiro**:  
     - `a1` → `e4`  
     - `a2` → `e2`  
     - `a3` → `e1`  
   - Cada valor de `A` determina um único `E`.  

---

## **4. Resumo das Respostas**
| **Proposição**   | **Verdadeiro/Falso** | **Justificativa**                                                                 |
|------------------|----------------------|----------------------------------------------------------------------------------|
| 1) A → D         | Falso                | `a1` está associado a `d1` e `d2`.                                               |
| 2) AB → D        | Verdadeiro           | Cada par `(A, B)` determina um único `D`.                                        |
| 3) D → C         | Falso                | `d3` está associado a `c3` e `c4`.                                               |
| 4) E → D         | Falso                | `e4` está associado a `d1` e `d2`.                                               |
| 5) A → E         | Verdadeiro           | Cada valor de `A` determina um único `E` (ex.: `a1` → `e4`, `a2` → `e2`).       |

---

## **5. Aplicação em Normalização**
- As **DFs** são a base para definir as **formas normais** (1FN, 2FN, 3FN, BCNF).  
  - Exemplo: A DF `Função → Salário_Base` no exemplo inicial levou à decomposição em **3FN**.  

### **Regras para Identificar DFs**:
1. **Unicidade**: Se `X → Y`, então para cada `X`, existe **no máximo um `Y`**.  
2. **Consistência temporal**: A DF deve valer **em qualquer estado** da tabela.  
3. **Atributos compostos**: `X` e `Y` podem ser conjuntos de atributos (ex.: `(A, B) → D`).  

---

## **6. Exercício Adicional**
Dada a tabela **Pedidos**:

| **Pedido_ID** | **Cliente_ID** | **Nome_Cliente** | **Produto_ID** | **Quantidade** |  
|--------------|---------------|------------------|---------------|----------------|  
| 1            | 101           | João             | P01           | 2              |  
| 2            | 101           | João             | P02           | 1              |  
| 3            | 102           | Maria            | P03           | 3              |  

**Identifique as DFs válidas**:  
1. `Pedido_ID → Cliente_ID`  
2. `Cliente_ID → Nome_Cliente`  
3. `Produto_ID → Quantidade`  

**Respostas**:  
1. **Verdadeiro** (Cada pedido tem um único `Cliente_ID`).  
2. **Verdadeiro** (Cada cliente tem um único nome).  
3. **Falso** (A quantidade depende do pedido, não do produto).  

---

## **7. Conclusão**
- **DFs** são essenciais para projetar esquemas de bancos de dados **sem redundâncias** e **consistentes**.  
- A análise correta das DFs permite aplicar **formas normais** e evitar anomalias.  
- **Dica**: Sempre verifique se um atributo determina **unicamente** outro para validar uma DF.

---

# **Segunda Forma Normal (2FN)**

## **1. Definição Formal da 2FN**
Uma relação está na **Segunda Forma Normal (2FN)** se e somente se:
1. Estiver na **1FN** (todos os atributos são atômicos).
2. **Todos os atributos não-chave** forem **totalmente dependentes** da **chave primária inteira** (não apenas de parte dela).

---

## **2. Conceitos-Chave**
### **2.1. Dependência Parcial vs. Total**
- **Dependência Total**: Um atributo não-chave **depende de toda a chave primária** (composta).  
  - Ex.: Em `Remessa(#Cod_prod, #Cod_forn, Quant)`, `Quant` depende **dos dois campos juntos**.  
- **Dependência Parcial**: Um atributo não-chave **depende apenas de parte da chave primária**.  
  - Ex.: Em `Remessa(#Cod_prod, #Cod_forn, Cidade)`, `Cidade` depende **apenas de `#Cod_forn`**.  

### **2.2. Procedimento para Normalização na 2FN**
1. **Identificar atributos parcialmente dependentes**.  
2. **Removê-los** da tabela original.  
3. **Criar uma nova tabela** com:  
   - A **parte da chave primária** da qual eles dependem.  
   - Os **atributos removidos**.  
4. **Manter na tabela original** apenas os atributos **totalmente dependentes**.  

---

## **3. Exemplo Prático**
### **Antes da 2FN (Violação)**
**Tabela `Remessa`**:  
| **#Cod_prod** | **#Cod_forn** | **Quant** | **Cidade** | **Status_F** |
|--------------|--------------|----------|------------|-------------|
| P01          | F01          | 100      | São Paulo  | Ativo       |
| P02          | F01          | 50       | São Paulo  | Ativo       |
| P03          | F02          | 200      | Rio de Janeiro | Inativo   |

**Problema**:  
- `Cidade` e `Status_F` dependem **apenas de `#Cod_forn`** (não de `#Cod_prod`).  
- `Quant` depende **de ambos** (`#Cod_prod` e `#Cod_forn`).  

### **Depois da 2FN (Solução Correta)**
**Tabela `Remessa` (mantém apenas dependências totais)**:  
| **#Cod_prod** | **#Cod_forn** | **Quant** |
|--------------|--------------|----------|
| P01          | F01          | 100      |
| P02          | F01          | 50       |
| P03          | F02          | 200      |

**Tabela `Fornecedor` (nova tabela para dependências parciais)**:  
| **#Cod_forn** | **Cidade**      | **Status_F** |
|--------------|----------------|-------------|
| F01          | São Paulo      | Ativo       |
| F02          | Rio de Janeiro | Inativo     |

**Chaves**:  
- `Remessa`: Chave primária composta `(#Cod_prod, #Cod_forn)`.  
- `Fornecedor`: Chave primária `#Cod_forn`.  

---

## **4. Outros Exemplos de Aplicação da 2FN**
### **4.1. Matrícula de Alunos em Cursos**
**Antes (violação)**:  
`Matricula(#Aluno_ID, #Curso_ID, Nota, Nome_Aluno, Departamento_Curso)`  

**Problema**:  
- `Nome_Aluno` depende apenas de `#Aluno_ID`.  
- `Departamento_Curso` depende apenas de `#Curso_ID`.  

**Depois (2FN)**:  
- `Matricula(#Aluno_ID, #Curso_ID, Nota)`  
- `Aluno(#Aluno_ID, Nome_Aluno)`  
- `Curso(#Curso_ID, Departamento_Curso)`  

### **4.2. Pedidos de Vendas**
**Antes (violação)**:  
`Pedido(#Pedido_ID, #Produto_ID, Quantidade, Nome_Cliente, Endereço_Cliente)`  

**Depois (2FN)**:  
- `Pedido_Item(#Pedido_ID, #Produto_ID, Quantidade)`  
- `Pedido(#Pedido_ID, Nome_Cliente, Endereço_Cliente)` *(Observação: Na prática, isso ainda violaria a 3FN!)*  

---

## **5. Casos Especiais**
### **5.1. Quando a 2FN Não se Aplica?**
- Se a chave primária for **simples** (não composta), a tabela **automaticamente está na 2FN**.  
  - Ex.: `Cliente(ID, Nome, CPF)` já está na 2FN, pois não há dependências parciais.  

### **5.2. Erros Comuns**
- **Não identificar corretamente as dependências**: Levar a decomposições incorretas.  
- **Criar tabelas redundantes**: Separar atributos que **já estão totalmente dependentes**.  

---

## **6. Exercício Proposto**
Normalize para 2FN a tabela:  
`Projeto(#Func_ID, #Proj_ID, Horas_Trabalhadas, Nome_Func, Cargo_Func)`  

**Solução Esperada**:  
- `Alocacao_Projeto(#Func_ID, #Proj_ID, Horas_Trabalhadas)`  
- `Funcionario(#Func_ID, Nome_Func, Cargo_Func)`  

---

## **7. Conclusão**
A **2FN** elimina **dependências parciais**, garantindo que:  
✅ Atributos não-chave dependam **totalmente** da chave primária.  
✅ Redundâncias sejam minimizadas.  
✅ Anomalias de atualização sejam evitadas.  

É o **segundo passo** para um esquema de banco de dados **eficiente e consistente**, preparando o terreno para a **3FN**.


---

# **Terceira Forma Normal (3FN)**

## **1. Definição Formal da 3FN**
Uma relação está na **Terceira Forma Normal (3FN)** se e somente se:
1. Estiver na **2FN** (sem dependências parciais).
2. **Não existirem dependências transitivas** entre atributos não-chave (nenhum atributo não-chave determina outro atributo não-chave).

### **Regra Prática:**
- Todo atributo não-chave deve depender **apenas da chave primária** (não de outros atributos não-chave).

---

## **2. Dependência Transitiva (Problema Resolvido pela 3FN)**
Ocorre quando:
- Um atributo não-chave **A** determina outro atributo não-chave **B**.
- Formalmente: Se **X → Y** e **Y → Z**, então **X → Z** é uma dependência transitiva.

**Exemplo Clássico**:
- Na tabela `Empregado(#Mat, Nome, Função, Salário_base)`, se `Função → Salário_base`, então `#Mat → Salário_base` é transitiva.

---

## **3. Procedimento para Normalização na 3FN**
1. **Identificar dependências transitivas**:
   - Ex.: `Função → Salário_base` em `Empregado`.
2. **Remover os atributos dependentes**:
   - Extrair `Salário_base` da tabela original.
3. **Criar uma nova tabela** com:
   - O **atributo determinante** (`Função`) como chave primária.
   - O **atributo dependente** (`Salário_base`).
4. **Manter na tabela original** apenas a **chave estrangeira** (`Função`).

---

## **4. Exemplo Prático**
### **Antes da 3FN (Violação)**
**Tabela `Empregado`**:
| **#Mat** | **Nome**  | **Endereço** | **Função**   | **Salário_base** | **Depto** |
|----------|----------|-------------|-------------|------------------|----------|
| 101      | João     | Rua A       | Gerente     | 10.000           | Vendas   |
| 102      | Maria    | Rua B       | Analista    | 7.000            | TI       |

**Problema**:
- `Salário_base` depende de `Função` (não diretamente da chave `#Mat`).

### **Depois da 3FN (Solução Correta)**
**Tabela `Empregado`**:
| **#Mat** | **Nome**  | **Endereço** | **Função** | **Depto** |
|----------|----------|-------------|-----------|----------|
| 101      | João     | Rua A       | Gerente   | Vendas   |
| 102      | Maria    | Rua B       | Analista  | TI       |

**Tabela `Função_Salário`**:
| **Função**  | **Salário_base** |
|------------|------------------|
| Gerente    | 10.000           |
| Analista   | 7.000            |

**Chaves**:
- `Empregado`: Chave primária `#Mat`, com `Função` como chave estrangeira.
- `Função_Salário`: Chave primária `Função`.

---

## **5. Vantagens da 3FN**
| **Benefício**               | **Explicação**                                                                 |
|-----------------------------|-------------------------------------------------------------------------------|
| **Elimina redundâncias**    | `Salário_base` é armazenado uma única vez por função, não por empregado.     |
| **Previne anomalias**       | Atualizar o salário de uma função requer mudança em apenas um registro.      |
| **Melhora consistência**    | Não há risco de salários diferentes para a mesma função.                     |
| **Facilita consultas**      | Estrutura mais organizada para buscas (ex.: listar todas as funções e salários). |

---

## **6. Comparação entre 2FN e 3FN**
| **Critério**         | **2FN**                                  | **3FN**                                  |
|----------------------|------------------------------------------|------------------------------------------|
| **Foco**            | Elimina dependências **parciais**.       | Elimina dependências **transitivas**.    |
| **Atributos Alvo**  | Atributos não-chave que dependem de **parte da chave primária**. | Atributos não-chave que dependem de **outros não-chave**. |
| **Exemplo**        | Separar `Cidade` de `Pedido` (depende apenas do `Cliente_ID`). | Separar `Salário_base` de `Empregado` (depende de `Função`). |

---

## **7. Casos Especiais**
### **7.1. Quando a 3FN Não é Suficiente?**
- Se houver **dependências multivaloradas** ou **junções complexas**, a **Forma Normal de Boyce-Codd (BCNF)** pode ser necessária.
- Exemplo: Se `Função` determinasse `Depto` (violação da BCNF).

### **7.2. Desnormalização Controlada**
- Em sistemas OLAP (análise de dados), a 3FN pode ser relaxada para melhorar desempenho em consultas complexas.

---

## **8. Exercício Proposto**
Normalize para 3FN a tabela:  
`Livro(ISBN, Título, Autor_ID, Nome_Autor, Nacionalidade_Autor, Editora_ID, País_Editora)`  

**Solução Esperada**:
- `Livro(ISBN, Título, Autor_ID, Editora_ID)`
- `Autor(Autor_ID, Nome_Autor, Nacionalidade_Autor)`
- `Editora(Editora_ID, País_Editora)`

---

## **9. Conclusão**
A **3FN** é essencial para:
✔ **Eliminar redundâncias ocultas** (dependências transitivas).  
✔ **Garantir atualizações eficientes**.  
✔ **Estruturar dados de forma lógica e consistente**.  

É o **último passo** para a maioria dos projetos de bancos de dados tradicionais, antecedendo apenas a BCNF em casos específicos.

---

# **Forma Normal de Boyce-Codd (FNBC) - Teoria e Aplicação**

## **1. Definição Formal da FNBC**
Uma relação está na **Forma Normal de Boyce-Codd (FNBC)** se e somente se:
- Estiver na **3FN** (sem dependências transitivas).
- **Todo determinante (lado esquerdo de uma DF) for uma chave candidata** (superchave).

### **Regra Prática**:
- Se existir uma DF `X → Y` onde **X não é chave candidata**, a relação **não está na FNBC**.

---

## **2. Comparação entre 3FN e FNBC**
| **Critério**         | **3FN**                                  | **FNBC**                                  |
|----------------------|------------------------------------------|------------------------------------------|
| **Foco**            | Elimina dependências **transitivas**.    | Exige que **todo determinante seja chave candidata**. |
| **Restrição**       | Permite DFs onde o determinante **não é chave**, desde que o dependente seja **atributo primo** (parte de alguma chave). | **Não permite** DFs com determinantes não-chave, independentemente do tipo de atributo dependente. |
| **Exemplo**        | `Função → Salário_base` (aceito na 3FN se `Função` não for chave). | `Função → Salário_base` (viola FNBC se `Função` não for chave candidata). |

---

## **3. Exemplo Prático: Turma (Estudante, Assunto, Professor)**
### **Contexto**:

| **Estudante**  | **Assunto**  |  **Professor**   |
|------------|------------------|------------------|
| Antonio    | Banco de Dados   | Mst Carlos       |
| Marcos     | Algoritmos       | Dr Magali        |

- Cada estudante em um **Assunto** tem um único **Professor**.
- Cada **Professor** ministra apenas um **Assunto** (mas um Assunto pode ter vários professores).
- Cada **Assunto** é ensinado por diversos professores.

### **Dependências Funcionais (DFs)**:
1. `(Estudante, Assunto) → Professor`  
   - **Chave candidata 1**: `(Estudante, Assunto)`.  
2. `Professor → Assunto`  
   - **Problema**: `Professor` **não é chave candidata** (viola FNBC).  

### **Chaves Candidatas**:
- `(Estudante, Assunto)` (pois determina `Professor`).  
- `(Estudante, Professor)` (pois `Professor → Assunto`).  

### **Decomposição para FNBC**:
1. **Tabela `EP(Estudante, Professor)`**:  
   - Chave primária: `(Estudante, Professor)`.  
2. **Tabela `PA(Professor, Assunto)`**:  
   - Chave primária: `Professor` (pois `Professor → Assunto`).  


| **Estudante** |  **Professor**   |
|---------------|------------------|
| Antonio       | Banco de Dados   |
| Marcos        | Algoritmos       |


|  **Professor**   | **Assunto**      |
|------------------|------------------|
| Mst Carlos       | Banco de Dados   |
| Dr Magali        | Algoritmos       |


**Resultado**:
- Ambas as tabelas estão na FNBC, pois:  
  - Em `PA`, `Professor` é chave.  
  - Em `EP`, `(Estudante, Professor)` é chave.  

---

## **4. Axiomas de Armstrong (Regras de Inferência para DFs)**
São regras formais para **derivar novas DFs** a partir de um conjunto inicial.  

| **Axioma**         | **Descrição**                                                                 | **Exemplo**                                  |
|--------------------|------------------------------------------------------------------------------|--------------------------------------------|
| **Reflexividade**  | Se \( B \subseteq A \), então \( A \rightarrow B \).                         | `(A, B) → B`.                              |
| **Aumento**       | Se \( A \rightarrow B \), então \( AC \rightarrow BC \).                     | Se `CPF → Nome`, então `(CPF, Idade) → (Nome, Idade)`. |
| **Transitividade** | Se \( A \rightarrow B \) e \( B \rightarrow C \), então \( A \rightarrow C \). | Se `CPF → Depto` e `Depto → Gerente`, então `CPF → Gerente`. |
| **Decomposição**  | Se \( A \rightarrow BC \), então \( A \rightarrow B \) e \( A \rightarrow C \). | Se `CPF → (Nome, Idade)`, então `CPF → Nome` e `CPF → Idade`. |
| **União**         | Se \( A \rightarrow B \) e \( A \rightarrow C \), então \( A \rightarrow BC \). | Se `CPF → Nome` e `CPF → Idade`, então `CPF → (Nome, Idade)`. |
| **Composição**    | Se \( A \rightarrow B \) e \( C \rightarrow D \), então \( AC \rightarrow BD \). | Se `CPF → Nome` e `Cargo → Salário`, então `(CPF, Cargo) → (Nome, Salário)`. |

---

## **5. Quando Aplicar a FNBC?**
### **Casos Típicos**:
1. **Chaves candidatas sobrepostas**: Quando múltiplas chaves compartilham atributos (ex.: `(Estudante, Assunto)` e `(Estudante, Professor)`).  
2. **Determinantes não-chave**: Se uma DF como `X → Y` existe, mas `X` não é chave.  

### **Limitações**:
- **Pode aumentar a complexidade**: Muitas tabelas podem dificultar consultas com `JOINs`.  
- **Nem sempre necessária**: A 3FN é suficiente para a maioria dos casos práticos.  

---

## **6. Exercício Proposto**
Dada a relação `Projeto(Func_ID, Proj_ID, Horas, Nome_Func, Cargo)`, com as DFs:  
1. `Func_ID → (Nome_Func, Cargo)`  
2. `(Func_ID, Proj_ID) → Horas`  

**Pergunta**: A relação está na FNBC? Se não, normalize.  

**Resposta**:  
- **Violação**: `Func_ID → Cargo` (onde `Func_ID` não é chave candidata).  
- **Decomposição**:  
  - `Funcionario(Func_ID, Nome_Func, Cargo)`  
  - `Alocacao(Func_ID, Proj_ID, Horas)`  

---

## **7. Conclusão**
A **FNBC** é a forma normal mais rigorosa para:  
✔ **Eliminar todas as redundâncias** baseadas em DFs.  
✔ **Garantir que determinantes sejam chaves**.  
✔ **Evitar anomalias em atualizações**.  

Porém, sua aplicação deve ser **ponderada**, equilibrando normalização e desempenho. Os **Axiomas de Armstrong** são ferramentas essenciais para analisar DFs e projetar esquemas eficientes.


