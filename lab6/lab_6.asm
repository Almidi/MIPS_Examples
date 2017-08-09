
.data 

	.globl string_INPUT
	string_INPUT: .space 101
	string_MENU: .asciiz "Give a string to be converted"
	
.text
	.globl main
	main:
	
	la $a0, string_MENU                             # Print Menu 
	jal print_string	                            #
	
	li $a0, 10                                      # Print new line 
	jal write_ch									#
	
	la $a0, string_INPUT							# Input array buffer 
	jal read_string									# Read input
	
	la $a0, string_INPUT 							#load head of buffer	
	jal print_string_cap
	
	li $2, 10  										#EXIT PROGRAM
	syscall
	
	
#----------------------------------------------------READ STRING--------------------------------------------
	
read_string:
	move $t0 , $a0 									
	li $t3 , 0  									# loop counter
	
	 loop_call_of_read_ch:
	
		#############################################
		addi $sp , $sp , -16 						#memory allocation in stack pointer
		sw $ra , 0($sp)								#keep return adress
		sw $t0 , 4($sp)								#keep string head
		sw $t3 , 8($sp)								#keep counter
		#############################################
		
		jal read_ch									#call read_ch function

		#############################################
		lw $ra , 0($sp)								#restore stack  
		lw $t0 , 4($sp)								#
		lw $t3 , 8($sp)								#
		addi $sp , $sp , 16							#delete space in stack pointer
		#############################################
		
		li $t1 , 10									#ASCII 10 = enter button 
		li $t2 , 0 									#ASCII 0
        li $t4 , 100 								#for limit check
		
		sb $v0  , 0($t0)							#store byte from read_ch function in string
		addi $t0 , $t0 , 1 							#move to next string byte 
		addi $t3 , $t3 , 1 							#count++
		
		beq $v0 , $t1 , end_read_ch_case 			#character = enter button (this must be checked first!!)  	#loop exit
		beq $t3 , $t4 , end_read_ch_case 			#end of array												#conditions

		j loop_call_of_read_ch                      #else continue readinf
	end_read_ch_case:
	
	li $t3, 0										#overwrite counter-dont need anymore
	sb $t3 , 0($t0) 								#place 0 in the end	

	jr $ra

#-----------------------------------------------------READ CHARACTER----------------------------------------------------
read_ch:
	
	li $t0 , 1										#in order to check
	li $t1 , 0xffff0000  							#address of Receiver Control 
	
	loop_reciever_control:
		lb $t2 , 0($t1) 							#content of Receiver Control
		and $t3 , $t0 , $t2
	bne $t3, $t0 , loop_reciever_control 			#ready bit != 1
	
	#-------------------ready-----------------------#
	
	li $t4 , 0xffff0004  							#address of Receiver Data
	lb $t5 , 0($t4)									#content of Receiver Data
	
	
	move $v0 , $t5									#return to read string function
	move $a0 , $t5									#passing of parameters
	
	#################################################
	addi $sp,$sp, -4								#create space in stack
	sw $ra, 0($sp)									#save return address
	#################################################
	
	jal write_ch									#call of write_ch in order to print on console the character

	#################################################
	lw $ra, 0($sp)									#restore return address
	addi $sp, $sp, 4								#delete stack extra space
	#################################################
	
	
	jr $ra

#--------------------------------------------------------PRINT CHARACTERS----------------------------------------------
write_ch:
	
	move $t0 , $a0
	li $t1 , 1										#in order to check
	li $t2 , 0xffff0008 							# address of Transmitter Control
	
	
	loop_transmitter_control:
		lb $t3 , 0($t2) 							#content of Transmitter Control
		and $t4 , $t3 , $t1
	bne $t4 , $t1 , loop_transmitter_control 		# ready bit != 1
	
	
	li $t5 , 0xffff000c								#address of Transmitter Data
	sb $t0 , 0($t5)		

	jr $ra

#-------------------------------------------------------PRINT STRING----------------------------------------------------
print_string:

	move $t0,$a0									#address of string
	while_loop:
		lb $t1,0($t0)
		beq $t1,$0,end_while_loop					#check if char is 0
		
		move $a0,$t1								#passing parameters

		#############################################
		addi $sp, $sp, -8							#create space in stack
		sw $ra, 4($sp)								#store return register
		sw $t0, 0($sp)								#store string pointer
		#############################################
		
		jal write_ch								#call function for character printing
		
		#############################################
		lw $t0, 0($sp)								#restore string pointer
		lw $ra, 4($sp)								#restore return register
		addi $sp, $sp, 8							#delete stack space
		#############################################
		
		addi $t0, $t0, 1							#move string pointer
		
		j while_loop
	end_while_loop:	
jr $ra

#-------------------------------------------------------PRINT CAPITAL STRING----------------------------------------------------
print_string_cap:

	move $t0,$a0									##address of string
	while_loop_cap:
	
		lb $t1,0($t0)
		beq $t1,$0,end_while_loop_cap				##check if char is 0
		
		
		#-----------------convertion----------------#
			li $t6 , 97								#
			blt $t1 , $t6 , not_to_convert			#check if it is a low case letter
			li $t6 , 122							#
			bgt $t1 , $t6 , not_to_convert			#
			
			addi $t1, $t1 , -32                     #Capitalize it
			
			not_to_convert:							#
		#-------------------------------------------#
		
		
		
		move $a0,$t1									
		
		#############################################
		addi $sp, $sp, -8							#create space in stack
		sw $ra, 4($sp)								#store return register
		sw $t0, 0($sp)								#store string pointer
		#############################################
		
		jal write_ch								#call function for character printing

		#############################################
		lw $t0, 0($sp)								#restore string pointer
		lw $ra, 4($sp)								#restore return register
		addi $sp, $sp, 8							#delete stack space
		#############################################
		
		addi $t0, $t0, 1							#string pointer ++

		j while_loop_cap
	end_while_loop_cap:	
jr $ra




