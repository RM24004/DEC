section .text
global _start

_start:
    mov rax, 5     ; rax = 5
    mov rbx, 3     ; rbx = 3
    add rax, rbx   ; rax = rax + rbx

    mov rax, 60    ; syscall exit
    xor rdi, rdi
    syscall
