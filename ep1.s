.global ep1

ep1:
    MOV R1, #0          // Initialize sum to 0
    MOV R2, #0          // Initialize byte counter to 0

loop:
    LDRB R3, [R0, R2]   // Load byte from string
    CMP R3, #0          // Check if it's the null terminator
    BEQ done            // If zero byte, end loop

    AND R4, R2, #1      // Check if byte is odd or even
    CMP R4, #0
    BEQ even_byte

odd_byte:
    MOV R4, R3          // Copy the byte
    MOV R5, #8          // Set 8 iterations for bit count
    MOV R6, #0          // Reset bit counter

count_ones:
    ANDS R7, R4, #1     // Check if the last bit is 1
    ADDNE R6, R6, #1    // If yes, increment bit counter
    LSR R4, R4, #1      // Shift right to get next bit
    SUBS R5, R5, #1     // Decrement iteration counter
    BNE count_ones

    ADD R1, R1, R6      // Add bit count to sum
    B next_byte

even_byte:
    MVN R4, R3          // Invert the byte
    MOV R5, #8          // Set 8 iterations for bit count
    MOV R6, #0          // Reset bit counter

count_zeros:
    ANDS R7, R4, #1     // Check if the last bit is 1 (0 in original byte)
    ADDNE R6, R6, #1    // If yes, increment bit counter
    LSR R4, R4, #1      // Shift right to get next bit
    SUBS R5, R5, #1     // Decrement iteration counter
    BNE count_zeros

    ADD R1, R1, R6      // Add bit count to sum

next_byte:
    ADD R2, R2, #1      // Move to the next byte
    B loop

done:
    MOV R0, R1          // Return the sum
    BX LR
