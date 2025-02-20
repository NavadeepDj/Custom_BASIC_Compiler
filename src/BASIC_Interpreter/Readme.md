# 🚀 BASIC Interpreter (Flex + Bison)

Now that we have a **working lexer (Flex) and parser (Bison)**, let's move to the next step: **executing (interpreting) BASIC code** 🚀.

## 🔹 What We’ve Done So Far
Until now, we have:
- Built a **lexer (Flex)** that converts input into tokens.
- Created a **parser (Bison)** that checks whether the tokens follow correct BASIC syntax.
- Validated input such as `LET X = 10` and `PRINT X`.

But this only checks if the syntax is correct—it does not actually **execute** the code. 

## 🔹 What We’ll Do Now
To make our interpreter functional, we will:
1. **Store variable values** in a symbol table.
2. **Perform assignments** (e.g., `LET X = 10` should store `X = 10`).
3. **Print variable values** (e.g., `PRINT X` should output `10`).

## 🔹 How It Works
### 1️⃣ Storing Variables in a Symbol Table
Since BASIC allows variables from `A` to `Z`, we use an **array** (`symbolTable[26]`) to store values:
- `LET X = 10` → Stores `X = 10` in `symbolTable[X - 'A']`.
- `LET A = 5` → Stores `A = 5` in `symbolTable[A - 'A']`.

### 2️⃣ Executing Assignments
The rule for variable assignment in `syntax.y` ensures that:
- When `LET IDENTIFIER = NUMBER` is encountered, the number is stored in the symbol table.
- The system prints confirmation: `Stored: X = 10`.

### 3️⃣ Printing Variable Values
For `PRINT X`, the parser retrieves and prints the stored value:
- If `X` is assigned, it prints: `X = 10`.
- If `X` is **not assigned**, it prints an **error message**: `ERROR: X is not assigned`.

## 🔹 Running the Interpreter
1. **Compile the Parser and Lexer**:
   ```sh
   bison -d syntax.y
   flex lexical.l
   gcc syntax.tab.c lex.yy.c -o interpreter
   ```
2. **Run the Interpreter**:
   ```sh
   ./interpreter
   ```

## 🔹 Testing the Interpreter
### ✅ Test 1: Assigning and Printing a Variable
#### **Input:**
```
LET X = 10
PRINT X
```
#### **Output:**
```
Stored: X = 10
X = 10
```

### ✅ Test 2: Assigning and Printing Multiple Variables
#### **Input:**
```
LET A = 5
LET B = 15
PRINT A
PRINT B
```
#### **Output:**
```
Stored: A = 5
Stored: B = 15
A = 5
B = 15
```

### ✅ Test 3: Printing an Undefined Variable
#### **Input:**
```
PRINT C
```
#### **Output:**
```
ERROR: C is not assigned
```

✅ **We now have a working BASIC interpreter!**  
