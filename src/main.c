#include <stdio.h>
#include "sum.h"


static int test = 0xABFF;

void kek()
{
    test++;
}

int main()
{
	int kek_ = sum(10, 15);
	test += kek_;
	while (1)
    {
        //printf("\x0C");
	    test += 1;
        kek();
        //printf("test: %d\n", test);
    }
}