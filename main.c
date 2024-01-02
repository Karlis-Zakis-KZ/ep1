#include <stdio.h>
#include <stdlib.h>
#include "ep1.h"


int main() {
    // Test strings
    char str1[] = "ABCD";
    char str2[] = "1234";

    // Call the assembly function and print the results
    int result1 = ep1(str1);
    printf("The result for 'ABCD' is %d\n", result1);  // Expected output: 15

    int result2 = ep1(str2);
    printf("The result for '1234' is %d\n", result2);  // Expected output: 16

    return 0;
}