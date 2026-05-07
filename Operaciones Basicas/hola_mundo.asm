section .data
    msg db "Hola Mundo", 0xA
    len equ $ - msg

section .text
    global _start

_start:
    ; syscall write(1, msg, len)
    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
    mov rsi, msg    ; message
    mov rdx, len    ; length
    syscall

    ; syscall exit(0)
    mov rax, 60     ; sys_exit
    xor rdi, rdi    ; status 0
    syscall
