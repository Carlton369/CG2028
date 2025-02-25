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
@ DO NOT TOUCH R7
@ R10 to store number of cars that can enter in each section
@ R12 total number of sections

handle_day:
	LDR R6, [R0] @use R6 to hold cars in current section for calculation
	SUB R10, R1, R6 @r10 to hold #cars that can enter curr section

	CMP R5, R10
	BGT leftover_cars
	B no_leftover_cars

leftover_cars:
	LDR R9, [R2] @load exiting cars in r9
	SUB R8, R1, R9
	STR R8, [R3]
	SUB R5, R10
	B go_next_section

no_leftover_cars:
	LDR R9, [R2] //load exiting cars from section
	ADD R6, R5 //add current cars with leftover cars
	SUB R6, R9
	STR R6, [R3]
	MOV R5, #0
	CMP R4, #0
	BEQ end_loop
	B go_next_section

go_next_section:
	@iterate to next index in loops
	ADD R0, #4
	ADD R2, #4
	ADD R3, #4
	@how many sections remaining
	SUBS R4, #1
	BNE handle_day

end_loop:
	POP {R14}
	BX LR
	/*
park_cars:
	LDR R1, =max_car_per_section
	LDR R0, [R3] //add first num in R0
	//SUB R1, R6 //R1 now has number of cars that can fit
	//branch here if remainder is greater than or less than entering cars
	ADD R0, R5 //TRIES TO PARK ALL ENTERING CARS INTO THE CURRENT SECTION
	CMP R1, R0 //CHECK IF OVER LIMIT
	BGT no_leftover_cars

	SUB R5, R0, R1 //FINDS HOW MANY CARS CANNOT FIT
	STR R1, [R3], #4 //MAXES OUT THE CURRENT SECTION AND MOVE TO NEXT

	// REST CAN FIT IN CURRENT SECTION
	//INCREMENT INDEX FOR BOTH BUILDING AND RESULT
	BNE park_cars

no_leftover_cars:
	LDR R1, [R3]
	ADD R5, R1
	STR R5, [R3]
	POP {R3}
	MOV R4, R12
	 //RETURN TO ASM_FUNC

//@R0 now used to store value in each section of result to check which one leaving
//@R1 used to store value of no.of leaving cars per section
leave_cars:
	LDR R0, [R3]
	LDR R1, [R2], #4
	SUB R0, R1

	STR R0, [R3], #4 //STORE NEW VAL BACK INTO RESULT[]

	SUBS R4, #1
	BNE leave_cars

	BX LR

*/

