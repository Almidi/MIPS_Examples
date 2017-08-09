.data
.globl cdata
.globl cflag
cdata: .space 4
cflag: .space 4
newline: .asciiz "\n"
menu: .asciiz "\nMenu:\nChoice ->1\nChoice -> 2\n[SPACE} -> exit\n"
str1: .asciiz "First choice :\n"
str2: .asciiz "Second Choice :\n"
.text
.globl main

main:

main_loop:
mfc0 $t0,$12			#move from coprocessor 0
ori $t0,$t0,1			#Enabling Interrupts (1st bit of kernel register)
mtc0 $t0,$12			#move to coprocessor 0
lw $t0, 0xffff0000		#read receiver control
ori $t0,$t0,2			#Enabling Interrupts (2nd bit of receiver control)
sw $t0, 0xffff0000
la $t1, cflag
sw $zero, 0($t1)		#clear cflag

li $v0, 4
la $a0, menu
syscall

loop2:							#waiting for cflag to be ready
la $t1, cflag 
lw $t0, 0($t1)
beqz $t0, loop2

la $t1, cdata
lw $t0, 0($t1)					#get character from cdata

li $t2, 49
bne $t0, $t2, else_label_1		#if choice==1
li $v0, 4
la $a0, str1
syscall
j main_loop
else_label_1:
li $t2,50
bne	$t0,$t2,else_label2			#if choice==2
li $v0, 4 
la $a0, str2 
syscall
j main_loop
else_label2:

beq $t0, 32, main_loop_end		#if choice==' ', Exit.
j main_loop
main_loop_end:



li $v0, 10
syscall