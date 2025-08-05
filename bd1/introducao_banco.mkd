## Sistemas de Banco de Dados

### Dado, Informação e Conhecimento

- **Dado**: é o componente básico de um arquivo, é um elemento com um significado no mundo real, que compõe um sistema de arquivos. Como exemplo, podemos citar nome, sobrenome, cidade, bairro e outros.
- **Informação**: após a interpretação dos dados, é possível associar um significado aos dados ou processá-los. Normalmente, a informação vem de convenções utilizadas por pessoas por meio de associações aos dados.
- **Conhecimento**: todo discernimento, obtido por meio de critérios, e apreciação aos dados e informações.

#### Exemplo

O registro é composto por seis itens de dados (campos): código, CPF, nome, rua, bairro, cidade. Dentro do Banco de Dados, as fichas de todos os clientes que estão inseridas formarão o arquivo cliente.

Tomando como exemplo uma pesquisa eleitoral: cada entrevistado fornece opiniões conforme as suas preferências entre os candidatos, mas essa opinião individual não significa muita coisa no contexto da eleição. A opinião de um entrevistado único é um dado. Porém, depois de ser integrada às opiniões dos demais respondentes, torna-se algo com significado, uma informação.

Agora, tomando como exemplo um número de telefone: `(11) 58899.3587` é um número, mas não carrega significado por si só; é um dado. Já na frase **"O número do telefone da Viviane é (11) 58899.3587"**, temos uma informação!

---

### Definição de Banco de Dados

- **Chu (1983)**: "Um Banco de Dados é um conjunto de arquivos relacionados entre si".
- **C. J. Date (1985)**: "Um Banco de Dados é uma coleção de dados operacionais armazenados, sendo usados pelos sistemas de aplicação de uma determinada organização".
- **Elmasri e Navathe (2005)**: "Um Banco de Dados é uma coleção de dados relacionais".
- **Torey et al. (2007, p.2)**: "Um Banco de Dados é um objeto mais complexo, é uma coleção de dados armazenados e inter-relacionados, que atende às necessidades de vários usuários dentro de uma ou mais organizações, ou seja, coleções inter-relacionadas de muitos tipos diferentes de tabelas".

---

### Sistema de Gerenciamento de Banco de Dados

Segundo **DATE (2004)**, um **Sistema Gerenciador de Banco de Dados (SGBD)** é um software genérico para manipular Banco de Dados. Ele permite a definição, construção e manejo de um Banco de Dados para diversas aplicações. Um SGBD possui:

- **Visão lógica**: projeto do BD.
- **Linguagem de definição de dados (DDL)**: usada para definir o esquema conceitual do Banco de Dados.
- **Linguagem de manipulação de dados (DML)**: empregada para especificar as recuperações e atualizações do Banco de Dados.
- **Utilitários importantes**: auxiliam na administração e manutenção do BD.

Os SGBDs também facilitam a conversão e a reorganização do Banco de Dados. Dessa forma, podemos dizer que os SGBDs são programas de computador que ajudam na:

- **Definição e construção do Banco de Dados**: processo de criar uma estrutura inicial com tabelas e preenchê-las com dados.
- **Manipulação dos dados do Banco de Dados**: operações de consultas, alteração e exclusão realizadas nos dados.


### Funções básicas dos SGBD estão listadas abaixo:

- Métodos de acesso
- Restrições de Integridade
- Segurança de dados
- Controle de Concorrência
- Indepêndicia de dados

---

### Níveis de Abstração

Uma das funções essenciais ao **DBA** é utilizar **abstração de dados**. Com a utilização da abstração de dados, é possível esconder certos “detalhes” sobre como os dados estão armazenados e como é realizada a manutenção, para facilitar o entendimento do usuário (**JUKIC, VRBSKY S e NESTOROV, 2013**).

- **Nível físico**: Descreve como os dados estão armazenados. Este é o nível mais baixo de abstração.
- **Nível lógico**: Esse nível de abstração está acima do físico e descreve quais dados estão armazenados no BD e quais são suas relações. Descreve o Banco de Dados inteiro em termos de um pequeno número de estruturas relativamente simples.
- **Nível de visões (View)**: Esse nível pode ser visto pelo usuário de diversas formas, pois quem opera são os sistemas aplicativos. Esse nível existe para facilitar sua interação com o sistema, ou seja, o sistema pode fornecer muitas visões para o mesmo Banco de Dados.

