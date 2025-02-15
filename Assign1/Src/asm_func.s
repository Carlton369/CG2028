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



.equ total_sections, 6
.equ max_car_per_section, 12
asm_func:
 	PUSH {R14}

	BL SUBROUTINE

 	POP {R14}

	BX LR

SUBROUTINE:
	PUSH {R14}
	//find total cars coming in
	LDR R4, =total_sections
	STR R4, [R3, #4]
	MOV R5, #0 //init count of cars entering to 0
	MOV R6, #5 //size of entry[]

add_loop:
	LDR R8, [R1], #4 //R7 to store
	ADD R5, R8

	SUBS R6, #1 //check how many in entry[] left
	BNE add_loop  //checks if flag updated from prev line

//	STR R5, [R3, #4] //print statement to check if sum working
//can reuse R6 and R8
	LDR R4, =total_sections //reset count
	PUSH {R3} //STORE STARTING INDEX OF R3
//R1 not being used anymore
@R5 holds total cars entering
//now use R1 to hold val of 12
//and use R6 to hold building
start_day:
	LDR R6, [R0], #4
	STR R6, [R3], #4
	SUBS R4, #1
	BNE start_day

	POP {R3} //RESET ADDRESS CORRECTLY
	PUSH {R3} //STORE INDEX AGAIN

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
	LDR R4, =total_sections
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



