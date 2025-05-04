# **Técnicas de Controle de Concorrência**

O controle de concorrência em sistemas de banco de dados é essencial para garantir a consistência dos dados quando múltiplas transações são executadas simultaneamente. Existem diferentes abordagens para lidar com esse problema, sendo as principais classificadas em **técnicas pessimistas** e **otimistas**.

---

## **1. Técnicas Pessimistas**
As técnicas pessimistas assumem que **sempre ocorre interferência entre transações** e, portanto, garantem a serializabilidade (execução equivalente a uma execução sequencial) **enquanto a transação está ativa**.

### **1.1. Bloqueio (Locking)**
Bloqueios (*locks*) são mecanismos amplamente utilizados pelos Sistemas de Gerenciamento de Banco de Dados (SGBDs) para controlar o acesso concorrente aos dados.

#### **Princípio de Funcionamento**
- Cada item de dado possui um **status de bloqueio** associado a ele, que pode ser:
  - **Liberado (Unlocked - U)**: O dado está disponível para acesso.
  - **Bloqueio Compartilhado (Shared lock - S)**: Permite múltiplas leituras simultâneas, mas impede escrita.
  - **Bloqueio Exclusivo (eXclusive lock - X)**: Permite leitura e escrita, mas apenas por uma transação por vez.

#### **Tipos de Bloqueio**
- **Bloqueio Compartilhado (S)**:
  - Solicitado por transações que desejam apenas **ler (read)** um dado.
  - Várias transações podem manter um bloqueio compartilhado no mesmo dado simultaneamente.
- **Bloqueio Exclusivo (X)**:
  - Solicitado por transações que desejam **ler e modificar (write)** um dado.
  - Apenas **uma transação por vez** pode manter um bloqueio exclusivo sobre um dado.

#### **Gerenciamento de Bloqueios**
- As informações de bloqueio são armazenadas no **Dicionário de Dados (DD)** no formato:
  ```
  <ID-dado, status-bloqueio, ID-transação>
  ```
- O **escalonador (scheduler)** gerencia os bloqueios automaticamente, invocando operações como:
  - **`ls(D)`**: Solicita bloqueio compartilhado sobre o dado `D`.
  - **`lx(D)`**: Solicita bloqueio exclusivo sobre o dado `D`.
  - **`u(D)`**: Libera o bloqueio sobre o dado `D`.

#### **Problemas com Bloqueios**
- **Deadlocks**: Ocorre quando duas ou mais transações estão esperando uma pela outra liberar bloqueios, criando um ciclo de espera infinita.
- **Starvation (Inanição)**: Uma transação pode ficar indefinidamente esperando por um bloqueio devido a prioridades ou políticas inadequadas.

---

### **1.2. Timestamp (Marca Temporal)**
- Cada transação recebe um **timestamp** único no momento de sua criação.
- O SGBD verifica se a ordem de execução respeita a ordem dos timestamps para garantir serializabilidade.
- Se uma transação tenta acessar um dado de forma inconsistente com seu timestamp, ela é abortada.

---

## **2. Técnicas Otimistas**
As técnicas otimistas assumem que **quase nunca ocorre interferência entre transações** e verificam a serializabilidade apenas **no final da execução**.

### **2.1. Validação**
- A transação é executada **sem bloqueios**, assumindo que não haverá conflitos.
- Ao final, o sistema verifica se houve interferência:
  - Se **não houve conflito**, a transação é confirmada (*commit*).
  - Se **houve conflito**, a transação é abortada e reiniciada.

#### **Vantagens**
- Evita overhead de bloqueios quando há baixa concorrência.
- Boa para ambientes com poucas transações conflitantes.

#### **Desvantagens**
- Pode levar a retrabalho se muitas transações forem abortadas.

---

## **3. Comparação entre Abordagens**
| **Critério**          | **Pessimista**                     | **Otimista**                     |
|-----------------------|-----------------------------------|----------------------------------|
| **Suposição**         | Conflitos são frequentes          | Conflitos são raros              |
| **Verificação**       | Durante a execução                | Ao final da transação            |
| **Overhead**          | Alto (gerenciamento de bloqueios) | Baixo (sem bloqueios)            |
| **Abortes**           | Menos frequentes                  | Mais frequentes em alta concorrência |
| **Aplicação**         | Alta concorrência                 | Baixa concorrência               |


