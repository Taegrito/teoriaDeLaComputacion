# Booleanos

## Authors
- Sara Arboleda Quintero
- Ana Isabella Gómez García
- Manuela Carolina López Arroyave

## Environment and tools
- **Operating System:** Windows 10
- **Compiler:** Ghc y Ghci 9.10.2
- **Tools:** Visual Studio Code 1.103.1, playHaskell 9.10.2
## How to run the solution
1. Clone the repository
    ```bash
   git clone https://github.com/Taegrito/teoriaDeLaComputacion.git
   cd teoriaDeLaComputacion

2. Compile the Haskell file
    ghc -o main main.hs
    ./main      # Linux / macOS
    main.exe    # Windows

3. Or run in ghc
    ghci main.hs
    > main

4. Expected Output
    true AND false = False
    true OR false = True
    NOT true = False
    NOT false = True
    ifThenElse true "yes" "no" = yes
    ifThenElse false "yes" "no" = no

## Detailed explanation of the solution
First of all, we are going to build the following logical operators directly using λ-calculus
expressions:
K ≡ λx. λy. x (First projection combinator) Taken as true
K* ≡ λx. λy. y (Second projection combinator) Taken as false
IfThenElse
IfThenElse ≡ λb.λx.λy.bxy
**Reasoning:**
The ifThenElse operation works by taking a condition and returning the first value if the
condition is true, or the second value if the condition is false. Thus, applying a Church
boolean determines whether the first or second argument is returned.
AND
AND ≡ (λp.(λq.((p q)K*)))
≡ λp.λq.((p q)(λx. λy. y))
**Reasoning:**
According to logic, AND is only true when both conditions are true. In this function, p is
evaluated first. If p is false, the whole expression immediately returns false (using K*) without
evaluating q. If p is true, then q is evaluated, and its value determines the result. This
ensures that the AND operation only returns true if both p and q are true.
OR
OR ≡ (λp.(λq.((p K) q)))
≡ λp.λq.((p (λx. λy. x)) q)
**Reasoning:**
According to logic, OR is true when at least one of the conditions is true. In this function, p is
evaluated first. If p is true, the entire expression immediately returns true (Using K). If p is
false, then q is evaluated, and its value determines the result.
NOT
NOT ≡ (λp.((p K*) K))
≡ λp.((p (λx. λy. y)) (λx. λy. x))
**Reasoning:**
According to logic, NOT inverts the value of a condition. If p is true, it selects the first
argument (K*), which evaluates to false. If p is false, it selects the second argument (K),
which evaluates to true. In this way, the expression correctly inverts the input value.
Next, in Haskell, we cannot directly use λ-calculus, so we define the same ideas as
Church-encoded Booleans, where:
\ replaces λ
-> replaces .
Therefore, we define the variables for true and false, to avoid using Native Booleans
true = \x y -> x
false = \x y -> y
After defining true and false as Church Booleans, we can build the logical expressions
(ifThenElse, AND, OR and NOT) entirely in terms of Church encoding.
ifThenElse
ifThenElse :: (a -> a -> a) -> a -> a-> a
ifThenElse = \b x y -> b x y
Where:
b is a Church boolean
x is the value of the Then branch
y is the value of the Else branch
AND
churchAnd :: (a -> a -> a) -> (a -> a ->a) -> a -> a -> a
churchAnd = \p q -> p q false
Where:
p and q are Church booleans
If p is true: result is q
If p is false: result is false
OR
churchOr :: (a -> a -> a) -> (a -> a ->a) -> a -> a -> a
churchOr -> \p q -> p true q
Where:
p and q are Church booleans
If p is true: result is true
if p is false: result is q
NOT
churchNot :: (a -> a -> a) -> a -> a -> a
churchNot -> \p -> p false true
Where:
p is a Church boolean
If p is true: result is false
If p is false: result is true
## References
- OpenDSA. (s.f.). Church numerals and Booleans.
    https://opendsa-server.cs.vt.edu/ODSA/Books/PL/html/ChurchNumerals.html
- Ramírez, S. (2025). Teoría de la Computación: Lambda Cálculo. Área Ciencias
- Fundamentales. Escuela de Ciencias Aplicadas e Ingeniería.
    https://drive.google.com/drive/folders/1IA5Ww4L6VI26FLAycBnodXqX-apWDO36
- This work consulted the AI model ChatGPT (OpenAI, 2025) and the AI model Gemini

(Google, 2025) for guidance on implementing Church Booleans and logical operators.
