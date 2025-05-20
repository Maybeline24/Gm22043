section .data
    buffer db '00000', 10    ; buffer de 5 caracteres + salto de línea

section .text
    global _start

_start:
    ; Usar registros de 16 bits para la resta
    mov ax, 50
    sub ax, 20
    sub ax, 10       ; Resultado final: AX = 20

    ; Convertir AX (resultado) a decimal (guardamos en EBX)
    mov bx, ax
    mov ecx, 0             ; contador de dígitos
    mov edi, buffer + 4    ; apuntar al final del número (antes del \n)

.to_ascii:
    xor edx, edx
    mov eax, ebx
    mov ebx, 10
    div ebx                ; divide EAX entre 10 → cociente en EAX, residuo en EDX
    add dl, '0'            ; convierte residuo a carácter ASCII
    mov [edi], dl
    dec edi
    inc ecx
    mov ebx, eax
    test eax, eax
    jnz .to_ascii

    ; Imprimir número
    mov eax, 4            ; syscall write
    mov ebx, 1            ; stdout
    lea ecx, [edi + 1]    ; apuntar al primer carácter
    mov edx, ecx
    add edx, ecx
    sub edx, ecx
    mov edx, ecx
    mov edx, buffer + 5
    sub edx, ecx
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer + 5
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80


