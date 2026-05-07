section .data
    a dq 15
    b dq 10

    msg_a db "a es mayor que b", 0xA
    len_a equ $ - msg_a

    msg_b db "b es mayor o igual a a", 0xA
    len_b equ $ - msg_b

section .text
    global _start

_start:
    mov rax, [a]
    cmp rax, [b]
    jg a_es_mayor

    ; b es mayor o igual
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_b
    mov rdx, len_b
    syscall
    jmp fin

a_es_mayor:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_a
    mov rdx, len_a
    syscall

fin:
    mov rax, 60
    xor rdi, rdi
    syscall
