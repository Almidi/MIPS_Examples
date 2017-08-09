.data

    	tab: .asciiz"  "

	Array: .word 4, 14, 30 , 7 ,22 ,67, 45, 89, 12, 34 , 21
	
	
.text

main: 

	la $s0, Array
	li $s1 , 11 
	
	move $a0 , $s0
	move $a1 , $s1
	
	jal sort	
	
	st_lp :
	beq $s1 , 0 , end_beq
	
		lw $t0 , 0($s0)
		
		li $v0, 1					#Print 
		move $a0, $t0
		syscall
		
		addi $s0, $s0, 4
		addi $s1, $s1, -1
		
		b st_lp
		
		
	end_beq:
	
	
	li $v0 , 10
	syscall
	
	

sort:	


	move $s0, $a0		#a0  <---- array start
	move $s1, $a1		#a1  <---- length
			li $v0, 1								#Print menu
			move $a0, $t9
			syscall
			addi $t9,$t9,1
			li $v0, 4								#Print menu
			la $a0, tab
			syscall
			
	
	
	beq $s1 ,1 ,end_sort #<--------------------check if we reached final node    (LENGTH == 1 )	
	
	#------------------------------------------split lenghts
	srl $t2 ,$s1, 1
	sub $t3 ,$s1,$t2				
	#------------------------------------------
	
	# $t0 <--- array start
	# $t1 <--- length
	# $t2 <--- split LEFT LENGTH
	# $t3 <--- split RIGHT LENGTH
	
	#------------------------------------------# 
	addi $sp, $sp, -20			   #
	sw $ra, 0($sp)                             #
	sw $s0, 4($sp)				   #
	sw $s1, 8($sp)				   #  <-- SAVE TO STACK
	sw $t2, 12($sp)   			   #
	sw $t3, 16($sp)                            #
	#------------------------------------------#
	#====================================================================================================================LEFT PART========================
	
	move $a0 , $s0        #-------------------- Prepare $a0 and $a1 for sorting LEFT PART
	move $a1 , $t2        #--------------------
	
	jal sort

	#------------------------------------------# 
	lw $ra, 0($sp)                             #
	lw $s0, 4($sp)				   #
	lw $s1, 8($sp)				   #  <-- LOAD FROM STACK
	lw $t2, 12($sp)   			   #
	lw $t3, 16($sp)				   #
	#------------------------------------------#
	#====================================================================================================================RIGHT PART=======================
	
	
	sll $t2 ,$t2 , 2      #  move head pointer accordingly
	add $s0, $s0, $t2     #  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	addi $s0, $s0, -4
	 
	
	
	move $a0 , $s0        #-------------------- Prepare $a0 and $a1 for sorting LEFT PART
	move $a1 , $t3        #--------------------
	
	jal sort

	#------------------------------------------# 
	lw $ra, 0($sp)                             #
	lw $s0, 4($sp)				   #
	lw $s1, 8($sp)				   #  <-- LOAD FROM STACK
	lw $t2, 12($sp)   			   #
	lw $t3, 16($sp)				   #
	#------------------------------------------#
	
	#====================================================================================================================MERGE PARTS======================
	
	sll $s4 ,$t2 , 2      #  move head pointer accordingly
	add $s4, $s4, $s0
	#addi $t4, $t4, -4
	
	
	# $s0 <--- left array head
	# $s4 <--- right array head
	# $t1 <--- length 
	# $t2 <--- split LEFT LENGTH
	# $t3 <--- split RIGHT LENGTH
	
	li $t5, 0           #<----------------LEFT COUNTER
	li $t6, 0	    #<----------------RIGHT COUNTER

	merge_loop:
				
		beq $t5, $t2, end_right    #<-----IF LEFT HAS ENDEN -------->> CHECK RIGHT FOR REMAINING NODES
		beq $t6, $t3, end_left     #<-----IF RIGHT HAS ENDEN -------->> CHECK LEFT FOR REMAINING NODES
		
		#addi $sp,$sp,-8
		#sw $t6,($sp)
		#sw $t5,4($sp)
		
		#lb $t5,4($s0)	 #t7 holds the top byte
		#lb $t7,5($s0)	 #t8 holds the bottom byte #<--------- LEFT----------
		lw $t7, 0($s0)                
		#sll $t5, $t5, 4
		#or $t7, $t5, $t7
		
		#lb $t6,4($s4)	 #t7 holds the top byte
		#lb $t8,5($s4)	 #t8 holds the bottom byte #<--------- RIGHT---------
		lw $t8, 0($s4)   
		#sll $t6, $t6, 4
		#or $t8, $t6, $t8
		
		
		#lw $t6,($sp)
		#lw $t5,4($sp)
		#addi $sp,$sp,8
		                        
		blt $t7 , $t8 ,else_case      #<========COMPARE=========
		
		#====================ADD FROM RIGHT==================
		
			addi $sp , $sp, -4
			sw $t8 , 0($sp)
		
			addi $s4, $s4, 4
			addi $t6, $t6, 1
		
			b merge_loop
		else_case:
		#===================ADD FROM LEFT LEFT====================
			addi $sp , $sp, -4
			sw $t7 , 0($sp)
			
			addi $s0, $s0, 4
			addi $t5, $t5, 1
			
			b merge_loop
		
		end_left:
		#================DUMP THE REST OF LEFT ARRAY TO STACK=====
		
			beq $t5, $t2, end
			
			addi $sp , $sp, -4
			sw $t7 , 0($sp)
			
			addi $s0, $s0, 4
			addi $t5, $t5, 1
			
			b end_left
		end_right:
		#===============DUMP THE REST OF RIGHT ARRAY TO STACK=====
		
			beq $t6, $t3, end
		
			addi $sp , $sp, -4
			sw $t8 , 0($sp)
		
			addi $s4, $s4, 4
			addi $t6, $t6, 1
		
			b end_left
		end:
		
			sll $s4 ,$s1 , 2              #
			add $s4 ,$s4, $s0             #<------t4 == array end
			addi $s4 ,$s4, -4	      #	
				
		sta_loop:
			beq $s1 , 0 , end_sta_loop  
			
			lw $t5, 0($sp)
			sw $t5, 0($s4)
			
			addi $sp,$sp, 4
			addi $s4,$s4, -4
			addi $s1, $s1, -1			
			
			b sta_loop
		end_sta_loop:
				
		#------------------------------------------# 
		lw $ra, 0($sp)                             #
		lw $s0, 4($sp)				   #
		lw $s1, 8($sp)				   #  <-- LOAD FROM STACK
		lw $t2, 12($sp)   			   #
		lw $t3, 16($sp)				   #
		#------------------------------------------#	
			
		addi $sp, $sp, 20	
	
	end_sort:
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



	
