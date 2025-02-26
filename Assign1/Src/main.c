/**
 ******************************************************************************
 * @project        : CG/[T]EE2028 Assignment 1 Program Template
 * @file           : main.c
 * @author         : Hou Linxin, ECE, NUS
 * @brief          : Main program body
 ******************************************************************************
 *
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */
#include "stdio.h"

#define F 3
#define S 2
#define N 5 //size of entry[] array

extern void asm_func(int* arg1, int* arg2, int* arg3, int* arg4);
extern void initialise_monitor_handles(void);

int main(void)
{
	initialise_monitor_handles();
	int i,j;
	int building[F][S] = {{12,12},{10,5},{3,7}};

	int entry[5] = {1,1,1,1,5};

	int exit[F][S] = {{1,2},{3,4}, {3,6}};
	int params[3] = {F,S,N};

	asm_func((int*)building, (int*)entry, (int*)exit, (int*)params);

	// print result[][]
	printf("RESULT\n");
	for (i=0; i<F; i++)
	{
		for (j=0; j<S; j++)
		{
			printf("%d\t", building[i][j]);
		}
	printf("\n");
	}
}
