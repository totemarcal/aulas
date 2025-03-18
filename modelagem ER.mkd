# Modelagem de Dados

## Conteúdo
- **Introdução**: Conceitos básicos e importância da modelagem de dados.
- **Fases de Projeto de BD**: Etapas para a criação de um banco de dados.
- **Ciclo de vida de BD**: Desde a concepção até a manutenção do banco de dados.
- **Modelo conceitual de BD**: Representação abstrata dos dados.
- **Modelo Entidade-Relacionamento**: Técnica para modelar dados usando entidades e relacionamentos.
- **Entidade/Atributo/Relacionamento**: Elementos fundamentais do modelo ER.
- **Representação**: Como os elementos do modelo ER são representados graficamente.
- **Extensões**: Aprimoramentos e variações do modelo ER.

## Introdução

### Abstração
A abstração é uma habilidade mental que permite aos seres humanos visualizarem os problemas do mundo real com vários graus de detalhe, dependendo do contexto do problema. Essa capacidade é essencial para a modelagem de dados, pois permite que os projetistas simplifiquem sistemas complexos, focando nos aspectos mais relevantes para o problema em questão.

**Citação**:  
“Habilidade mental que permite aos seres humanos visualizarem os problemas do mundo real com vários graus de detalhe, dependendo do contexto do problema.”  
**J. Rumbaugh**

### Fases de Projeto de um Banco de Dados
O projeto de um banco de dados envolve três fases principais:

![texto](./fasesbd.drawio.png)

1. **Modelagem Conceitual**:  
   Nesta fase, o objetivo é capturar formalmente os requisitos de informação do banco de dados. O modelo conceitual é independente de qualquer sistema de gerenciamento de banco de dados (SGBD) e foca na estrutura lógica dos dados.

2. **Projeto Lógico**:  
   Aqui, o foco é definir as estruturas de dados que implementam os requisitos identificados na modelagem conceitual. O projeto lógico é dependente do SGBD escolhido e envolve a criação de esquemas lógicos, como tabelas e relacionamentos.

3. **Projeto Físico**:  
   Nesta fase, são definidos os parâmetros físicos de acesso ao banco de dados, como índices, particionamento e otimização de consultas. O objetivo é garantir que o sistema tenha um bom desempenho em relação ao acesso aos dados.

## Ciclo de Vida do Banco de Dados
O ciclo de vida de um banco de dados envolve várias etapas, desde a análise dos requisitos até a manutenção contínua do sistema:

1. **Análise dos Requisitos**:  
   Coleta e análise das necessidades dos usuários e do sistema.

2. **Projeto Conceitual e Lógico**:  
   - **Modelo ER**: Criação do modelo entidade-relacionamento para representar a estrutura lógica dos dados.
   - **Integração das Visões**: Combinação de diferentes visões dos usuários em um modelo único.
   - **Transformações do MER em tabelas SQL**: Conversão do modelo ER em tabelas SQL.
   - **Normalização das tabelas**: Aplicação de técnicas de normalização para evitar redundâncias e inconsistências.

3. **Refinamento de Uso**:  
   Ajustes no banco de dados com base no feedback dos usuários.

4. **Distribuição dos Dados**:  
   Decisão sobre como os dados serão distribuídos em diferentes locais, se necessário.

5. **Definição do Projeto Físico**:  
   Implementação de índices, particionamento e outras otimizações físicas.

6. **Implementação do Banco de Dados**:  
   Criação do banco de dados e carga inicial dos dados.

7. **Monitoramento e Modificações**:  
   Acompanhamento do desempenho do banco de dados e realização de ajustes conforme necessário.

## Modelo Conceitual de Dados
O modelo conceitual de dados é uma representação abstrata e detalhada da estrutura dos dados de uma organização, independente de qualquer sistema de gerenciamento de banco de dados (SGBD). Ele serve como uma ponte entre os requisitos do negócio e a implementação técnica do banco de dados.

