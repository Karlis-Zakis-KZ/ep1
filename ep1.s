section .text
global ep1

ep1:
    push rbp                ; Save base pointer
    mov rbp, rsp            ; Set base pointer
    mov rdi, [rbp+16]       ; Get the pointer to the string (1st argument)
    xor rcx, rcx            ; Clear rcx, to be used for sum

count_loop:
    movzx rax, byte [rdi]   ; Load next byte from the string
    test rax, rax           ; Check if it's the zero terminator
    jz end_loop             ; If zero terminator, end loop

    mov rdx, rax            ; Copy the byte to rdx
    and rax, 1              ; Check if the current byte position is odd or even
    jnz count_ones          ; If odd, count ones

    xor rax, 0xFF           ; Invert bits for even bytes to count zeroes
count_ones:
    popcnt rax, rax         ; Count the number of ones in rax
    add rcx, rax            ; Add the count to the checksum

    inc rdi                 ; Move to the next byte
    jmp count_loop

end_loop:
    mov rax, rcx            ; Move the sum to rax (return value)
    pop rbp                 ; Restore base pointer
    ret                     ; Return