---

### Projeto de Banco de Dados

1. **Definição do sistema**: nesta etapa é determinado o escopo do sistema, o que deverá ser armazenado e quais serão as operações realizadas, assim como seus usuários.
2. **Projeto do Banco de Dados**: criação do projeto conceitual, lógico e físico.
3. **Implementação do Banco de Dados**: criação real do Banco de Dados conforme os esquemas definidos na etapa anterior.
4. **Carga ou conversão de dados**: o Banco de Dados é preenchido com dados já existentes ou preenchido manualmente.
5. **Conversão de aplicação**: programas que antes acessavam o banco são informados sobre as modificações do novo banco (etapa auxiliar).
6. **Teste e validação**: verifica-se se tudo está funcionando de acordo com o planejamento.
7. **Operação**: disponibilização do sistema para uso.
8. **Monitoramento e manutenção**: observação do funcionamento do sistema para possíveis ajustes.

### Tipos de Banco de Dados

| **Tipo de SGBD**             | **Estrutura de Dados**                                      | **Características**                                                                 | **Exemplos**                        | **Linguagem de Consulta**          | **Exemplos de Linguagens de Consulta**   | **Quem Utiliza**                       |
|------------------------------|-------------------------------------------------------------|--------------------------------------------------------------------------------------|-------------------------------------|------------------------------------|-----------------------------------------|----------------------------------------|
| **SGBD Relacional (RDBMS)**  | Tabelas com linhas e colunas, onde os dados são organizados em relações | - Usa SQL (Structured Query Language) para consultas. <br> - Suporta normalização. <br> - Relacionamentos entre tabelas usando chaves primárias e estrangeiras. | Oracle, MySQL, Microsoft SQL Server, PostgreSQL | SQL (Structured Query Language)    | **Exemplo**: `SELECT * FROM clientes WHERE idade > 30;` | Empresas de todos os tamanhos e setores (finanças, saúde, comércio, etc.), que precisam de consistência e relacionamentos complexos entre dados. |
| **SGBD Não Relacional (NoSQL)** | Dados não estruturados ou semi-estruturados (ex.: documentos, chave-valor) | - Suporta grandes volumes de dados distribuídos. <br> - Flexível quanto ao formato dos dados. <br> - Escalabilidade horizontal. | MongoDB, Cassandra, Redis          | Depende do SGBD (ex.: MongoDB Query Language, CQL) | **MongoDB Query**: `db.clientes.find({idade: {$gt: 30}});` <br> **Cassandra Query Language (CQL)**: `SELECT * FROM clientes WHERE idade > 30;` | Empresas que lidam com Big Data, redes sociais, IoT, e-commerce e startups tecnológicas que exigem flexibilidade, escalabilidade e alto desempenho. |
| **SGBD Orientado a Objetos** | Objetos (semelhante a objetos em linguagens de programação) | - Armazena dados como objetos. <br> - Suporta herança, polimorfismo e encapsulamento. <br> - Ideal para aplicações orientadas a objetos. | ObjectDB, db4o                     | OQL (Object Query Language)       | **Exemplo**: `SELECT FROM Cliente WHERE idade > 30;` | Desenvolvedores de software que utilizam programação orientada a objetos e precisam de um banco de dados que se integre facilmente a esse paradigma. |
| **SGBD Hierárquico**         | Estrutura de árvore (cada registro tem um único pai)        | - Dados são organizados em um modelo de árvore. <br> - Relacionamentos são fixos, com hierarquias predefinidas. | IBM IMS                            | Linguagem de consulta própria (ex.: IMS Database Language) | **Exemplo**: `SELECT * FROM (EMPLOYEE) WHERE SUPERVISOR = 'John';` | Grandes corporações com sistemas legados que ainda utilizam estruturas hierárquicas para processamento de dados, como bancos e empresas de telecomunicações. |
| **SGBD de Rede**             | Rede de registros interligados, permitindo múltiplos pais   | - Semelhante ao modelo hierárquico, mas com múltiplos pais. <br> - Mais flexível que o hierárquico, porém mais complexo. | IDMS                               | Linguagem de consulta própria (ex.: Network Query Language) | **Exemplo**: `FIND EMPLOYEE WHERE EMPLOYEE_ID = '123';` | Empresas com sistemas legados, principalmente em setores como finanças, onde a estrutura de dados precisa de relacionamentos complexos e flexibilidade. |

