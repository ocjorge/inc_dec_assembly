; Programa que cuenta de 1 a 5 (usando INC) y luego de 5 a 1 (usando DEC)
; Para compilar: 
;   nasm -f elf32 -o contador.o contador.asm
;   ld -m elf_i386 -o contador contador.o
; Para ejecutar:
;   ./contador

section .data
    msg1 db "Contando hacia arriba (INC):", 10, 0
    msg1_len equ $ - msg1
    
    msg2 db 10, "Contando hacia abajo (DEC):", 10, 0
    msg2_len equ $ - msg2
    
    espacio db " ", 0
    newline db 10, 0
    
section .bss
    contador resb 1     ; Variable para nuestro contador
    valor_ascii resb 1  ; Variable para almacenar el valor ASCII

section .text
    global _start

_start:
    ; ---- Mostrar mensaje inicial (contando hacia arriba) ----
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg1
    mov edx, msg1_len
    int 80h
    
    ; ---- CONTADOR ASCENDENTE (1 a 5) usando INC ----
    mov byte [contador], 1    ; Inicializar contador en 1
    
bucle_ascendente:
    ; Mostrar valor actual del contador
    mov al, [contador]
    add al, '0'         ; Convertir a ASCII
    mov [valor_ascii], al
    
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, valor_ascii
    mov edx, 1
    int 80h
    
    ; Mostrar espacio
    mov eax, 4
    mov ebx, 1
    mov ecx, espacio
    mov edx, 1
    int 80h
    
    ; Incrementar contador
    inc byte [contador]
    
    ; Comprobar si hemos llegado a 6
    cmp byte [contador], 6
    jl bucle_ascendente   ; Si es menor que 6, seguir el bucle
    
    ; ---- Mostrar mensaje para contar hacia abajo ----
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_len
    int 80h
    
    ; ---- CONTADOR DESCENDENTE (5 a 1) usando DEC ----
    mov byte [contador], 5    ; Inicializar contador en 5
    
bucle_descendente:
    ; Mostrar valor actual del contador
    mov al, [contador]
    add al, '0'         ; Convertir a ASCII
    mov [valor_ascii], al
    
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, valor_ascii
    mov edx, 1
    int 80h
    
    ; Mostrar espacio
    mov eax, 4
    mov ebx, 1
    mov ecx, espacio
    mov edx, 1
    int 80h
    
    ; Decrementar contador
    dec byte [contador]
    
    ; Comprobar si hemos llegado a 0
    cmp byte [contador], 0
    jg bucle_descendente  ; Si es mayor que 0, seguir el bucle
    
    ; Mostrar nueva línea final
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    
    ; Salir del programa
    mov eax, 1          ; syscall exit
    xor ebx, ebx        ; código de salida 0
    int 80h