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
;  Program name: Hello
;  Date program began 9-29-2021
;  Date program completed
;
; Purpose
;  This program will utilize basic I/O functions
;
; Project information
;  Files: welcome.cpp, hello.asm, run.sh
;  Status:
;
; Translator information
;  Gnu compiler: g++ -c -m64 -Wall -l welcome.lis -o welcome.o welcome.cpp
;
; Execution: ./welcome.out
;
; *****Code area*****

extern printf
extern scanf
extern fgets
extern stdin
extern strlen
global hello      ;makes hello_world callable by functions outside of file
max_name_size equ 32


segment .data
  ; Lay out prompts and responses for conversation

  align 16
  initial_message db "Hello there. ", 0
  prompt_names_message db "Please enter your full name: ", 0
  prompt_title_message db "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): ", 0
  hello_message db "Hello %s %s, what is your favorite color?", 0
  color_response_message db "%s is a great color.", 10, 0
  goodbye_message db "It was nice to meet you.", 10, 0

  stringformat db "%s", 0   ;%s means any string


segment .bss
  ; Reserve memory sizes for user input

  name resb max_name_size
  title resb 16
  color resb 16

segment .text
  ; Executable instructions in this segment

hello:
  ; Entry point. Execution begins

  ; Prologue. Backup GPRs. 15 pushes
  push rbp
  mov rbp, rsp
  push rbx
  push rcx
  push rdx
  push rdi
  push rsi
  push r8
  push r9
  push r10
  push r11
  push r12
  push r13
  push r14
  push r15
  pushf

  ; Show initial message
  xor rax, rax              ; optimized version of zeroing out register (mov rax, 0)
  mov rdi, stringformat
  mov rsi, initial_message
  call printf

  ; Prompt for full name
  xor rax, rax
  mov rdi, stringformat
  mov rsi, prompt_names_message
  call printf

  ; Obtain user's name
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

  ; Prompt for title
  xor rax, rax
  mov rdi, stringformat
  mov rsi, prompt_title_message
  call printf

  ; Obtain title
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


  ; Greet user and prompt for color
  xor rax, rax
  mov rdi, hello_message
  mov rsi, title
  mov rdx, name
  call printf

  ; Obtain color
  xor rax, rax
  mov rdi, color
  mov rsi, 16
  mov rdx, [stdin]
  call fgets
  xor rax, rax
  mov rdi, color
  call strlen
  mov r14, rax
  xor rax, rax
  mov [color + r14 - 1], rax

  ; Respond to color
  xor rax, rax
  mov rdi, color_response_message
  mov rsi, color
  call printf

  ; Goodbye message
  xor rax, rax
  mov rdi, stringformat
  mov rsi, goodbye_message
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
