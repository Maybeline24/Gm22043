# Ejercicios en Lenguaje Ensamblador (NASM)

Este repositorio contiene tres ejercicios básicos escritos en lenguaje ensamblador (ASM) utilizando sintaxis NASM, ejecutables en sistemas GNU/Linux. Cada ejercicio implementa una operación aritmética diferente.

## Contenido

- `multiplicacion.asm`: Multiplicación con registros de 8 bits.
- `division.asm`: División con registros de 32 bits.
- `resta3.asm`: Resta entre dos números.

---

## Ejercicio 1: `multiplicacion.asm`

### Descripción
Este programa realiza la multiplicación de dos números enteros de 8 bits usando instrucciones básicas de ensamblador.

### Detalles técnicos
- Registros utilizados: `AL`, `BL`, `AX`.
- Instrucción clave: `MUL BL`
- Resultado almacenado en `AX`.

### Ejemplo
Multiplica 5 × 4, resultado esperado: 20.

---

## Ejercicio 2: `division.asm`

### Descripción
Este programa realiza una división entre dos números enteros de 32 bits.

### Detalles técnicos
- Registros utilizados: `EAX`, `EBX`, `EDX`.
- Instrucción clave: `DIV EBX`
- Resultado (cociente) en `EAX`, residuo en `EDX`.

### Ejemplo
Divide 100 ÷ 25, resultado esperado: 4 (cociente), 0 (residuo).

---

## Ejercicio 3: `resta3.asm`

### Descripción
Este programa efectúa la resta de dos números enteros, mostrando el resultado.

### Detalles técnicos
- Registros utilizados: `AX`, `BX`, `CX`.
- Instrucción clave: `SUB AX, BX`
- Resultado en `AX`.

### Ejemplo
Resta 10 - 7, resultado esperado: 3.

---

## Compilación y Ejecución

```bash
nasm -f elf32 nombre_archivo.asm -o nombre_archivo.o
ld -m elf_i386 nombre_archivo.o -o nombre_archivo
./nombre_archivo
