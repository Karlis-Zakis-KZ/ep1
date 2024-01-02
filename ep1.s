section .text
global ep1

ep1:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Initialize ecx to 0 (this will hold our result)
    xor ecx, ecx

    ; Get the string pointer from the stack
    mov eax, [ebp+8]

    ; Initialize edx to 0 (this will be our byte counter)
    xor edx, edx

loop_start:
    ; Load a byte from the string into bl
    movzx ebx, byte [eax+edx]

    ; Check if we've reached the null terminator
    test bl, bl
    jz end

    ; Increment the byte counter
    inc edx

    ; Check if the byte is odd or even
    test dl, 1
    jz even_byte

odd_byte:
    ; Count the number of set bits in bl and add to ecx
    popcnt ebx, ebx
    add ecx, ebx
    jmp loop_start

even_byte:
    ; Invert the bits in bl, then count the number of set bits and add to ecx
    not bl
    popcnt ebx, ebx
    add ecx, ebx
    jmp loop_start

end:
    ; Move the result into eax (the return register)
    mov eax, ecx

    ; Epilogue
    mov esp, ebp
    pop ebp
    ret
