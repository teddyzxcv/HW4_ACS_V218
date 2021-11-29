# makefile for perimeter.asm
task: main.c input.c inrnd.c output.c function_sort.o
	gcc -g -o task main.c input.c inrnd.c output.c function_sort.o -no-pie
function_sort.o: function_sort.asm
	nasm -f elf64 -g -F dwarf function_sort.asm -l function_sort.lst
