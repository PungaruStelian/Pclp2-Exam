#include <stdio.h>
#include <stdlib.h>

#include "file.h"

/* TODO a: Find `find` parameters so that calling `find`
 * function will return 0.
 */
void todo_a()
{
	int res;
    // a este inversul lui 0xdead si b este inversul lui 0xbeef
	res = find(0b10000101010010, 0b100000100010000);
	if (!res) 
		printf("a) Perfect! Go on!\n");
	else
		printf("a) Wrong answer. Try again\n");
}


/* TODO b: Read `buf` from standard input so that
 * `check_string` function will return 0.
 */
void todo_b(void) {
	char buf[1000] = {};
	int res;

	scanf("%s", buf);
	res = check_string(buf);
	if (!res)
		printf("b) Perfect! Go on!\n");
	else
		printf("b) Wrong answer. Try again!\n");
}


/* TODO c: Indirectly call `secret` function using `read_string` */
void todo_c()
{
	catch_me();
	printf("c) Wrong answer. Try again!\n");

}