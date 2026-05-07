; === DO-WHILE: Multiplicar del 1 al 10 ===
; Calcula 1*2*3*...*10 = 3628800

section .data
    resultado dq 1          ; variable que guarda el resultado final
    contador dq 1           ; contador del 1 al 10
    limite cmp rcx resul
jg cierto
jmp findq 10            ; valor tope del bucle
    buffer times 20 db 0    ; espacio para convertir numero a texto
    newline db 10           ; salto de linea

section .text
    global _start

_start:
    ; --- Inicializar registros ---
    mov rax, 1              ; acumulador (comienza en 1)
    mov rcx, 1              ; contador (comienza en 1)

    ; === Bucle do-while ===
do_while:
    imul rax, rcx           ; rax = rax * rcx (multiplica acumulador por contador)
    inc rcx                 ; rcx++ (incrementa contador)
    cmp rcx, [limite]       ; compara contador con 10
    jle do_while            ; si contador <= 10, repite el bucle

    mov [resultado], rax    ; guarda el resultado final en memoria

    ; === Convertir numero a texto (decimal a ASCII) ===
    mov rdi, buffer + 19    ; apunta al ultimo byte del buffer
    mov byte [rdi], 10      ; coloca salto de linea al final
    mov rbx, 10             ; divisor para extraer digitos
    dec rdi                 ; retrocede una posicion

convertir:
    xor rdx, rdx            ; limpia rdx antes de dividir
    div rbx                 ; divide rax entre 10 (resultado en rax, resto en rdx)
    add dl, '0'             ; convierte el digito a ASCII
    mov [rdi], dl           ; guarda el digito en el buffer
    dec rdi                 ; retrocede en el buffer
    cmp rax, 0              ; ya no quedan digitos?
    jg convertir            ; si queda numero, continua

    ; === Preparar y ejecutar syscall write ===
    inc rdi                 ; avanza una posicion (ajuste por el ultimo dec)
    mov rsi, rdi            ; rsi apunta al inicio del texto
    mov rdx, buffer + 20    ; calcula longitud del texto
    sub rdx, rsi

    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    syscall                 ; imprime el resultado

    ; === Terminar programa ===
fin:
    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; codigo de salida 0
    syscall