---

## Modelo Conceitual

O Modelo Relacional de Dados, definido por E. F. Codd em 1970 enquanto trabalhava na IBM, revolucionou a forma como os bancos de dados eram estruturados e manipulados. Sua proposta baseia-se na organização dos dados em tabelas (ou relações), utilizando chaves primárias e estrangeiras para estabelecer conexões entre os dados de forma estruturada e eficiente.

### 1. **Simplicidade** dos conceitos de base

- O modelo relacional utiliza um formato tabular simples, onde os dados são organizados em linhas e colunas, facilitando a compreensão e a manipulação.
- Cada tabela representa uma entidade, e cada linha (tupla) representa um registro único dessa entidade.


### 2. Rigor dos **conceitos** (tanto estruturas como operadores)

- Diferente de modelos anteriores, que eram mais flexíveis e menos estruturados, o modelo relacional define regras rigorosas para a manipulação de dados.
- Conceitos como normalização ajudam a evitar redundância e anomalias nos dados.

### 3. Aspecto de Estrutura  

O banco de dados relacional é representado por um conjunto de **relações (tabelas)**, onde:  
- Cada **relação** corresponde a uma **tabela**.  
- As **linhas (tuplas)** representam registros individuais da tabela.  
- As **colunas (atributos)** representam os diferentes campos ou propriedades armazenadas.  
- Uma **chave primária** é usada para identificar unicamente cada tupla.  
- **Chaves estrangeiras** estabelecem relações entre tabelas.  

### 4. Aspecto de Integridade  
As relações devem satisfazer certas **restrições de integridade** para garantir a consistência dos dados. Entre as principais restrições, destacam-se:  
- **Integridade de entidade**: Cada tabela deve possuir uma **chave primária** única para evitar registros duplicados.  
- **Integridade referencial**: As **chaves estrangeiras** devem referenciar valores válidos em outras tabelas, garantindo a coerência dos relacionamentos.  
- **Integridade de domínio**: Os valores inseridos em uma coluna devem obedecer ao **tipo de dado** definido (exemplo: números em colunas numéricas).  

O **Modelo Relacional de Dados** serviu de base para o desenvolvimento dos **bancos de dados relacionais (RDBMS)**, como **MySQL, PostgreSQL, Oracle e SQL Server**, e influenciou a criação da linguagem **SQL (Structured Query Language)**, amplamente utilizada para consultas e manipulação de dados.


## Terminologia Formal do Modelo Relacional de Dados

No **Modelo Relacional de Dados**, os elementos básicos possuem nomes específicos:

- **Tupla**: Uma linha da tabela (representa um registro).  
- **Atributo**: O título de uma coluna da tabela (representa uma propriedade dos dados).  
- **Relação**: A tabela em si (conjunto de tuplas e atributos).  
Onde:
 **R** é o nome da relação (ou tabela).
 **A1, A2, ..., An** são os atributos (colunas da tabela).
 Cada **atributo A** representa um papel desempenhado por algum **domínio D** dentro do esquema da relação R.

- **Domínio**: O tipo de dado que descreve os possíveis valores que podem aparecer em uma coluna.
Onde:
**Ai** representa um atributo específico.
**D(Ai)** ou **dom(Ai)** representa o domínio de valores atômicos (indivisíveis) permitidos para esse atributo.

**Papel do Domínio em uma Relação**
1. **Garante a validade dos dados**:  
   - Um atributo **"idade"** deve conter apenas números inteiros positivos.  
   - Um atributo **"email"** deve seguir o formato de endereços de e-mail.  

2. **Previne erros e inconsistências**:  
   - O domínio impede que valores inválidos sejam inseridos no banco de dados.  

3. **Facilita a manipulação de dados**:  
   - Ao definir um domínio corretamente, operadores e funções podem ser aplicados sem necessidade de validação adicional.  

**Exemplo Prático**
Vamos considerar uma relação **Aluno** com os seguintes atributos:

Os domínios dos atributos são:

| **Atributo** | **Domínio (D(Ai))**                          | **Exemplo de Valor**     |
|-------------|----------------------------------|---------------------|
| **matricula** | Números inteiros positivos     | 1001, 1002, 1003    |
| **nome**      | Cadeia de caracteres (máx. 50) | "João Silva"        |
| **idade**     | Números inteiros (0-120)       | 20, 35, 45          |
| **telefone**  | Formato de telefone válido     | (11) 98765-4321     |

