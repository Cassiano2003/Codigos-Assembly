.data
prompt2: .asciiz "Please enter value: "
array1:  .space 40
array2:  .space 40
buffer:  .space 4
.text

main:

# Prints the prompt2 string
li $v0, 4
la $a0, prompt2
syscall

# Reads one integer from user and saves in t0
li $v0, 5
la $t0, buffer
syscall

li $v0, 1
li $t0, 5       # $integer to print
syscall

exitProgram:    li $v0, 10  # System call to terminate
    syscall                 # the program