**Definições**:  
- “Um modelo conceitual é um modelo detalhado, que captura a estrutura dos dados organizacional sendo independente de qualquer sistema de gerenciamento de base de dados...”  
  **McFadden & Hoffer, p. 87**

- “Coleção de ferramentas conceituais para descrição de dados, relacionamento entre os dados, semântica e restrições de dados.”  
  **Henry F. Korth**

- “Uma coletânea de conceitos que podem ser utilizados para descrever a estrutura de um banco de dados – fornece os meios necessários para alcançar a abstração de dados”  
  **Elmasri/Navathe**

### Modelos Conceituais comuns para Banco de Dados:
- **Modelo Entidade-Relacionamento (ER)**:  
  Foca na estrutura dos dados e metadados, mas não aborda a modelagem funcional.

- **Modelo Orientado a Objeto**:  
  Modela objetos através do encapsulamento dos metadados (estrutura) e métodos (funções).

## Modelo Entidade-Relacionamento (ER)
O modelo ER foi proposto por Peter Chen em 1976 e é baseado na percepção do mundo real. Ele qualifica todo item de informação como **entidade**, **atributos** e **relacionamento**, facilitando o entendimento tanto para o projetista do banco de dados quanto para o usuário.

### Objetivos do Modelo ER:
- **Simplicidade de representação**: Facilita a visualização dos dados e seus relacionamentos.
- **Ferramenta para os projetistas**: Ajuda na criação de esquemas de banco de dados.
- **Ferramenta de comunicação**: Facilita a comunicação entre os projetistas e os usuários.
- **Criar uma visão unificada dos dados**: Integra diferentes visões dos usuários em um modelo único.

### Entidade
Uma **entidade** é qualquer objeto distinto que precisa ser representado no banco de dados. Pode ser concreta (como um carro ou uma casa) ou abstrata (como uma atividade ou um cargo).

- **Instância de uma Entidade**:  
  Representa uma ocorrência específica de uma entidade. Por exemplo, um carro específico com uma placa única.

![texto](./entidade.drawio.png)

### Atributo
Um **atributo** é uma informação útil sobre uma entidade ou relacionamento. Os atributos podem ser:

- **Determinante**: Valor único que identifica uma instância da entidade (chave primária).
- **Composto**: Atributo que pode ser dividido em sub-atributos (por exemplo, endereço pode ser dividido em rua, número, cidade, etc.).
- **Multivalorado**: Atributo que pode ter mais de um valor para uma entidade (por exemplo, um funcionário pode ter vários telefones).

**Domínio de um atributo** - determina o conjunto de valores válidos de um
atributo

Ex : Idade – numérico (0,120)
Nome – texto de 30 posições

![texto](./entidade-atrib.drawio.png)

**Representação no Diagrama de Entidade-Relacionamento(DER)**

![texto](./exemplo_ER.png)

## Entidade

### Definição
O nome da entidade é representado por uma lista de atributos entre parênteses:


## Atributos

### Tipos de Atributos:
1. **Identificador**:  
   - Representado por um atributo **sublinhado**.  
   - Exemplo: `Placa` (chave primária).

2. **Multivalorados**:  
   - Representados por **chaves `{}`**.  
   - Exemplo: `{cor}` (um carro pode ter várias cores).

3. **Compostos**:  
   - Representados por **parênteses `( )`**.  
   - Exemplo: `Registro(Numero, Estado)` (um atributo composto por sub-atributos).

---

## Exemplo

### Entidade: Carro
```plaintext
Carro = (Placa, Registro(Numero, Estado), Modelo, {cor})
```

Instâncias da Entidade Carro:

```plaintext
(BSA3321, (234, Bahia), Corsa, {azul, branco})
(VIT3521, (317, Bahia), Corsa, {vermelho, preto})
```

**Entidade: Carro**

- **Atributos**:
  - `Placa` (Identificador)
  - `Registro` (Composto):
    - `Numero`
    - `Estado`
  - `Modelo` (Simples)
  - `{cor}` (Multivalorado)