## **Atributos Devem Ser Diferentes**
Segundo a **teoria dos conjuntos**, os atributos de uma relação devem ser **diferentes entre si**. Ou seja, uma relação **não pode conter dois atributos com o mesmo nome**.

**Por que os atributos devem ser únicos?**
- Evita **ambiguidade** na manipulação dos dados.
- Garante **univocidade** na representação da relação.
- Facilita **operações de junção e projeção**.

### Exemplo Prático:

**Tabela: Customers (Clientes)**

| **CustomerID** | **Name**       | **Email**             | **City**          |
|--------------|---------------|----------------------|----------------|
| 1            | João Silva    | joao@email.com      | São Paulo     |
| 2            | Maria Souza   | maria@email.com     | Rio de Janeiro |
| 3            | Carlos Lima   | carlos@email.com    | Salvador      |
| 4            | Ana Pereira   | ana@email.com       | Belo Horizonte |
| 5            | Pedro Santos  | pedro@email.com     | Curitiba      |

- **Atributos**: CustomerID, Name, Email, City.  
- **Relação**: A tabela inteira "Customers".  
- **Tupla**: Cada linha da tabela. Exemplo: `(2, Maria Souza, maria@email.com, Rio de Janeiro)`.  
- **Domínio**:  
  - O atributo **CustomerID** tem um domínio de **valores inteiros positivos e únicos**.  
  - O atributo **Name** tem um domínio de **cadeias de caracteres (texto) com nomes de clientes**.  
  - O atributo **Email** tem um domínio de **endereços de e-mail válidos**.  
  - O atributo **City** tem um domínio de **cidades existentes**.

# Formulação Matemática de uma Relação no Modelo Relacional

Seja uma **relação** \( R \) composta pelos atributos \( A1, A2, ..., An \), e os **domínios** \( dom(A1), dom(A2), ..., dom(An) \) dos respectivos atributos. A **relação** \( R \) é um **subconjunto** do produto cartesiano dos domínios que definem os atributos da relação.

A formulação matemática é a seguinte:

### **Definição Formal**

Seja:
- \( A1, A2, ..., An \) os atributos de uma relação \( R \).
- \( dom(A1), dom(A2), ..., dom(An) \) os domínios dos respectivos atributos.

Então, uma **relação** \( R \) pode ser representada matematicamente como:

$r(R) \subseteq (dom(A_1) \times dom(A_2) \times \dots \times dom(A_n))$


Onde:
- \( r(R) \) é o conjunto de tuplas que formam a relação \( R \).
- \( dom(Ai) \) é o domínio do atributo \( Ai \), ou seja, o conjunto de valores possíveis para \( Ai \).
- \( $\times$ \) denota o **produto cartesiano** dos domínios, ou seja, o conjunto de todas as combinações possíveis dos valores dos domínios de \( A1, A2, ..., An \).

### **Explicação do Produto Cartesiano**

O **produto cartesiano** dos domínios \( dom(A1), dom(A2), ..., dom(An) \) gera um conjunto de tuplas, onde cada tupla contém uma combinação dos valores possíveis de cada domínio. Por exemplo:

- Se \( dom(A1) = \{1, 2\} \) e \( dom(A2) = \{x, y\} \), o produto cartesiano \( dom(A1) \times dom(A2) \) seria:

$ dom(A1) \times dom(A2) = \{(1, x), (1, y), (2, x), (2, y)\} $

A relação \( r(R) \) será um subconjunto deste produto cartesiano. Ou seja, a relação \( R \) pode conter algumas (ou todas) as combinações possíveis, dependendo dos dados inseridos na tabela.

### **Exemplo Prático**

Considerando a relação **Aluno**, com os seguintes atributos e domínios:

- \( Aluno(matricula, nome, idade) \)
- \( dom(matricula) = \{1001, 1002\} \)
- \( dom(nome) = \{João, Maria\} \)
- \( dom(idade) = \{18, 19\} \)

O produto cartesiano seria:

$dom(matricula) \times dom(nome) \times dom(idade) = \{(1001, João, 18), (1001, João, 19), (1001, Maria, 18), (1001, Maria, 19), (1002, João, 18), (1002, João, 19), (1002, Maria, 18), (1002, Maria, 19)\}$

