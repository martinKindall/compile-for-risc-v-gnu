#include "headers.h"

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
    unsigned short result = multiplicationAndSum(a, b);  // 11_362

    printshort(result);
    println("Hola porotita :)");

    return 0;
}
