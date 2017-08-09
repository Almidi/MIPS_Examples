
.data
.globl askint
.globl repint
askint: .asciiz "1) Create List \n2) Insert List Node \n3) Delete First Node \n4) Print Node's Value \n5) Print Node Quantity \n6) Print Node's Location \n7) Print Head Location \n8) Print Node's Detailed Location \n9) Print List Size \n10) Print Node Size \n11) Print Function Pointer Locations  \n12) Exit \n Option : "
repint: .asciiz "Entered value is : "
newline: .asciiz "\n"
.text
.globl main

main:

# Print menu :
li $v0, 4                               # 4 is the code to print a string
la $a0, askint                          # a0 is the pointer to the string to print and gets the value from "variable" askint
syscall

# Read in the integer
li  $v0, 5                              # 5 is the code to read an integer
syscall                                 # result is placed in $v0

# Integer is stored in $t0
move $t0 , $v0


# Print selected numer(first text)
li $v0, 4                               # 4 is the code to print a string
la $a0, repint                          # string to print is in "variable" repint
syscall

# Print selected number
li  $v0, 1                              # 1 is the code for print integer
move $a0, $t0                           # a0 receives integer to be printed
syscall

# Print a newline
li  $v0, 4                              # print integer
la  $a0, newline                        # string to print is in "variable" newline
syscall

bne $t0, 12, main

# Exit
li  $v0, 10
syscall