Agora, a relação \( r(Aluno) \) poderia ser um subconjunto desse conjunto, por exemplo:

$r(Aluno) = \{(1001, João, 18), (1002, Maria, 19)\}$

Este subconjunto contém apenas algumas das combinações possíveis.

---

### **Conclusão**
- Uma **relação** no modelo relacional é um subconjunto do produto cartesiano dos domínios de seus atributos.
- A fórmula \( r(R) \subseteq (dom(A1) \times dom(A2) \times ... \times dom(An)) \) descreve matematicamente essa estrutura.
- O **produto cartesiano** gera todas as combinações possíveis de valores, e a relação seleciona quais dessas combinações são armazenadas.

Esse entendimento é fundamental para modelar dados em **bancos de dados relacionais** e compreender como as **relações** são formadas e manipuladas.

# Conceitos de Tupla, Grau e Cardinalidade no Modelo Relacional

### **Tupla**
Uma **tupla** é uma **lista ordenada de valores** que representam dados em uma relação. Cada valor na tupla corresponde a um **atributo** da relação e pertence ao domínio desse atributo ou pode ser um valor especial **nulo**.

#### **Notação**
Uma tupla \( t \) é representada como:

$t = <v1, v2, ..., vn>$

Onde:
- \( v1, v2, ..., vn \) são os valores da tupla, sendo que cada \( vi \) é um valor pertencente ao **domínio** de um atributo \( Ai \) da relação.
- \( n \) é o número de atributos da relação (o **grau** da relação).
- Cada \( vi \) pode ser um valor atômico ou um valor especial **nulo** (representando a ausência de valor).

#### **Exemplo de Tupla**
Considerando a relação **Aluno**, com os atributos:

- **matricula**
- **nome**
- **idade**

Uma tupla poderia ser:

$t = <1001, "João Silva", 20>$

Onde:
- **1001** é o valor da matrícula.
- **"João Silva"** é o valor do nome.
- **20** é o valor da idade.

Ou, se algum valor estiver ausente (como no caso de um telefone não fornecido), pode ser representado como **nulo**:

$t = <1002, "Maria Souza", nulo>$

#### **Relação**
Uma **relação** \( r(R) \) é um **conjunto de n-tuplas** que pertencem a uma relação \( R \).

A notação de uma relação seria:

$r(R) = \{t1, t2, ..., tm\}$

Onde:
- \( t1, t2, ..., tm \) são as tuplas que fazem parte da relação \( R \).
- \( m \) é a **cardinalidade** da relação, ou seja, o número de tuplas.

---

## **Grau de uma Relação**
O **grau** de uma relação é o **número de atributos** presentes na relação. Em outras palavras, o grau de uma relação \( R \) é o número de **colunas** da tabela que a representa.

### **Exemplo de Grau**
Considerando a relação **Aluno**:

$Aluno(matricula, nome, idade)$

O grau da relação **Aluno** é 3, porque ela possui 3 atributos.

---

## **Cardinalidade de uma Relação**
A **cardinalidade** de uma relação é o **número de tuplas** que ela contém. A cardinalidade indica a **quantidade de registros** na tabela que representa a relação.

### **Exemplo de Cardinalidade**
Se a relação **Aluno** contiver as seguintes tuplas:

$r(Aluno) = \{(1001, "João Silva", 20), (1002, "Maria Souza", 19), (1003, "Carlos Lima", 22)\}$

A cardinalidade da relação **Aluno** é 3, porque existem 3 tuplas na relação.

---

## **Resumo dos Conceitos**
- **Tupla**: Lista ordenada de valores representando um registro na relação, onde cada valor corresponde a um atributo e pode ser um valor atômico ou nulo.
- **Grau**: Número de atributos de uma relação.
- **Cardinalidade**: Número de tuplas de uma relação.

Esses conceitos são fundamentais para a **modelagem de dados** no **Modelo Relacional de Dados**, ajudando a descrever as **estruturas** e **quantidade de dados** presentes em um banco de dados relacional.

---

### **Relacionamento com outra Tabela**

Agora, vamos adicionar uma tabela relacionada, a **Orders (Pedidos)**:

**Tabela: Orders (Pedidos)**

