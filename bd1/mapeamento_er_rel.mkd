# Mapeamento ER x Relacional

O mapeamento ER-X (Entidade-Relacionamento Estendido) para o modelo relacional é o processo de transformar um modelo conceitual ER-X em um esquema de banco de dados relacional. O ER-X é uma extensão do modelo ER tradicional que inclui conceitos adicionais como especialização/generalização, agregação e outros.

## Principais regras de mapeamento:

1. **Entidades**: Cada entidade forte vira uma tabela com sua chave primária.
   - Ex: Cliente(**id_cliente**, nome, endereço)

2. **Atributos**: Atributos simples viram colunas na tabela correspondente.

3. **Relacionamentos**:
   - Relacionamentos 1:1 podem ser representados pela inclusão da chave estrangeira em uma das tabelas
   - Relacionamentos 1:N incluem a chave estrangeira no lado "N"
   - Relacionamentos M:N viram uma tabela adicional com as chaves estrangeiras das entidades envolvidas

4. **Entidades fracas**: Incluem a chave primária da entidade forte como parte de sua chave.

5. **Especialização/Generalização** (herança):
   - Pode ser mapeada como:
     * Uma tabela única com todos os atributos (incluindo um discriminador)
     * Tabelas separadas para superclasse e subclasses
     * Apenas tabelas para as subclasses

6. **Agregações**: São tratadas como entidades normais no mapeamento.

7. **Atributos multivalorados**: Viram tabelas separadas com chave estrangeira para a entidade.

### Compromisso entre

– evitar um grande número de tabelas
• evitar um tempo longo de resposta nas consultas e atualizações de dados
– implica minimizar junções entre tabelas
– evitar atributos opcionais
• evitar tabelas sub-utilizadas
– implica evitar desperdício de espaço
– evitar muitos controles de integridade no BD
• evitar organizações de dados em tabelas que gerem muitos controles de integridade
– implica evitar muitas dependências entre dados

## Processo de Mapeamento

1. Mapeamento preliminar de entidades e seus atributos
2. Mapeamento de especializações
3. Mapeamento de relacionamentos e seus atributos

![texto](./img/map1.png)

## Mapeamento de Entidades Fracas no Modelo Relacional

No modelo ER-X, as entidades fracas são aquelas que dependem da existência de uma entidade forte para ter significado. No mapeamento para o modelo relacional, essa dependência é representada através da incorporação da chave primária da entidade forte na tabela que representa a entidade fraca.

### Regra Fundamental para Entidades Fracas

- A chave primária da entidade forte se torna:
- Parte da chave primária na tabela correspondente à entidade fraca
- Chave estrangeira referenciando a entidade forte

![texto](./img/map2.png)


# Mapeamento de Atributos no Modelo Relacional (Sem SQL)

## 1. Atributos Simples
- Cada atributo simples se transforma em uma coluna na tabela correspondente
- Atributos obrigatórios devem ser marcados como NOT NULL
- Atributos com valores únicos devem ter restrição UNIQUE
- Definir tipos de dados apropriados para cada atributo

## 2. Atributos Compostos
**Opção preferencial**: Desmembrar em colunas individuais para cada componente
- Criar uma coluna separada para cada sub-atributo
- Usar prefixos consistentes para manter a relação (ex: endereco_rua, endereco_numero)

**Alternativa**: Usar tipos estruturados quando disponíveis no SGBD
- Criar um tipo complexo que agrupe todos os sub-atributos
- Usar esse tipo como o tipo de uma única coluna

## 3. Atributos Multivalorados
- Exigem criação de uma tabela separada
- A nova tabela deve conter:
  - Chave estrangeira para a entidade principal
  - Coluna para o valor do atributo multivalorado
  - Possivelmente uma coluna para classificar/descrever os valores múltiplos
- Chave primária composta pela FK + valor ou por um identificador adicional

![texto](./img/map3.png)

# Análise do Diagrama ER Representado na Imagem

A imagem apresenta um modelo Entidade-Relacionamento (ER) simplificado com algumas entidades e seus atributos, mostrando também como eles podem ser mapeados para tabelas relacionais.

## Componentes do Modelo ER

1. **Entidade Principal**:
   - `Empregados` com atributos:
     - `RG` (identificador)
     - `Nome`
     - `Idade`

2. **Entidade Fraca**:
   - `Telefone` que depende de `Empregados` (relacionamento 1:N)
   - Atributo: `Número`

3. **Atributo Composto**:
   - `Endereço` decomposto em:
     - `Rua`
     - `Número` (do endereço)
     - `Cidade`

4. **Atributo Especial**:
   - `PlanoSaúde` com cardinalidade (0,1) indicando que é opcional

## Relacionamentos

- **Empregados (1) → (N) Telefone**: Um empregado pode ter vários telefones
- **Empregados (1) → (0,1) PlanoSaúde**: Um empregado pode ter no máximo um plano de saúde

## Propostas de Mapeamento Relacional