![texto](./imagens/cc1.png)

---

# **Solicitação de Bloqueio Compartilhado (`lock-S(D, Tx)`)**

A operação `lock-S(D, Tx)` é usada para solicitar um **bloqueio compartilhado (S)** sobre um dado `D` para a transação `Tx`. Esse tipo de bloqueio permite que múltiplas transações leiam o dado simultaneamente, mas impede que qualquer transação o modifique enquanto houver bloqueios compartilhados ativos.

## **Algoritmo da Operação `lock-S(D, Tx)`**
```plaintext
lock-S(D, Tx)
início
    se lock(D) = ‘U’ então  // Se o dado D não está bloqueado
        início
            insere Tx na lista-READ(D);  // Adiciona Tx à lista de leitores
            lock(D) ← ‘S’;  // Atualiza o status do bloqueio para compartilhado
        fim
    senão se lock(D) = ‘S’ então  // Se já há bloqueio compartilhado
        insere Tx na lista-READ(D)  // Adiciona Tx à lista de leitores
    senão  // lock(D) = ‘X’ (bloqueio exclusivo ativo)
        insere (Tx, ‘S’) na fila-WAIT(D);  // Adiciona Tx à fila de espera
fim
```

---

## **Funcionamento Detalhado**
1. **Se `D` está desbloqueado (`lock(D) = 'U'`)**:
   - A transação `Tx` é adicionada à **lista-READ(D)**, que mantém o registro de todas as transações com bloqueio compartilhado.
   - O status do bloqueio de `D` é atualizado para **`'S'` (compartilhado)**.

2. **Se `D` já possui um bloqueio compartilhado (`lock(D) = 'S'`)**:
   - A transação `Tx` é **adicionada à lista-READ(D)**, permitindo que múltiplas transações leiam o dado simultaneamente.

3. **Se `D` possui um bloqueio exclusivo (`lock(D) = 'X'`)**:
   - A transação `Tx` **não pode adquirir o bloqueio compartilhado imediatamente**.
   - `Tx` é colocada na **fila-WAIT(D)**, aguardando até que o bloqueio exclusivo seja liberado.

---

## **Exemplo de Funcionamento**
| **Transação** | **Operação**       | **Estado de `D`** | **Ação**                                                                 |
|---------------|--------------------|-------------------|--------------------------------------------------------------------------|
| T1            | `lock-S(D, T1)`    | `U` (desbloqueado)| T1 é adicionada a `lista-READ(D)`; `lock(D)` ← `'S'`                     |
| T2            | `lock-S(D, T2)`    | `S`               | T2 é adicionada a `lista-READ(D)`                                        |
| T3            | `lock-X(D, T3)`    | `S`               | T3 é adicionada a `fila-WAIT(D)` (precisa esperar)                       |
| T1            | `unlock(D, T1)`    | `S`               | T1 é removida de `lista-READ(D)`; se lista vazia, `lock(D)` ← `'U'`      |
| T3            | (T3 tenta `lock-X`)| `U`               | Agora T3 pode adquirir `lock-X(D)`                                       |

---

## **Regras de Compatibilidade de Bloqueios**
| **Bloqueio Atual** →<br>**Solicitado** ↓ | **`U` (Unlocked)** | **`S` (Shared)** | **`X` (Exclusive)** |
|------------------------------------------|-------------------|------------------|---------------------|
| **`S` (Shared)**                         | ✅ Permitido       | ✅ Permitido      | ❌ Bloqueado (WAIT)  |
| **`X` (Exclusive)**                      | ✅ Permitido       | ❌ Bloqueado (WAIT)| ❌ Bloqueado (WAIT)  |

- **`S` é compatível com `S`**: Múltiplas transações podem ler simultaneamente.
- **`X` é incompatível com qualquer outro bloqueio**: Apenas uma transação por vez pode escrever.

---

## **Conclusão**
- O **bloqueio compartilhado (`lock-S`)** permite **leitura concorrente**, mas impede escrita até que todos os leitores liberem o dado.
- Se um **bloqueio exclusivo (`X`)** estiver ativo, novas solicitações de `S` ou `X` são **postergadas** (adicionadas à `fila-WAIT`).
- Essa abordagem garante **serializabilidade** e **consistência** em ambientes com concorrência.