| **OrderID** | **CustomerID** | **OrderDate** | **TotalAmount** |
|------------|--------------|------------|--------------|
| 101        | 1            | 2024-02-10 | 150.00      |
| 102        | 3            | 2024-02-12 | 200.00      |
| 103        | 2            | 2024-02-15 | 99.90       |
| 104        | 1            | 2024-02-18 | 75.50       |

- **Chave Primária (PK)**:  
  - **OrderID** na tabela **Orders**.  
  - **CustomerID** na tabela **Customers**.  

- **Chave Estrangeira (FK)**:  
  - **CustomerID** na tabela **Orders**, referenciando **CustomerID** na tabela **Customers**.  

### **Explicação do Relacionamento**
- O **CustomerID** na tabela **Orders** indica qual cliente fez cada pedido.  
- Exemplo: O pedido **101** foi feito pelo **CustomerID 1**, que é **João Silva**.  
- Esse relacionamento garante **integridade referencial**, pois um pedido não pode existir sem um cliente associado.

---

Essa estrutura mostra a aplicação da **terminologia do Modelo Relacional**, incluindo **relações, tuplas, atributos, domínios, chaves primária e estrangeira**.  

### 5. Aspecto de Manipulação  
- O modelo relacional introduziu a Álgebra Relacional e o Cálculo Relacional, permitindo operações como seleção, projeção, junção e união de dados.
- Essas operações possibilitam a recuperação e manipulação eficiente dos dados de forma declarativa.

Os dados armazenados nas relações podem ser manipulados através de **operadores da álgebra relacional**, que permitem a recuperação e modificação eficiente dos dados. Os principais operadores incluem:  
- **Seleção (σ)**: Filtra linhas que atendem a uma condição específica.  
- **Projeção (π)**: Seleciona colunas específicas de uma tabela.  
- **Junção (⨝)**: Combina dados de duas ou mais tabelas com base em um atributo comum.  
- **União (∪)**: Combina os resultados de duas tabelas semelhantes.  
- **Interseção (∩)**: Retorna os registros comuns entre duas tabelas.  
- **Diferença (-)**: Retorna os registros que estão em uma tabela, mas não em outra.  

# Operações da Álgebra Relacional

As operações da álgebra relacional permitem a manipulação eficiente de dados em um banco de dados relacional. A seguir, estão as principais operações com exemplos:

---

### 1. **Seleção (σ)**
A operação de **seleção** filtra as linhas que atendem a uma condição específica.

#### **Sintaxe**:  

$\sigma_{\text{condição}}(R)$

#### **Exemplo**:

Tabela **Aluno**:

| matricula | nome   | idade | cidade   |
|-----------|--------|-------|----------|
| 1001      | João   | 20    | Salvador |
| 1002      | Maria  | 19    | Recife   |
| 1003      | Carlos | 22    | Salvador |

Selecionando os alunos com **idade maior que 20**:

$\sigma_{\text{idade} > 20}(Aluno)$

**Resultado**:

| matricula | nome   | idade | cidade   |
|-----------|--------|-------|----------|
| 1003      | Carlos | 22    | Salvador |

---

### 2. **Projeção (π)**
A operação de **projeção** seleciona apenas **colunas específicas** de uma tabela.

#### **Sintaxe**:  
$\pi_{\text{atributos}}(R)$

#### **Exemplo**:

Tabela **Aluno**:

| matricula | nome   | idade | cidade   |
|-----------|--------|-------|----------|
| 1001      | João   | 20    | Salvador |
| 1002      | Maria  | 19    | Recife   |
| 1003      | Carlos | 22    | Salvador |

Projetando apenas as **colunas nome** e **idade**:

$\pi_{\text{nome, idade}}(Aluno)$

**Resultado**:

| nome   | idade |
|--------|-------|
| João   | 20    |
| Maria  | 19    |
| Carlos | 22    |

---

### 3. **Junção (⨝)**
A operação de **junção** combina os dados de **duas ou mais tabelas** com base em um **atributo comum**.

#### **Sintaxe**:  
$R \bowtie_{\text{atributo comum}} S$

#### **Exemplo**:

Tabela **Aluno**:

| matricula | nome   | cidade   |
|-----------|--------|----------|
| 1001      | João   | Salvador |
| 1002      | Maria  | Recife   |
| 1003      | Carlos | Salvador |

Tabela **Curso**:

| matricula | curso       |
|-----------|-------------|
| 1001      | Matemática  |
| 1002      | Física      |
| 1004      | Química     |

