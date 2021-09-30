; ****************************************************************************************************************************
; Program name: "Hello Program".  This program demonstrates how to input and output a string with embedded white  *
; space.  Copyright (C) 2021  Erick Tran                                                                                 *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
; ****************************************************************************************************************************
;
; Author information
;  Author name: Erick Tran
;  Author email: ericktran@csu.fullerton.edu
;
; Program information
;  Program name: Right Triangles
;
; Purpose
;  This program is practice for managing I/O of 64-bit float numbers, and does
;  some calculations for the attributes of a right triangle
;
; Project information
;  Files: pythagoras.c, triangle.asm, run.sh
;
; This file:
;  File name: triangle.asm
;  Language : x86 Assembly
;  Compile: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;  Link: gcc -m64 -no-pie -o pythagoras.out -std=c11 pythagoras.o triangle.o
;
; *****Code area*****

extern printf
extern scanf
extern fgets
extern stdin
extern strlen
global triangle      ;makes hello_world callable by functions outside of file
max_name_size equ 32
two_point_zero equ 0x4000000000000000  ; 2.0 float value to use for calculating area


segment .data

  align 16
  prompt_ln_msg db "Please enter your last name: ", 0
  prompt_title_msg db "Please enter your title (Mr, Mrs, Nurse, Engineer, etc): ", 0
  prompt_triangle_sides_msg db "Please enter the sides of your triangle separated by white space: ", 10, 0
  response_area_msg db "The area of this triangle is %1.18lf square units.", 10, 0
  response_hypotenuse_msg db "The length of the hypotenuse is %1.18lf units.", 10, 0
  exit_msg db "Please enjoy your triangles %s %s.", 10, 0

  stringformat db "%s", 0           ;general string format

  eight_byte_format db "%lf", 0     ;general 8-byte float format


segment .bss

  align 64
  backuparea resb 832
  name resb max_name_size
  title resb 16

segment .text

triangle:

  ; Prologue, backup all GPRs
  push rbp
  mov rbp, rsp
  push rbx
  push rcx
  push rdx
  push rsi
  push rdi
  push r8
  push r9
  push r10
  push r11
  push r12
  push r13
  push r14
  push r15
  pushf

  ; Prompt user for last name
  xor rax, rax
  mov rdi, stringformat
  mov rsi, prompt_ln_msg
  call printf

  ; Get user last name
  xor rax, rax
  mov rdi, name
  mov rsi, max_name_size
  mov rdx, [stdin]
  call fgets
  xor rax, rax
  mov rdi, name
  call strlen
  mov r14, rax
  xor rax, rax
  mov [name + r14 - 1], rax

  ; Prompt user for title
  xor rax, rax
  mov rdi, stringformat
  mov rsi, prompt_title_msg
  call printf

  ; Get user title
  xor rax, rax
  mov rdi, title
  mov rsi, 16
  mov rdx, [stdin]
  call fgets
  xor rax, rax
  mov rdi, title
  call strlen
  mov r14, rax
  xor rax, rax
  mov [title + r14 - 1], rax

  ; Prompt user for sides of triangle separated by whitespace
  xor rax, rax
  mov rdi, stringformat
  mov rsi, prompt_triangle_sides_msg
  call printf

  ; Get floating point numbers from input and store in xmm0 and xmm1
  push qword 0
  push qword 0
  mov rdi, eight_byte_format
  mov rsi, rsp
  call scanf
  movsd xmm10, [rsp]
  pop rax
  pop rax

  ; push qword 0
  ; xor rax, rax
  ; mov rdi, eight_byte_format
  ; mov rsi, rsp
  ; call scanf
  ; movsd xmm11, qword[rsp]
  ; pop rax

  ; Test printf
  push qword 0
  movsd [rsp], xmm10
  mov rax, 1
  mov rdi, eight_byte_format
  call printf

  ; xor rax, rax
  ; push qword 0
  ; movsd [rsp], xmm1
  ; mov rax, 1
  ; mov rdi, eight_byte_format
  ; call printf

  ; Calculate area
  ;   Divide first leg by 2
  ; movsd xmm2, xmm0
  mov r13, qword two_point_zero
  cvtsi2sd xmm15, r13
  divsd xmm13, xmm15
  movsd xmm3, [rsp]
  pop rax
  ;   Multiply first leg by second leg
  movsd xmm4, xmm1
  mulsd xmm4, xmm3
  pop rax
  ;   Save a copy of result before calling printf
  push qword 0          ;reserves 8 bytes of storage
  movsd [rsp], xmm4     ;backup placed in reserved storage
  ;   Show result
  mov rax, 1
  mov rdi, response_area_msg
  call printf

  ; Calculate hypotenuse
  ;fld xmm0, qword[xmm11]
  ;fsqrt
  ;fstp qword[xmm11]

  ; save value of hypotenuse to xmm0 at end
  ; movsd xmm0, some other xmm

  ; Exit message
  xor rax, rax
  mov rdi, exit_msg
  mov rsi, title
  mov rdx, name
  call printf

  ;**Restore pointer to start of stack frame**

  ; Epilogue. Restore data to values held before this function was called
  popf
  pop r15
  pop r14
  pop r13
  pop r12
  pop r11
  pop r10
  pop r9
  pop r8
  pop rsi
  pop rdi
  pop rdx
  pop rcx
  pop rbx
  pop rbp   ; Restore base pointer of stack frame of the caller

  ret