# **Explicação Detalhada do Read_Lock (X) - Bloqueio de Leitura**

Este algoritmo implementa um **mecanismo de bloqueio compartilhado (leitura)** para controle de concorrência em bancos de dados, permitindo que múltiplas transações leiam um dado simultaneamente enquanto bloqueia escritas durante leituras ativas.

## **Funcionamento do Algoritmo**

```pseudocode
Read_Lock (X):
B: if LOCK (x) = "unlocked" then
       begin 
           LOCK (x) ← "read-locked"  // Bloqueio para leitura
           no_of_reads(X) ← 1        // Contador de leitores = 1
       end
   else if LOCK (x) = "read-locked" then
       no_of_reads(X) ← no_of_reads(X) + 1  // Incrementa contador
   else 
       begin 
           wait (até LOCK (X) = "unlocked" e o gerenciador de bloqueios liberar a transação)
           go to B  // Tenta novamente
       end;
```

### **Passo a Passo**

1. **Se o dado `X` está desbloqueado (`"unlocked"`)**  
   - O bloqueio é alterado para `"read-locked"` (leitura travada).  
   - O contador `no_of_reads(X)` é definido como `1`.  

2. **Se já existe um bloqueio de leitura (`"read-locked"`)**  
   - O contador `no_of_reads(X)` é incrementado (`+1`).  
   - *Isso permite múltiplas leituras simultâneas.*  

3. **Se existe um bloqueio de escrita (`"write-locked"`)**  
   - A transação **espera** até que o bloqueio de escrita seja liberado.  
   - Quando liberado, **retorna ao início (label `B`)** e tenta novamente.  

---

# **Write_Lock (X) - Explicação Detalhada**

Este pseudocódigo implementa um **mecanismo de bloqueio exclusivo (escrita)** para controle de concorrência em bancos de dados. Ele garante que apenas uma transação por vez possa modificar um dado, prevenindo conflitos de escrita.

## **Algoritmo do Bloqueio de Escrita**

```pseudocode
Write_Lock (X):
B: if LOCK (x) = "unlocked" then
       LOCK (x) ← "write-locked"  // Adquire bloqueio exclusivo
   else 
       begin 
           wait (until LOCK (X) = "unlocked" and the lock manager wakes up the transaction)
           go to B  // Retry após desbloqueio
       end;
```

### **Funcionamento Passo a Passo**

1. **Verificação do Estado do Bloqueio**
   - Se `LOCK(x) = "unlocked"` (dado disponível):
     - Adquire o bloqueio exclusivo (`"write-locked"`).
   - Caso contrário (já existe bloqueio - seja de leitura ou escrita):
     - A transação entra em **estado de espera**.
     - Quando o dado for liberado (`"unlocked"`), o gerenciador de bloqueios notifica a transação.
     - A transação **retorna ao início (label `B`)** e tenta novamente.

2. **Regras de Conflito**
   - Um `Write_Lock` só é concedido se **nenhum outro bloqueio** (leitura ou escrita) estiver ativo.
   - Bloqueios de escrita são **mutuamente exclusivos**: apenas uma transação pode escrever por vez.

---

# **Unlock_Lock (X) - Liberação de Bloqueios**

Este pseudocódigo implementa a operação de **liberação de bloqueios** (unlock) em um sistema de controle de concorrência, tratando tanto bloqueios exclusivos (escrita) quanto compartilhados (leitura).

## **Algoritmo Completo**

```pseudocode
Unlock_Lock (X):
    if LOCK (x) = "write-locked" then
        begin 
            LOCK (x) ← "unlocked"
            wakeup one of the waiting transactions, if any
        end
    else if LOCK (x) = "read-locked" then
        begin
            no_of_reads(X) ← no_of_reads(X) - 1
            if no_of_reads(X) = 0 then
                begin 
                    LOCK(X) ← "unlocked"
                    wakeup one of the waiting transactions, if any
                end
        end
```

## **Funcionamento Detalhado**

### **Caso 1: Liberação de Bloqueio Exclusivo (Escrita)**
```pseudocode
if LOCK (x) = "write-locked" then
    begin 
        LOCK (x) ← "unlocked"  // Libera o bloqueio
        wakeup one of the waiting transactions, if any  // Acorda uma transação em espera
    end
```
- Quando um bloqueio de escrita é liberado:
  - O status do dado volta para `"unlocked"`
  - Se existirem transações esperando, **uma delas é acordada** (prioridade normalmente é FIFO)