A imagem mostra duas alternativas para representar o telefone:

   ```plaintext
   Empregados (RG, Nome, Idade, PlanoSaúde, Rua, Número, Cidade)
   Telefone(RG, Número)
   ```

## Problemas Identificados

1. **Conflito de Nomenclatura**:
   - `Número` aparece tanto como parte do endereço quanto como atributo de telefone

2. **Formato Não Convencional**:
   - Normalmente representaríamos o mapeamento com mais detalhes de tipos e constraints

Seria mais claro representar como:

```
Empregado(RG[PK], Nome, Idade, Rua, Numero_endereco, Cidade, TemPlanoSaúde)
Telefone(RG[FK], Numero_telefone[PK])
```

Onde:
- `[PK]` indica chave primária
- `[FK]` indica chave estrangeira
- Nomes de atributos foram qualificados para evitar ambiguidade

Outro exemplo:


![texto](./img/map4.png)

## Mapeamento de Especializações (Herança) para o Modelo Relacional

O mapeamento de especializações/generalizações (relações de herança) do modelo ER-X para o modelo relacional pode ser realizado através de três abordagens principais, cada uma com suas vantagens e desvantagens:

## 1. Tabela Única (Single Table Inheritance)

![texto](./img/map5.png)

**Características**:
- Uma única tabela representa a superclasse e todas as subclasses
- Inclui todos os atributos da hierarquia
- Utiliza um discriminador para identificar o tipo específico

**Vantagens**:
- Consultas simples sem necessidade de joins
- Bom desempenho para consultas que abrangem toda a hierarquia
- Fácil implementação de modificações na hierarquia

**Desvantagens**:
- Muitas colunas com valores NULL para atributos não aplicáveis
- Desperdício de espaço de armazenamento
- Dificuldade em adicionar constraints específicas por subclasse

**Cenários recomendados**:
- Quando as subclasses têm poucos atributos específicos
- Quando a maioria das consultas trabalha com a hierarquia inteira
- Para hierarquias pequenas e estáveis

## 2. Tabela para Superclasse e Tabelas para Subclasses (Class Table Inheritance)

![texto](./img/map6.png)

**Características**:
- Uma tabela para a superclasse (contém atributos comuns)
- Tabelas separadas para cada subclasse (contém atributos específicos)
- Chave primária das subclasses é também chave estrangeira para a superclasse

**Vantagens**:
- Sem valores NULL para atributos não aplicáveis
- Estrutura mais normalizada
- Fácil adição de constraints específicas por subclasse

**Desvantagens**:
- Requer joins para consultas completas
- Desempenho inferior para consultas que abrangem múltiplas subclasses
- Mais complexidade nas operações de inserção/atualização

**Cenários recomendados**:
- Quando as subclasses têm muitos atributos específicos
- Quando as consultas geralmente trabalham com uma única subclasse por vez
- Para hierarquias com muitas diferenças entre subclasses

## 3. Tabelas Apenas para Subclasses (Concrete Table Inheritance)

![texto](./img/map7.png)

**Características**:
- Tabelas independentes para cada subclasse
- Cada tabela contém todos os atributos (herdados + específicos)
- Nenhuma tabela para a superclasse abstrata

**Vantagens**:
- Máximo desempenho para consultas específicas por subclasse
- Sem necessidade de joins para acessar todos os atributos
- Estrutura simples para consultas que trabalham com uma única subclasse

**Desvantagens**:
- Dificuldade em consultar toda a hierarquia (requer UNIONs)
- Redundância de atributos comuns
- Dificuldade em manter consistência para alterações em atributos comuns
- Problemas com chaves primárias sobrepostas

**Cenários recomendados**:
- Quando as subclasses são muito diferentes entre si
- Quando raramente se consulta a hierarquia completa
- Para casos onde o polimorfismo não é necessário

## Critérios para Escolha da Abordagem

1. **Padrão de Acesso**:
   - Frequência de consultas que abrangem toda a hierarquia vs. consultas específicas

2. **Grau de Similaridade**:
   - Quantidade de atributos comuns vs. específicos

3. **Tamanho da Hierarquia**:
   - Número de subclasses e profundidade da hierarquia

4. **Restrições de Negócio**:
   - Necessidade de constraints específicas por subclasse

5. **Volume de Dados**:
   - Quantidade de registros e impacto no armazenamento

6. **Frequência de Mudanças**:
   - Estabilidade da estrutura da hierarquia

Cada abordagem tem seu lugar no projeto de bancos de dados, e a escolha deve considerar os requisitos específicos da aplicação e os padrões de acesso aos dados.


## Recomendações de Mapeamento Baseadas em Cardinalidade

A análise da cardinalidade dos relacionamentos é fundamental para determinar a melhor estratégia de mapeamento do modelo ER-X para o modelo relacional. Estas são as principais abordagens:

## 1. Fusão de Entidades em uma Única Tabela

![texto](./img/map8.png)

![texto](./img/map9.png)

![texto](./img/map10.png)

![texto](./img/map11.png)

