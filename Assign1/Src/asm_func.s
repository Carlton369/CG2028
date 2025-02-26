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

@ Write Student 1’s Name here:
@ Write Student 2’s Name here:

@ Look-up table for registers:

@ R0 BUILDING
@ R1 ENTRY
@ R2 EXIT
@ R3 RESULT
@ R4 total number of sections
@ DO NOT TOUCH R7

@ write your program from here:

.equ max_cars_per_section, 12

asm_func:
 	PUSH {R14}

	BL SUBROUTINE

 	POP {R14}

	BX LR

SUBROUTINE:
	PUSH {R14}
	//find total cars coming in
	LDR R4, [R3] @load f into r4
	LDR R8, [R3, #4] @load s into r8
	MUL R4, R8 //store total sections in r4
	MOV R5, #0 //init count of cars entering to 0
	MOV R6, #5 //size of entry[]

add_loop:
	LDR R8, [R1], #4 //R8 to store
	ADD R5, R8 //add to total cars

	SUBS R6, #1 //check how many in entry[] left
	BNE add_loop  //checks if flag updated from prev line

	LDR R1, =max_cars_per_section

@ R0 BUILDING
@ R1 max cars per section
@ R2 EXIT
@ R3 RESULT
@ R4 total number of sections, used for iteration
@ R5 number of entering cars
@ R6 used for calculation of value to be put into result[][]
@ DO NOT TOUCH R7
@ R8 used to hold value of cars exiting from section for calculation
@ R10 to store number of cars that can enter in each section
@ R12 total number of sections

handle_day:
	LDR R6, [R0], #4 @use R6 to hold cars in current section for calculation
	SUB R10, R1, R6 @r10 to hold #cars that can enter curr section

	CMP R5, R10
	BGT leftover_cars
	B no_leftover_cars

leftover_cars:
	LDR R8, [R2], #4 @load exiting cars in r8
	SUBS R6, R1, R8
	BMI neg_cars
	STR R6, [R3], #4
	SUB R5, R10
	B go_next_section

neg_cars:
	MOV R6, #0
	STR R6, [R3], #4
	B go_next_section

no_leftover_cars:
	LDR R8, [R2], #4 //load exiting cars from section
	ADD R6, R5 //add current cars with leftover cars
	SUBS R6, R8
	BMI neg_cars
	STR R6, [R3], #4
	MOV R5, #0
	CMP R4, #0
	BEQ end_loop
	B go_next_section

go_next_section:
	@how many sections remaining
	SUBS R4, #1
	BNE handle_day

end_loop:
	POP {R14}
	BX LR