**Instâncias**:
1. `(BSA3321, (234, Bahia), Corsa, {azul, branco})`
2. `(VIT3521, (317, Bahia), Corsa, {vermelho, preto})`


---

## Entidades Fortes e Fracas

### Entidades Fortes
- **Definição**:  
  Entidades fortes são aquelas que possuem um **alto grau de independência** em relação à sua existência e identificação. Elas não dependem de outras entidades para existir no banco de dados.

- **Características**:
  - Possuem uma **chave primária própria** que as identifica unicamente.
  - Podem existir sem estar associadas a outras entidades.
  - São a base para a criação de entidades fracas.

- **Exemplo**:  
  A entidade **Funcionário** pode ser uma entidade forte, pois cada funcionário tem uma matrícula única que o identifica, e ele pode existir independentemente de outras entidades.


### Entidades Fracas
- **Definição**:  
  Entidades fracas são aquelas que **dependem de outras entidades** (fortes ou fracas) para existir e serem identificadas. Elas não possuem uma chave primária própria completa e precisam estar associadas a uma entidade forte.

- **Características**:
  - **Dependência de existência**:  
    Uma entidade fraca só existe se a entidade forte à qual está associada existir.
  - **Dependência de identificação**:  
    A chave primária de uma entidade fraca é composta por uma **chave parcial própria** e pela **chave primária da entidade forte** à qual está associada.
  - **Relacionamento obrigatório**:  
    Uma entidade fraca deve estar relacionada a pelo menos uma entidade forte.

- **Propriedades das Entidades Fracas**:
  1. **Pertencem a uma única entidade**:  
     Uma entidade fraca está sempre associada a uma única entidade (forte ou fraca).
  2. **Relacionamento com entidade forte**:  
     Deve haver pelo menos um relacionamento estabelecido com uma entidade forte.
  3. **Identificação parcial própria**:  
     A entidade fraca possui pelo menos um atributo que a identifica parcialmente.
  4. **Identificação da entidade forte**:  
     A chave primária da entidade forte é parte da chave primária da entidade fraca.

- **Exemplo**:  
  A entidade **Dependente** pode ser uma entidade fraca, pois depende da entidade **Funcionário** para existir. A chave primária de **Dependente** pode ser composta pela matrícula do funcionário (chave estrangeira) e pelo nome do dependente (chave parcial).


## Representação em Diagrama ER

### Entidade Forte: Funcionário
```plaintext
Funcionário (
    matricula,  -- Chave primária
    nome,
    endereço
)
```

### Entidade Fraca: Dependente
```plaintext
Dependente (
    matricula_funcionario,  -- Chave estrangeira (parte da chave primária)
    nome_dependente,        -- Chave parcial
    data_nascimento
)
```

## Exemplo Prático

### Entidade Forte: Funcionário
```plaintext
Funcionário (
    matricula,  -- Chave primária
    nome,
    endereço
)
```

### Entidade Fraca: Dependente
```plaintext
Dependente (
    matricula_funcionario,  -- Chave estrangeira (referencia Funcionário)
    nome_dependente,        -- Chave parcial
    data_nascimento
)
```

### Instâncias:
1. **Funcionário**:
   - `(123, "João Silva", "Rua A, 123")`
   - `(456, "Maria Souza", "Rua B, 456")`

2. **Dependente**:
   - `(123, "Ana Silva", "2005-03-15")`
   - `(123, "Pedro Silva", "2010-07-22")`
   - `(456, "Carlos Souza", "2012-11-10")`


## Resumo

| **Tipo de Entidade** | **Características**                                                                 |
|-----------------------|-------------------------------------------------------------------------------------|
| **Forte**             | - Independente.<br>- Possui chave primária própria.<br>- Pode existir sozinha.      |
| **Fraca**             | - Dependente de uma entidade forte.<br>- Chave primária composta.<br>- Relacionamento obrigatório com entidade forte. |

![texto](./fig-dependencia.png)


## Atributo de Identificação e Conexão

