/*
 * asm_func.s
 *
 *  Created on: 7/2/2025
 *      Author: Hou Linxin
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global asm_func

@ Start of executable code
.section .text

@ CG/[T]EE2028 Assignment 1, Sem 2, AY 2024/25
@ (c) ECE NUS, 2025

@ Write Student 1’s Name here: Ng Weiliang
@ Write Student 2’s Name here: Yee Zhan Xian Carlton

@ Look-up table for registers:

@ R0 BUILDING
@ R1 ENTRY, reused to hold max cars per section
@ R2 EXIT
@ R3 RESULT
@ R4 total number of sections, used for iteration
@ R5 number of entering cars to be parked
@ R6 used for calculation of value to be put into result[][]
@ R7 used to hold value of cars exiting from section for calculation

@ write your program from here:

.equ max_cars_per_section, 12

asm_func:
 	PUSH {R4-R7, R14} //rest should be untouched
	//find total cars coming in
	LDR R4, [R3] @load f into r4
	LDR R5, [R3, #4] @load s into r5
	MUL R4, R5 //store total sections in r4
	MOV R5, #0 //init count of cars entering to 0
	LDR R6, [R3, #8] //size of entry[]

add_loop:
	LDR R7, [R1], #4 //R7 to store
	ADD R5, R7 //add to total cars

	SUBS R6, #1 //check how many in entry[] left
	BNE add_loop  //checks if flag updated from prev line

	LDR R1, =max_cars_per_section

handle_day:
	LDR R6, [R0], #4 @use R6 to hold cars in current section for calculation
	LDR R7, [R2], #4 @load exiting cars from section
	SUB R6, R1, R6 @r6 to hold #cars that can enter curr section

	CMP R5, R6 //check if got excess cars
	ITT GE //got excess cars or just nice
		SUBGE R5, R6 //subtract from sum of unparked cars
		MOVGE R6, R1 //make r6 max cars

	ITTT LT //rest can fit
		SUBLT R6, R1, R6 //make r6 hold cars alr parked
		ADDLT R6, R5 //find total #cars now parked
		MOVLT R5, #0

	//at this point R6 should either 12 or number of cars needed to park
	SUBS R6, R7 //exit
	IT MI
		MOVMI R6, #0 //set to 0 to prevent underflow

	STR R6, [R3], #4
	SUBS R4, #1
	BNE handle_day

	POP {R4-R7,R14}
	BX LR
