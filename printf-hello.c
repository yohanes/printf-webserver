#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
 
#define FUNCTION_ADDR ((uint64_t)hello)
#define DESTADDR 0x0000000000600948
 
void hello()
{
    printf("\n\n\n\nhello world\n\n");
}
 
int main(int argc, char *argv[])
{
    short a= FUNCTION_ADDR & 0xffff;
    short b = (FUNCTION_ADDR >> 16) & 0xffff;
    printf("a = %04x b = %04x\n", a, b);fflush(stdout);
        uint64_t *p = (uint64_t*)DESTADDR;
        printf("before: %08lx\n", *p); fflush(stdout);
    printf("%*c%hn", b, 0, DESTADDR + 2 );fflush(stdout);
        printf("after1: %08lx\n", *p); fflush(stdout);
    printf("%*c%hn", a, 0, DESTADDR);fflush(stdout);
        printf("after2: %08lx\n", *p); fflush(stdout);
    return 0;
}
