; Programa que multiplica dos números enteros de 8 bits
; Muestra el resultado como número (no como cadena)

SECTION .data
    num1 db 5         ; Primer número (puedes cambiarlo)
    num2 db 3         ; Segundo número (puedes cambiarlo)
    mensaje db "El resultado es: ", 0
    salto_linea db 10

SECTION .bss
    resultado resb 1          ; Resultado en 8 bits
    resultado_ascii resb 4    ; Para almacenar cadena ASCII del número

SECTION .text
    global _start

_start:

    ; Mostrar mensaje
    mov eax, 4          ; syscall write
    mov ebx, 1          ; STDOUT
    mov ecx, mensaje
    mov edx, 18         ; Longitud del mensaje
    int 0x80

    ; Cargar números en AL y BL (8 bits)
    mov al, [num1]      ; AL = num1
    mov bl, [num2]      ; BL = num2

    ; Multiplicar AL * BL → resultado queda en AX (AH:AL)
    mul bl              ; AL * BL → resultado en AX

    ; AX tiene el resultado (de 0 a 65535), pero solo usaremos AL
    ; Convertir el número a texto (base 10)

    ; Guardamos AX en EAX para poder dividir
    movzx eax, ax       ; Extiende AX a EAX
    mov ecx, resultado_ascii + 3 ; puntero al final del buffer
    mov byte [ecx], 0   ; Terminador null
    dec ecx

convertir:
    xor edx, edx
    mov ebx, 10
    div ebx             ; EAX / 10, residuo → EDX, cociente → EAX
    add dl, '0'         ; Convertir dígito a ASCII
    mov [ecx], dl       ; Guardar dígito
    dec ecx
    test eax, eax
    jnz convertir

    inc ecx             ; Ajustar puntero al inicio real de la cadena

    ; Imprimir resultado
    mov eax, 4
    mov ebx, 1
    mov edx, resultado_ascii + 4
    sub edx, ecx        ; longitud = (fin - inicio)
    mov ecx, ecx        ; ECX ya apunta al inicio
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
