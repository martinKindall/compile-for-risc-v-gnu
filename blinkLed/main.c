#include "digital.h"

int main() {

    unsigned int output = 0b11111;
    unsigned int off = 0b0;

    while(1) {
        digitalwrite(output);
        digitalwrite(off);
    }

    return 0;
}
