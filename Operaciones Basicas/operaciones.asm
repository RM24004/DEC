section .data
    num1 dq 10
    num2 dq 5

    msg_suma db "Suma: "
    len_suma equ $ - msg_suma

    msg_resta db "Resta: "
    len_resta equ $ - msg_resta

    msg_multi db "Multiplicacion: "
    len_multi equ $ - msg_multi

    msg_div db "Division: "
    len_div equ $ - msg_div

section .bss
    buffer resb 20

section .text
    global _start

_start:

; ================== SUMA ==================
    mov rax, [num1]
    add rax, [num2]
    call convertir

    mov rbx, rsi   ; guardar puntero número
    mov rcx, rdx   ; guardar longitud

    mov rsi, msg_suma
    mov rdx, len_suma
    call print

    mov rsi, rbx
    mov rdx, rcx
    call print

; ================== RESTA ==================
    mov rax, [num1]
    sub rax, [num2]
    call convertir

    mov rbx, rsi
    mov rcx, rdx

    mov rsi, msg_resta
    mov rdx, len_resta
    call print

    mov rsi, rbx
    mov rdx, rcx
    call print

; ================== MULTIPLICACION ==================
    mov rax, [num1]
    imul rax, [num2]
    call convertir

    mov rbx, rsi
    mov rcx, rdx

    mov rsi, msg_multi
    mov rdx, len_multi
    call print

    mov rsi, rbx
    mov rdx, rcx
    call print

; ================== DIVISION ==================
    mov rax, [num1]
    mov rbx, [num2]
    cqo
    idiv rbx
    call convertir

    mov rbx, rsi
    mov rcx, rdx

    mov rsi, msg_div
    mov rdx, len_div
    call print

    mov rsi, rbx
    mov rdx, rcx
    call print

; salir
    mov rax, 60
    xor rdi, rdi
    syscall

; =========================================
; CONVERTIR número en rax → texto
; =========================================
convertir:
    mov rcx, 10
    lea rdi, [buffer + 19]
    mov byte [rdi], 10

convert_loop:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz convert_loop

    mov rsi, rdi
    mov rdx, buffer + 20
    sub rdx, rsi
    ret

; =========================================
; PRINT
; =========================================
print:
    mov rax, 1
    mov rdi, 1
    syscall
    ret
