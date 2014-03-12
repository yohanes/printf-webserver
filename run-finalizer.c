#include <stdlib.h>
#include <stdio.h>
 
#define ADDR 0x00000000600720
 
void hello()
{
        printf("hello world\n");
}
 
int main(int argc, char *argv[])
{
        (*((unsigned long int*)ADDR))= (unsigned long int)hello;
}
