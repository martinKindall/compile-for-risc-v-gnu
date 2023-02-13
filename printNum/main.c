#include "codigo_morsa.h"

int main() {

    unsigned short a = 750;
    unsigned short b = 10;
    unsigned short result = a * b;

    printshort(result);

    while(1) {
        digitalwrite(0b11111);
        delay(25);
        digitalwrite(0b0);
        delay(25);
    }

    return 0;
}
