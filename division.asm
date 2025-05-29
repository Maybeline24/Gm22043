; Programa en NASM que divide dos números de 32 bits
; y muestra el cociente (resultado) como número decimal

section .data
    dividendo  dd 100        ; Número a dividir
    divisor    dd 4          ; Número que divide
    mensaje    db "El resultado de la division es: ", 0
    salto_linea db 10

section .bss
    resultado_ascii resb 16  ; Para almacenar el resultado como texto

section .text
    global _start

_start:

    ; Mostrar mensaje
    mov eax, 4              ; syscall write
    mov ebx, 1              ; STDOUT
    mov ecx, mensaje        ; Mensaje inicial
    mov edx, 31             ; Longitud del mensaje
    int 0x80

    ; Cargar números en registros de 32 bits
    mov eax, [dividendo]    ; EAX = número a dividir
    xor edx, edx            ; Limpiar EDX antes de división (importante)
    mov ebx, [divisor]      ; EBX = divisor
    div ebx                 ; EAX = EAX / EBX ; resultado → EAX, residuo → EDX

    ; Convertir resultado (en EAX) a ASCII para mostrarlo
    mov ecx, resultado_ascii + 15  ; apuntar al final del buffer
    mov byte [ecx], 0              ; terminar cadena con null
    dec ecx

convertir:
    xor edx, edx
    mov ebx, 10
    div ebx                 ; EAX / 10 → EAX=cociente, EDX=residuo
    add dl, '0'             ; Convertir residuo a caracter ASCII
    mov [ecx], dl
    dec ecx
    test eax, eax
    jnz convertir

    inc ecx                 ; Ajustar puntero al inicio real del número

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov edx, resultado_ascii + 16
    sub edx, ecx            ; Longitud del número
    mov ecx, ecx            ; ECX apunta al resultado
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