Os atributos de identificação e conexão são fundamentais no modelo de banco de dados, pois garantem a integridade e a consistência dos dados. Eles ajudam a estabelecer relacionamentos entre entidades e a identificar unicamente cada instância de uma entidade.


### 1. **Chave Primária (Primary Key)**

#### Definição:
A **chave primária** é um atributo (ou conjunto de atributos) que identifica **unicamente** cada instância de uma entidade. Ela garante que não haja duplicidade de registros em uma tabela.

#### Características:
- **Única**: Não pode haver duas instâncias com o mesmo valor para a chave primária.
- **Não nula**: A chave primária não pode ter valores nulos (`NULL`).
- **Imutável**: O valor da chave primária não deve mudar ao longo do tempo.

#### Exemplo:
Na entidade **Funcionário**, o atributo `matricula` pode ser a chave primária, pois cada funcionário tem uma matrícula única.

```plaintext
Funcionário (
    matricula,  -- Chave primária
    nome,
    endereço
)
```

#### Representação no Diagrama ER:
- A chave primária é sublinhada no diagrama ER.
- Exemplo: `matricula`.


### 2. **Chave Candidata (Candidate Key)**

#### Definição:
Uma **chave candidata** é um atributo (ou conjunto de atributos) que **poderia ser usado como chave primária**, mas não foi escolhido como tal. Uma entidade pode ter várias chaves candidatas, mas apenas uma será selecionada como chave primária.

#### Características:
- **Única**: Assim como a chave primária, a chave candidata deve identificar unicamente cada instância.
- **Não nula**: Não pode ter valores nulos.
- **Minimalidade**: Deve conter o menor número possível de atributos para garantir a unicidade.

#### Exemplo:
Na entidade **Funcionário**, além da `matricula`, o atributo `CPF` também pode ser uma chave candidata, pois cada funcionário tem um CPF único.

```plaintext
Funcionário (
    matricula,  -- Chave primária
    CPF,        -- Chave candidata
    nome,
    endereço
)
```

#### Representação no Diagrama ER:
- As chaves candidatas não são sublinhadas, mas são consideradas como opções para a chave primária.


### 3. **Chave Estrangeira (Foreign Key)**

#### Definição:
A **chave estrangeira** é um atributo (ou conjunto de atributos) em uma entidade que **referencia a chave primária de outra entidade**. Ela é usada para estabelecer relacionamentos entre entidades.

#### Características:
- **Referência**: A chave estrangeira deve sempre referenciar uma chave primária válida em outra entidade.
- **Integridade referencial**: Garante que não haja referências a registros que não existem.
- **Pode ser nula**: Dependendo do relacionamento, a chave estrangeira pode permitir valores nulos.

#### Exemplo:
Na entidade **Dependente**, o atributo `matricula_funcionario` é uma chave estrangeira que referencia a chave primária `matricula` da entidade **Funcionário**.

```plaintext
Funcionário (
    matricula,  -- Chave primária
    nome,
    endereço
)

Dependente (
    matricula_funcionario,  -- Chave estrangeira (referencia Funcionário)
    nome_dependente,        -- Chave parcial
    data_nascimento
)
```

#### Representação no Diagrama ER:
- A chave estrangeira é representada por uma seta ou linha que conecta as entidades.
- Exemplo: `matricula_funcionario` em **Dependente** referencia `matricula` em **Funcionário**.


### Exemplo Completo

#### Entidade Forte: Funcionário
```plaintext
Funcionário (
    matricula,  -- Chave primária
    CPF,        -- Chave candidata
    nome,
    endereço
)
```

#### Entidade Fraca: Dependente
```plaintext
Dependente (
    matricula_funcionario,  -- Chave estrangeira (referencia Funcionário)
    nome_dependente,        -- Chave parcial
    data_nascimento
)
```

#### Instâncias:
1. **Funcionário**:
   - `(123, "111.222.333-44", "João Silva", "Rua A, 123")`
   - `(456, "555.666.777-88", "Maria Souza", "Rua B, 456")`

