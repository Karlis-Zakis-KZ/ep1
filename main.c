#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ep1.h"

#define BUF_SIZE 1024

char* read_from_stdin() {
    char buffer[BUF_SIZE];
    size_t contentSize = 1;
    char *content = malloc(sizeof(char) * BUF_SIZE);
    if (content == NULL) {
        exit(1);
    }
    content[0] = '\0';

    while (fgets(buffer, BUF_SIZE, stdin)) {
        char *old = content;
        contentSize += strlen(buffer);
        content = realloc(content, contentSize);
        if (content == NULL) {
            free(old);
            exit(2);
        }
        strcat(content, buffer);
    }

    return content;
}

int main() {
    // Test strings

    char *content = read_from_stdin();

    // Call the assembly function and print the results
    int result1 = ep1(content);
    printf("The result for 'ABCD' is %d\n", result1);  // Expected output: 15

    //int result2 = ep1(str2);
    //printf("The result for '1234' is %d\n", result2);  // Expected output: 16

    return 0;
}
/*
EP1 (mop-en)
Design a function written in Assembly that can be called from "C"
int ep1(char *str)
The function has one parameter: a string that is zero terminated (the last byte of the string is followed by a zero byte 0x00 ). The function calculates a checksum for the string str as follows. It counts:
 - one-bits in every odd byte and
 - zero-bits in every even byte of the string,
not counting the terminating zero byte. The return value of the function is the sum of all counted zeroes and ones.
For example, if the string has 4 bytes and the terminating zero byte, and every odd byte is Oxff (all ones), and every even byte has a value of 0x08 (one 1 and seven O's), then the result would be 30: 16 ones plus 14 zeroes. However, if all bytes are all ones, then the return value should be 16.
*/