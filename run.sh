rm *.o
rm *.out
echo "Assemble triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
echo "Compile pythagoras.c"
gcc -c -Wall -m64 -no-pie -o pythagoras.o pythagoras.c -std=c11
echo "Link the two 'O' files triangle.o and pythagoras.o"
gcc -m64 -std=c11 -o pythagoras.out triangle.o pythagoras.o -fno-pie -no-pie

echo "Next the program 'Pythagoras' will run"
./pythagoras.out