2. **Dependente**:
   - `(123, "Ana Silva", "2005-03-15")`
   - `(123, "Pedro Silva", "2010-07-22")`
   - `(456, "Carlos Souza", "2012-11-10")`


### Resumo

| **Tipo de Chave**      | **Definição**                                                                 | **Exemplo**                          |
|-------------------------|-------------------------------------------------------------------------------|--------------------------------------|
| **Chave Primária**      | Atributo que identifica unicamente uma instância de uma entidade.             | `matricula` em **Funcionário**.      |
| **Chave Candidata**     | Atributo que poderia ser usado como chave primária, mas não foi escolhido.    | `CPF` em **Funcionário**.            |
| **Chave Estrangeira**   | Atributo que referencia a chave primária de outra entidade.                   | `matricula_funcionario` em **Dependente**. |

### Relacionamento

# Relacionamentos entre Entidades

No contexto de modelagem de banco de dados, as **entidades** representam objetos ou conceitos do mundo real que possuem atributos e são armazenados em tabelas. No entanto, as entidades não existem isoladamente. Elas estão interconectadas por meio de **relacionamentos**, que são associações lógicas entre duas ou mais entidades. Esses relacionamentos são essenciais para representar corretamente o ambiente observado e garantir a integridade dos dados.

---

## O que é um Relacionamento?
Um **relacionamento** é uma associação lógica entre entidades. Ele descreve como as entidades interagem entre si e como os dados de uma entidade estão conectados aos dados de outra. Por exemplo:
- Um **departamento** pode ter vários **empregados**.
- Um **empregado** pode trabalhar em apenas um **departamento**.
- Um **produto** pode ser vendido em várias **vendas**.

Os relacionamentos são representados graficamente em diagramas entidade-relacionamento (DER) por meio de **losangos**, que conectam as entidades envolvidas.

---

## Tipos de Relacionamentos
Os relacionamentos podem ser classificados de acordo com a cardinalidade, ou seja, quantas instâncias de uma entidade estão associadas a instâncias de outra entidade. Os principais tipos são:

### 1. Relacionamento **1:1** (Um para Um)
- Uma instância de uma entidade está associada a **no máximo uma** instância de outra entidade.
- Exemplo: Um **empregado** tem apenas um **crachá**, e um **crachá** pertence a apenas um **empregado**.

### 2. Relacionamento **1:N** (Um para Muitos)
- Uma instância de uma entidade está associada a **várias** instâncias de outra entidade.
- Exemplo: Um **departamento** pode ter vários **empregados**, mas um **empregado** pertence a apenas um **departamento**.

### 3. Relacionamento **N:N** (Muitos para Muitos)
- Várias instâncias de uma entidade estão associadas a várias instâncias de outra entidade.
- Exemplo: Um **projeto** pode ter vários **empregados**, e um **empregado** pode trabalhar em vários **projetos**.

---

### Representação Gráfica
Em um diagrama entidade-relacionamento (DER), os relacionamentos são representados da seguinte forma:
- **Entidades**: São representadas por retângulos.
- **Atributos**: São representados por elipses.
- **Relacionamentos**: São representados por losangos.

![texto](./fig-entidade-rel.png)

## Grau do relacionamento

O grau de um relacionamento refere-se ao número de entidades que participam de uma associação lógica. Em outras palavras, ele define quantas entidades estão envolvidas em um relacionamento. Dependendo do número de entidades, os relacionamentos podem ser classificados como:

Relacionamento Binário (Grau 2): Envolve duas entidades.

Relacionamento Ternário (Grau 3): Envolve três entidades.

Relacionamento N-ário (Grau N): Envolve N entidades.

![texto](./fig-grau-rel.png)

![texto](./fig-grau-terc-rel.png)

---

# Cardinalidade em Relacionamentos

A **cardinalidade** em modelagem de banco de dados define o número de instâncias de uma entidade que podem ser associadas a instâncias de outra entidade por meio de um relacionamento. Ela é fundamental para representar as regras de negócio e garantir a integridade dos dados. A cardinalidade é geralmente expressa em termos de:

1. **Mínimo**: O número mínimo de instâncias que podem participar de um relacionamento.
2. **Máximo**: O número máximo de instâncias que podem participar de um relacionamento.

A cardinalidade é representada em diagramas entidade-relacionamento (DER) por meio de notações como `(0,1)`, `(1,1)`, `(0,N)` ou `(1,N)`.

---

## Tipos de Cardinalidade

### 1. Cardinalidade **1:1** (Um para Um)
- **Descrição**: Cada instância de uma entidade está associada a **no máximo uma** instância de outra entidade, e vice-versa.
- **Notação**: `(1,1)` para ambos os lados do relacionamento.
- **Exemplo**:
  - Um **empregado** tem apenas um **crachá**.
  - Um **crachá** pertence a apenas um **empregado**.

#### Representação no DER:

![texto](./fig-rel-1x1.png)

---

### 2. Cardinalidade **1:N** (Um para Muitos)
- **Descrição**: Uma instância de uma entidade pode estar associada a **várias** instâncias de outra entidade, mas cada instância da segunda entidade está associada a **apenas uma** instância da primeira.
- **Notação**: `(1,1)` de um lado e `(0,N)` ou `(1,N)` do outro.
- **Exemplo**:
  - Um **departamento** pode ter vários **empregados**.
  - Um **empregado** pertence a apenas um **departamento**.

#### Representação no DER:

![texto](./fig-rel-1xN.png)

---

### 3. Cardinalidade **N:N** (Muitos para Muitos)
- **Descrição**: Várias instâncias de uma entidade podem estar associadas a várias instâncias de outra entidade.
- **Notação**: `(0,N)` ou `(1,N)` em ambos os lados do relacionamento.
- **Exemplo**:
  - Um **empregado** pode participar de vários **projetos**.
  - Um **projeto** pode ter vários **empregados**.

#### Representação no DER:

![texto](./fig-rel-NxN.png)

#### Exemplo

![texto](./fig-rel-exemp.png)

---

## Cardinalidade Mínima e Máxima

A cardinalidade pode ser expressa em termos de **mínimo** e **máximo**:

1. **Cardinalidade Mínima**:
   - Indica se a participação de uma entidade no relacionamento é **obrigatória** (1) ou **opcional** (0).
   - Exemplo: Um **empregado** deve pertencer a um **departamento** (mínimo = 1).

2. **Cardinalidade Máxima**:
   - Indica o número máximo de instâncias que podem participar do relacionamento.
   - Exemplo: Um **empregado** pode pertencer a apenas um **departamento** (máximo = 1).

### Exemplo de Notação:
- `(0,1)`: Opcional, no máximo uma instância.
- `(1,1)`: Obrigatório, exatamente uma instância.
- `(0,N)`: Opcional, muitas instâncias.
- `(1,N)`: Obrigatório, muitas instâncias.

---

## Exemplo Prático

### Cenário:
- Um **empregado** pode trabalhar em apenas um **departamento** (cardinalidade 1:1 ou 1:N).
- Um **empregado** pode participar de vários **projetos**, e um **projeto** pode ter vários **empregados** (cardinalidade N:N).



---

### Conclusão
A cardinalidade é um conceito essencial na modelagem de banco de dados, pois define como as entidades se relacionam entre si. Ela ajuda a garantir que as regras de negócio sejam respeitadas e que os dados sejam consistentes. Ao compreender e aplicar corretamente a cardinalidade, é possível criar modelos de banco de dados eficientes e alinhados às necessidades do sistema.


## Notações para DER

![texto](./fig-notacoes.png)


## Outro Exemplo

![texto](./fig-rel-outro-exempl.png)

## Posto de Combuitível

![texto](./fig-rel-posto.png)

## Exercícios

1. Definir o relacionamento entre as entidades Cliente, Agência e Conta Corrente, apontando a cardinalidade dos relacionamentos. Neste problema o Cliente pode possuir várias Contas-correntes. Uma Conta-corrente pertence a uma única Agência. Uma conta corrente pode pertencer a mais de um cliente. Uma agência pode possuir várias contas-correntes.