![texto](./img/map12.png)

**Aplicação ideal**:
- Relacionamentos 1:1 (um-para-um)
- Relacionamentos 1:N (um-para-muitos) quando a entidade no lado "1" tem poucos atributos

**Vantagens**:
- Elimina a necessidade de joins em consultas frequentes
- Simplifica a estrutura do banco de dados
- Reduz o número de tabelas


**Considerações**:
- Avaliar a frequência de acesso conjunto aos dados
- Verificar se não cria muitos campos opcionais (NULL)
- Considerar o crescimento futuro das entidades

## 2. Criação de Tabelas para Relacionamentos


**Aplicação ideal**:
- Relacionamentos M:N (muitos-para-muitos)
- Relacionamentos com atributos próprios
- Relacionamentos ternários ou de grau superior

**Vantagens**:
- Representa fielmente a semântica do modelo ER-X
- Permite incluir atributos do relacionamento
- Facilita consultas complexas



**Considerações**:
- Analisar o volume de dados esperado na tabela de relacionamento
- Definir índices adequados para as chaves estrangeiras
- Considerar constraints de integridade referencial


## 3. Uso de Chaves Estrangeiras em Tabelas Existentes


**Aplicação ideal**:
- Relacionamentos 1:N (um-para-muitos) regulares
- Quando a entidade no lado "N" é a principal para operações de negócio

**Vantagens**:
- Mantém a normalização do esquema
- Boa performance para consultas do lado "N"
- Estrutura intuitiva e fácil de entender


**Considerações**:
- Definir política de atualização/exclusão (CASCADE, SET NULL, etc.)
- Verificar a cardinalidade mínima para definir NOT NULL
- Considerar índices para campos de chave estrangeira

![texto](./img/map13.png)

![texto](./img/map14.png)

![texto](./img/map15.png)

![texto](./img/map16.png)

## Critérios para Decisão

1. **Frequência de acesso**:
   - Padrões de consulta mais comuns na aplicação

2. **Cardinalidade**:
   - 1:1 favorece fusão, M:N exige tabela separada

3. **Atributos do relacionamento**:
   - Existência de atributos no relacionamento pede tabela separada

4. **Volume de dados**:
   - Tabelas muito grandes podem não ser boas candidatas para fusão

5. **Taxa de crescimento**:
   - Entidades com diferentes taxas de crescimento são melhores separadas

6. **Restrições de integridade**:
   - Complexidade das regras de negócio associadas


## Boas Práticas Adicionais

- **Documentar decisões**: Registrar as escolhas de mapeamento e seus motivos
- **Consistência**: Manter padrão uniforme em todo o esquema
- **Flexibilidade**: Deixar espaço para evolução futura
- **Desempenho**: Considerar índices e estratégias de particionamento desde o início
- **Testes**: Validar as escolhas com dados reais e consultas representativas

Esta abordagem estruturada permite traduzir eficientemente o modelo conceitual para o esquema relacional, mantendo as características essenciais do domínio enquanto otimiza o desempenho das operações mais frequentes.

## Mapeamento de Auto-Relacionamentos (Relacionamentos Recursivos) no Modelo ER-X para Relacional

Auto-relacionamentos (ou relacionamentos recursivos) ocorrem quando uma entidade se relaciona consigo mesma. O mapeamento para o modelo relacional varia conforme a cardinalidade do relacionamento.

1. Auto-Relacionamento 1:1 (Um-para-Um)
- Adicionar uma coluna de chave estrangeira na mesma tabela

2. Auto-Relacionamento 1:N (Um-para-Muitos)
- Adicionar coluna de chave estrangeira referenciando a própria tabela

3. Auto-Relacionamento M:N (Muitos-para-Muitos)
- Criar tabela separada para representar o relacionamento
- Ambas as colunas são chaves estrangeiras para a mesma tabela

![texto](./img/map17.png)


## Relacionamentos com Entidades Associativas
- Valem as mesmas recomendações anteriores

![texto](./img/map18.png)

![texto](./img/map19.png)

## Relacionamentos Ternários

Relacionamentos ternários envolvem três entidades distintas e são mais complexos que os relacionamentos binários. Veja como mapeá-los corretamente para o modelo relacional:

1. Estrutura Básica de Mapeamento
Regra fundamental:

Criar uma nova tabela (tabela de associação) que inclui as chaves primárias das três entidades participantes

Adicionar os atributos do relacionamento (se existirem) nesta tabela

2. Variações de Cardinalidade
A cardinalidade de cada participante no relacionamento pode variar:

Caso 1: (1,1) - (1,1) - (1,1)
Todas as entidades devem participar obrigatoriamente

Implementado com NOT NULL em todas as FKs

Caso 2: (0,N) - (1,1) - (1,N)
Algumas entidades podem ser opcionais

Implementado permitindo NULL nas FKs opcionais (menos comum)

![texto](./img/map20.png)

![texto](./img/map21.png)

![texto](./img/map22.png)

![texto](./img/map23.png)