Junção das tabelas **Aluno** e **Curso** pela **matricula**:

$Aluno \bowtie_{\text{matricula}} Curso$

**Resultado**:

| matricula | nome   | cidade   | curso      |
|-----------|--------|----------|------------|
| 1001      | João   | Salvador | Matemática |
| 1002      | Maria  | Recife   | Física     |

---

### 4. **União (∪)**
A operação de **união** combina os resultados de **duas tabelas** semelhantes, ou seja, ambas com a mesma estrutura (mesmos atributos).

#### **Sintaxe**:  
$R \cup S$

#### **Exemplo**:

Tabela **Aluno1**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1001      | João   | 20    |
| 1002      | Maria  | 19    |

Tabela **Aluno2**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1003      | Carlos | 22    |
| 1004      | Ana    | 21    |

União das tabelas **Aluno1** e **Aluno2**:

$Aluno1 \cup Aluno2$

**Resultado**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1001      | João   | 20    |
| 1002      | Maria  | 19    |
| 1003      | Carlos | 22    |
| 1004      | Ana    | 21    |

---

### 5. **Interseção (∩)**
A operação de **interseção** retorna os registros **comuns** entre duas tabelas semelhantes.

#### **Sintaxe**:  
$R \cap S$

#### **Exemplo**:

Tabela **Aluno1**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1001      | João   | 20    |
| 1002      | Maria  | 19    |

Tabela **Aluno2**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1002      | Maria  | 19    |
| 1003      | Carlos | 22    |

Interseção das tabelas **Aluno1** e **Aluno2**:

$Aluno1 \cap Aluno2$

**Resultado**:

| matricula | nome  | idade |
|-----------|-------|-------|
| 1002      | Maria | 19    |

---

### 6. **Diferença (-)**
A operação de **diferença** retorna os registros que estão **em uma tabela, mas não em outra**.

#### **Sintaxe**:  
$R - S$

#### **Exemplo**:

Tabela **Aluno1**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1001      | João   | 20    |
| 1002      | Maria  | 19    |

Tabela **Aluno2**:

| matricula | nome   | idade |
|-----------|--------|-------|
| 1002      | Maria  | 19    |
| 1003      | Carlos | 22    |

Diferença entre as tabelas **Aluno1** e **Aluno2**:

$Aluno1 - Aluno2$

**Resultado**:

| matricula | nome  | idade |
|-----------|-------|-------|
| 1001      | João  | 20    |

---

### **Conclusão**
As operações da álgebra relacional fornecem uma maneira poderosa e declarativa de manipular dados armazenados em um banco de dados relacional. Elas permitem a **seleção**, **projeção**, **junção**, **união**, **interseção**, e **diferença** dos dados, tornando possível consultar e modificar informações de forma eficiente.

Esses operadores são fundamentais para a construção de consultas complexas em **SQL** e em sistemas de gerenciamento de banco de dados relacionais (SGBDR).

## Apresentação:
# Critérios para Avaliação da Apresentação

A avaliação será dividida em três partes: apresentação teórica, estudo de caso e exercícios práticos. O total de pontos será 10.

## 1. Apresentação Teórica (30 a 40 minutos) - **Total: 4 pontos**

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

## 2. Estudo de Caso (20 a 30 minutos) - **Total: 3 pontos**
- **Relevância e Aplicação Prática** (1 ponto)
  - O estudo de caso está diretamente relacionado aos conceitos apresentados na teoria.
  - O estudo de caso demonstra como os conceitos do modelo conceitual são aplicados de maneira clara.

- **Completação do Estudo de Caso** (1 ponto)
  - O estudo de caso aborda todos os aspectos solicitados, como o uso de todas as operações da álgebra relacional, terminologia e domínio.

- **Resolução e Conclusão do Caso** (1 ponto)
  - O estudo de caso é concluído com uma análise clara das soluções obtidas.

## 3. Exercícios Práticos (20 a 30 minutos) - **Total: 2 pontos**
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

### Referências

- [Fascículo Introdução Banco de Dados](https://educapes.capes.gov.br/bitstream/capes/564494/2/FASCICULO_Introducao_Banco_Dados_30_08.pdf)
- [Univesp - Introdução a Banco de Dados](https://apps.univesp.br/novotec/introducao-a-banco-de-dados/)
