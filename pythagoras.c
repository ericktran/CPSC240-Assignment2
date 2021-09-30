// ****************************************************************************************************************************
// Program name: "Hello Program".  This program demonstrates how to input and output a string with embedded white  *
// space.  Copyright (C) 2021  Erick Tran                                                                                 *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
// version 3 as published by the Free Software Foundation.                                                                    *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
// ****************************************************************************************************************************
//
// Author information
//  Author name: Erick Tran
//  Author email: ericktran@csu.fullerton.edu
//
// Program information
//  Program name: Right Triangles
//
// Purpose
//  This program is practice for managing I/O of 64-bit float numbers, and does
//  some calculations for the attributes of a right triangle
//
// Project information
//  Files: pythagoras.c, triangle.asm, run.sh
//
// This file:
//  File name: pythagoras.c
//  Language : C
//  Compile: gcc -c -m64 -Wall -l -no-pie -o pythagoras.o pythagoras.c -std=c11
//  Link: gcc -m64 -no-pie -o pythagoras.out -std=c11 pythagoras.o triangle.o
//
// *****Code area*****

#include <stdio.h>
#include <stdint.h>

float triangle();

int main(){
  double result_code = -1;
  printf("Welcome to the Right Triangles program created by Erick Tran\n");
  result_code = triangle();
  printf("%s%f\n", "The main received this float: ", result_code);
  printf("An integer zero will be return to the OS. Bye.\n");
  return 0;
}