2. Todo consumidor possui apenas um registro de dados cadastrais.

Consumidor(CPF, Nome) FK=CPF se refere a CPF de Dados Cadastrais
Dados Cadastrais(CPF, Endereço) FK=CPF se refere a CPF de Consumidor

3. Um homem pode ser casado com uma única mulher. Uma mulher pode ser casa com um único homem. O casamento possui uma data de casamento.

Homem(CPF, Nome)
Mulher(CPF, Nome)
Casado(CPFHomem, CPFMulher, DataCasamento)

4. Todo vendedor emite vários pedidos de compra. Um pedido de compra pode ser emitido através da Internet sem o envolvimento do vendedor. A emissão de um pedido possui data.

Vendedor(Nome, Telefone)
Pedido(Número, Item, Quantidade)
Emissão(NumeroPedido, NomeVendedor, Data)
FK=NomeVendedor se refere a Nome de Vendedor


5. Todo funcionário participa de pelo menos um projeto. Cada projeto tem a participação de um ou vários funcionários. Cada participação possui horas trabalhadas.

Funcionario(Matricula, Nome, Função)
Projeto(Codigo, Nome)
Participa(MatFunc, CodProjeto, HorasTrabalhadas)


## Auto-Relacionamento (Relacionamento Recursivo)

O auto-relacionamento (ou relacionamento recursivo) ocorre quando uma entidade está relacionada consigo mesma. Esse tipo de relacionamento é útil para modelar situações em que uma instância de uma entidade precisa se associar a outras instâncias da mesma entidade. Vamos explorar esse conceito com um exemplo prático.

Definição
Auto-relacionamento: Um relacionamento onde uma entidade está associada a si mesma.

Também chamado de: Relacionamento recursivo.

Uso comum: Modelar hierarquias, relações de parentesco, estruturas organizacionais, etc.


![texto](./fig-rel-auto.png)

### Outro Exemplo

![texto](./fig-rel-auto-outro.png)


## Recomendações para criação de um DER

✓ Antes de começar a modelar, conheça o “mundo real”.
✓ Identifique quais são as ENTIDADES.
✓ Para cada Entidade represente seus ATRIBUTOS.
✓ Verifique a necessidade de ESPECIALIZAÇÃO.
✓ Confronte cada Entidade consigo mesma e com as demais na procura de possíveis RELACIONAMENTOS.
✓ Verifique a existência de ATRIBUTOS DE RELACIONAMENTO.
✓ Identifique as cardinalidades dos relacionamentos
✓ Para relacionamentos múltiplos estude a necessidade de AGREGAÇÕES.
✓ Desenhe o DER, com todas as Entidades, Atributos e Relacionamentos.
✓ Analise cuidadosamente todas as restrições que você impôs.
✓ Até que você e os seus usuários estejam convencidos de que o DER reflete fielmente o “mundo real”, volte ao item 1.

## Exercício Estúdio de Tatuagem

Um proprietário de Estúdio de Tatuagem precisa de um sistema para controlar suas atividades.
✓ O sistema deve oferecer a funcionalidade de cadastrar todos os clientes. Apenas clientes cadastrados são atendidos no Estúdio.
✓ Todas as tatuagens aplicadas nos clientes são catalogadas e estão associadas aos clientes que as utilizou. Assim, é possível pesquisar que clientes utilizou cada uma das tatuagens.
✓ Caso o cliente traga o desenho, esse precisa também ser cadastrado no catálogo do Estúdio.
✓ Todos os tatuadores também precisam ser cadastrados e sempre fica registrado que tatuador aplicou a tatuagem ao cliente, devendo ser registrada em que data foi aplicada.
▪ As tatuagens possuem um preço, além de informações sobre se é colorida ou não, qual o tamanho.
▪ Dos tatuadores precisa cadastrar nome, data de nascimento, RG, CPF e telefone.
▪ Dos clientes precisam ser guardados dados como nome, endereço, data de nascimento, profissão, CPF e telefone.