### **Caso 2: Liberação de Bloqueio Compartilhado (Leitura)**
```pseudocode
else if LOCK (x) = "read-locked" then
    begin
        no_of_reads(X) ← no_of_reads(X) - 1  // Decrementa contador
        if no_of_reads(X) = 0 then  // Se não há mais leitores
            begin 
                LOCK(X) ← "unlocked"
                wakeup one of the waiting transactions, if any
            end
    end
```
- Para bloqueios de leitura:
  - O contador de leituras é decrementado
  - **Só libera o dado quando o último leitor sai** (`no_of_reads = 0`)
  - Se liberado, acorda uma transação em espera

# **Deadlock (Impasse) em Sistemas de Banco de Dados**

## **Conceito e Causas**
Deadlock ocorre quando duas ou mais transações ficam **mutuamente bloqueadas**, criando um ciclo de dependência onde:
- **T1** espera por um recurso bloqueado por **T2**
- **T2** espera por um recurso bloqueado por **T1**

### **Exemplo Clássico**
| Transação | Bloqueia | Espera por |
|-----------|----------|------------|
| T1        | D1       | D2         |
| T2        | D2       | D1         |

## **Detecção de Deadlock**
### **Grafo de Espera (Wait-for Graph)**
- **Nós**: Transações
- **Arestas**: T1 → T2 (T1 espera por recurso de T2)
- **Deadlock existe** se o grafo contém **ciclos**

![Grafo de Deadlock](https://example.com/deadlock-graph.png)  
*(Ciclo T1→T2→T1 indica deadlock)*

## **Técnicas de Prevenção**

### **1. Timeouts**
- **Como funciona**:  
  Transação espera por tempo pré-definido (ex: 5 segundos)  
  → Se não obtiver recurso, é **abortada automaticamente**  
- **Vantagens**:  
  ✔ Simples de implementar  
  ✔ Baixo overhead computacional  
- **Desvantagens**:  
  ✖ Pode abortar transações sem deadlock  
  ✖ Dificuldade em definir tempo ideal

### **2. Esquemas Baseados em Timestamp**
#### **a) Wait-Die (Espera-Morre)**
- Se **T1 (mais velha)** pede recurso de **T2 (mais nova)**:  
  → T1 **espera**  
- Se **T1 (mais nova)** pede recurso de **T2 (mais velha)**:  
  → T1 é **abortada** ("morre")

#### **b) Wound-Wait (Ferir-Espera)**
- Se **T1 (mais velha)** pede recurso de **T2 (mais nova)**:  
  → T2 é **abortada** ("ferida")  
- Se **T1 (mais nova)** pede recurso de **T2 (mais velha)**:  
  → T1 **espera**

### **Comparação dos Métodos**
| Método       | Transação Mais Nova Solicita Recurso Mais Velha | Transação Mais Velha Solicita Recurso Mais Nova |
|--------------|------------------------------------------------|------------------------------------------------|
| **Wait-Die** | Aborta solicitante                             | Espera                                         |
| **Wound-Wait** | Espera                                        | Aborta detentora                               |

## **Técnicas de Resolução**
Quando deadlock é detectado:
1. **Seleção da Vítima**:  
   - Transação com menor tempo de execução  
   - Transação que modificou menos dados  
2. **Rollback**:  
   - Aborta a transação escolhida  
   - Libera todos seus recursos  
3. **Reinício**:  
   - Transação pode ser reiniciada após delay  

## **Exemplo Prático**
```sql
-- Sessão 1
BEGIN;
UPDATE conta SET saldo = saldo - 100 WHERE id = 1; -- Bloqueia linha 1

-- Sessão 2
BEGIN;
UPDATE conta SET saldo = saldo + 50 WHERE id = 2; -- Bloqueia linha 2
UPDATE conta SET saldo = saldo - 50 WHERE id = 1; -- Espera por Sessão 1

-- Sessão 1 (continuação)
UPDATE conta SET saldo = saldo + 100 WHERE id = 2; -- Espera por Sessão 2 → DEADLOCK!
```
