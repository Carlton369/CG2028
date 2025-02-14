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

asm_func:
 	PUSH {R14}

	BL SUBROUTINE

 	POP {R14}

	BX LR

SUBROUTINE:
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

	STR R5, [R3, #4]
//can reuse R6-7
	BX LR //RETURN TO ASM_FUNC