## Exercício da Fazendo

Uma fazenda precisa de um sistema para controlar o rebanho de ovelhas. Para cada animal é necessário guardar informações sobre seu código de registro, sexo, data de nascimento, raça, cor
e data da última vacinação.
O sistema precisa também acompanhar o peso do animal, e isso é aferido a cada mês e deve ficar registrado no sistema.
Os animais também passam por consultas e procedimentos de veterinários. Os veterinários são registrados e deve ser armazenado no sistema informação do Registro CRMV, Nome, data de nascimento e especialidade de cada veterinário.
As consultas e procedimentos que são feitos precisam ficar registrados, com dados da data, valor pago. No caso de procedimento, também deve ser registrado o tipo de procedimento realizado.

# Extensões ao Modelo Entidade-Relacionamento (E-R)

O modelo Entidade-Relacionamento (E-R) tradicional é uma ferramenta poderosa para modelagem conceitual de bancos de dados. No entanto, ele não consegue refletir todos os fatos do mundo real de forma completa. Para tornar a modelagem mais fiel à realidade e aumentar sua expressividade semântica, foram introduzidas extensões ao modelo E-R. Essas extensões incluem:

1. **Generalização/Especialização**.
2. **Agregação**.

Vamos explorar cada uma dessas extensões em detalhes.

---

## 1. Generalização/Especialização

A **generalização/especialização** é uma técnica que permite organizar entidades em hierarquias, onde uma entidade mais geral (superclasse) pode ser dividida em entidades mais específicas (subclasses). Essa abordagem é útil para representar situações em que um conjunto de entidades compartilha características comuns, mas também possui atributos ou comportamentos específicos.

### Conceitos Básicos

#### Especialização
- **Definição**: Processo de subdividir uma entidade (superclasse) em subclasses mais específicas.
- **Objetivo**: Capturar características específicas de subconjuntos de instâncias da entidade.
- **Exemplo**:
  - A entidade **Funcionário** pode ser especializada em **Gerente** e **Analista**.
  - **Funcionário** é a superclasse, enquanto **Gerente** e **Analista** são subclasses.

#### Generalização
- **Definição**: Processo inverso da especialização, onde várias subclasses são agrupadas em uma superclasse.
- **Objetivo**: Capturar características comuns a todas as subclasses.
- **Exemplo**:
  - As entidades **Cachorro**, **Gato** e **Pássaro** podem ser generalizadas em **Animal**.
  - **Animal** é a superclasse, enquanto **Cachorro**, **Gato** e **Pássaro** são subclasses.

### Características
- **Herança**: As subclasses herdam os atributos e relacionamentos da superclasse.
- **Atributos Específicos**: Cada subclass pode ter atributos adicionais que não se aplicam à superclasse.
- **Relacionamentos**: As subclasses podem participar de relacionamentos específicos.

### Representação no DER

![texto](./fig-espc.png)

![texto](./fig-espc-2.png)


---

## 2. Agregação

A **agregação** é uma abstração que permite tratar um relacionamento como uma entidade de nível mais alto. Isso é útil quando um relacionamento precisa participar de outro relacionamento ou quando desejamos associar atributos a um relacionamento.

### Conceitos Básicos

#### Definição
- **Agregação**: Trata um relacionamento como uma entidade, permitindo que ele participe de outros relacionamentos.
- **Objetivo**: Modelar situações complexas onde relacionamentos precisam ser associados a outras entidades ou relacionamentos.

### Representação no DER

![texto](./fig-agrega.png)

![texto](./fig-agreg2.png)

---

## Conclusão

As extensões ao modelo E-R, como **generalização/especialização** e **agregação**, tornam a modelagem conceitual mais rica e expressiva, permitindo representar situações complexas do mundo real de forma mais fiel. Essas técnicas são essenciais para modelar hierarquias de classes, relacionamentos complexos e atributos associados a relacionamentos. Ao dominar essas extensões, é possível criar modelos de banco de dados mais robustos e alinhados às necessidades do sistema.