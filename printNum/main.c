#include "codigo_morsa.h"


int powerSum(int n1, int n2) {
    return n1 * n1 + n2 * n2;
}

int multiplicationAndSum(int n1, int n2) {
    int temp = powerSum(n1, n2);
    
    return n1 * n2 + powerSum(temp, n2);
}

int main() {

    unsigned short a = 5;
    unsigned short b = 9;
    unsigned short result = multiplicationAndSum(a, b);

    printshort(result);

    while(1) {
        digitalwrite(0b11111);
        delay(25);
        digitalwrite(0b0);
        delay(25);
    }

    return 0;
}
