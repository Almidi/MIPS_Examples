#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.data
#Messages Storage
 
.globl menu
.globl listcreated
.globl listmissing
.globl nodequant
.globl memorout
.globl nodecreate
.globl idinsert
.globl valueinsert
.globl asknode
.globl VacantList
.globl Identity
.globl Value
.globl InexistingNode
.globl NodeNumber
.globl ElementAdress
.globl ListAdress
.globl SmallestValue
.globl ID
.globl ValueIS
.globl NextLine


#Arrays
.globl Array
.globl MaxArraySize
Array: .align 2                               #Ensure Alignment for consistant data structure 
	   .space 800

MaxArraySize: .word 100



menu: .asciiz "\n\n1) Create List\n2) Insert List Node\n3) Delete Last Node\n4) Print The Value Of The Node\n5) Print Node Quantity\n6) Print Node's Location \n7) Print Head Location\n8) Print The Node With Minimum Value \n9) Exit\n \nOption : "
listcreated: .asciiz "List Has Been Created Before\n"
listmissing: .asciiz "There Isn't a Created List\n"
nodequant: .asciiz "Please Insert Node Quantity :\n"   
memorout: .asciiz "Memory Outage!\n"     
nodecreate: .asciiz "\nCreation of the node:"
idinsert: .asciiz "Insert the identity of the node\n"
valueinsert: .asciiz "Insert the value\n"
asknode: .asciiz "Give the number of node you want to see\n"
VacantList: .asciiz "Nothing In The List!\n"
Identity: .asciiz "The id= "
Value: .asciiz "The value= "
InexistingNode: .asciiz "\nThese is no such node!\n"
NodeNumber: .asciiz "The number of the list's nodes is "
ElementAdress: .asciiz "The address of this element is= "
ListAdress: .asciiz "The address of the list is: "
SmallestValue: .asciiz "The node with the minimum value is # "
ID: .asciiz " with id: "
ValueIS: .asciiz " and value: "
NextLine: .asciiz "\n"




#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.text
.globl main
.globl create_first_node
.globl insert_node
.globl delete_node
.globl print_node
.globl print_length_list
.globl print_address
.globl print_head_address
.globl minValueNodePrinter

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

main:
	li $s0, 0 									#CreatedList = 0 since no list created
	
	
	la $s2, Array    							#s2 is the beginning address of the Array
	
	li $s5 , 0

	menuStart: 							#Start main sequence
		li $v0, 4								#Print menu
		la $a0, menu
		syscall                                 #Print menu

		
		
		
		li  $v0, 5								
		syscall                                 #Read the option
		move $s1,$v0 							#Answer goes to $s1
		
		
		
		
		beq $s1, 1, Label1
		beq $s1, 2, Label2
		beq $s1, 3, Label3
		beq $s1, 4, Label4
		beq $s1, 5, Label5
		beq $s1, 6, Label6
		beq $s1, 7, Label7
		beq $s1, 8, Label8
		beq $s1, 9, Exit
		b menuStart
		
		
        Label1:     								#Create the list 
			bne $s0,0,ElseLabel1
				move $a0, $s2					    #Beginning of Array as arg
                jal create_first_node               #Function to create first node
				
				move $s3,$v0					    #Copy v0 to s3 witch indicates the list size
                li $s0,1							#CreatedList=1
				
				move $s5,$v0
				
                b menuStart
				
			ElseLabel1:
				li $v0, 4						#You have already created a list
				la $a0, listcreated
				syscall
				
	    b menuStart
		
		
		
		
        Label2:    								#Insert Node
		
			addi $s5,$s5,1
			
			beq $s0,0,ElseLabel2				#s0 == createdList
				move $a0, $s2					#beginning of Array as arg
				move $a1, $s3					#size of Array as arg
				move $a2, $s5
				
				jal insert_node
				move $s3,$v0					#Copy array size from v0(temporary register from the function) to the s3
                b menuStart
		  	ElseLabel2:
				li $v0, 4					    #Created a list first
				la $a0, listmissing
				syscall

		b menuStart
		
        Label3:     							#Delete Last Node
			move $a0, $s3						#size of Array as arg
            jal delete_node
			move $s3,$v0						#Copy decreased array size from v0(temporary register from the function) to the s3
	    b menuStart
		
        Label4:      							#View Node
			move $a0, $s2						#beginning of Array as arg
			move $a1, $s3						#size of Array as arg
			jal print_node
		b menuStart
		
        Label5:      							#Print Node Quantity
            move $a0,$s3						#size of Array as arg
	    jal print_length_list
	    b menuStart
		
       Label6:      								#Print Node's Location
			move $a0, $s2						#beginning of Array as arg
			move $a1, $s3						#size of Array as arg
            jal print_address
		b menuStart
		
        Label7:      			#Print Head Location
			move $a0, $s2						#beginning of Array as arg
            jal print_head_address
		b menuStart
		
        Label8:      			#Print Node With Min Value
			move $a0, $s2						#beginning of Array as arg
			move $a1, $s3						#size of Array as arg
            jal minValueNodePrinter
		b menuStart
		
												#End Of Program

	Exit:
	
	li  $v0, 10                                 #Free Memory
	syscall

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create_first_node:
	move $t2, $a0								#t2 has the beginning of the Array
	li $v0, 4									#How many nodes wanted
	la $a0, nodequant
	syscall
	li  $v0, 5									#Read in the integer number
	syscall
	
	
	
	move $t0,$v0 								#Copying Buffer $v0 to register $t0 (answer) Nodes Number initialization
	li $v0, 4									#NextLine
	la $a0, NextLine
	syscall
	
	
	
	la $t1,MaxArraySize
	bgt $t0,$t1,memoroutLabelFunction1			#Enough memory check
	
	
    li $t1,1 									#Counter initialization
	
	
    beforeWhileLabelFunction1:
    bgt $t1,$t0,endWhileLabelFunction1
		
		li $v0, 4								#Creation of the node:
		la $a0, nodecreate
		syscall
		
		
		
		li  $v0, 1								#Printing the number of the current node
		move $a0,$t1
		syscall
		li $v0, 4								#NextLine
		la $a0, NextLine
		syscall
		
		
		move $t4,$t1 							
		
		
		
		sw $t4, 0($t2)							#Store the id input into the IdArray                    /////////////////////////////////////	
		li $v0, 4								#Insert the value
		la $a0, valueinsert
		syscall
		li  $v0, 5								#Read in the integer value
		syscall
		
		
		
		move $t8, $v0    #v0 is the input



		srl $t9, $t8, 4	                        #t9 holds the top byte
		andi $t8, $t8, 0x000F                   #t8 hold the bottom byte

		sb $t9,4($t2)	                        #Store the bytes in the memory in the correct order
		sb $t8,5($t2)
		
		
		
		
		#move $t4,$v0 							#Copying Buffer $v0 to register $t4 (answer)
		#sw $t4, 4($t2)							#Store the id input into the ValueArray
		
		
		
		add $t2, $t2, 8	 						#Move head address		
		addi $t1,$t1,1							#Counter increase by 1
        b beforeWhileLabelFunction1
    endWhileLabelFunction1:
	move $v0, $t0								#Return size of the arrays
jr $ra
memoroutLabelFunction1:
	li $v0, 4									#Not enough memory
	la $a0, memorout
	syscall
	li $v0,0
jr $ra                                          #Exit

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert_node:

	move $t3,$a2                                #idCounter
	move $t0,$a0								#							
	move $t1,$a1

	
	addi $t1,$t1,1								#Temporary array size++
	
	la $t2,MaxArraySize							#Enough memory check
	bgt $t1,$t2,memoroutLabelFunction2	
	addi $t1,$t1,-1
	
	
	li $t2,1									#Temporary counter initialization
	beforeWhileLabelFunction2:
	bgt $t2,$t1,afterWhileLabelFunction2
		addi $t0,$t0,8							#Temporary Array index increase
		addi $t2,$t2,1							#Counter++
		b beforeWhileLabelFunction2
		
	afterWhileLabelFunction2:
	

	sw $t3, 0($t0)								#Store ID

	li $v0, 4									#Insert the value
	la $a0, valueinsert
	syscall

	li  $v0, 5									#Read in the integer value
	syscall

	move $t8,$v0 								#Copying Buffer $v0 to register $t8 (answer)

	
	srl $t9, $t8, 4	                        #s1 holds the top byte
	andi $t8, $t8, 0x000F                   #s0 hold the bottom byte

	sb $t9,4($t0)	                        #Store the bytes in the memory in the correct order      /////////////////////////////////////////////////////
	sb $t8,5($t0)
	
	
	#sw $t4, 4($t0)								#Store the id input into the ValueArray
	
	addi $t1,$t1,1
	move $v0,$t1
	
	
jr $ra
memoroutLabelFunction2:
	li $v0, 4									#Not enough memory
	la $a0, memorout
	syscall
	addi $t1,$t1,-1
	move $v0,$t1
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

delete_node:
	move $t0,$a0
	addi $t0,$t0,-1
	move $v0,$t0
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

print_node:
	move $t0,$a0								#Temporary array head initialization
	move $t1,$a1								#Temporary array size initialization
	li $t2,1									#Temporary counter initialization
	
	li $v0, 4									#Insert the Node number you want to see
	la $a0, asknode
	syscall
	li  $v0, 5									#Read in the integer id
	syscall
	move $t3,$v0
	bgt $t3,$t1,NoNodeF4
	bWF4:
	bge $t2,$t3,aWLF4
		addi $t0,$t0,8							#Temporary Array index increase
		addi $t2,$t2,1							#Counter increase by 1
		b bWF4
	aWLF4:
	
	li $v0, 4									#This node's id is:
	la $a0, Identity
	syscall
	
	li  $v0, 1									#Printing the node's id
	lw $a0,0($t0)
	syscall
	li $v0, 4									#NextLine
	la $a0, NextLine
	syscall
	
	
	li $v0, 4									#This node's value is:
	la $a0, ValueIS
	syscall
	
	
	lb $s5,4($t0)	 #s3 holds the top byte
	lb $s6,5($t0)	 #s4 holds the bottom byte

	sll $s5, $s5, 4
	or $s6, $s5, $s6
	
	
	li $v0, 1
	move $a0, $s6
	syscall
	
	
	
	
	li $v0, 4									#NextLine
	la $a0, NextLine
	syscall
jr $ra
NoNodeF4:
	li $v0, 4									#There is no such node
	la $a0, InexistingNode
	syscall
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

print_length_list:


	move $t0,$a0

	li $v0, 4									#List's size
	la $a0, NodeNumber
	syscall


	li  $v0, 1									#Printing list size
	move $a0,$t0
	syscall


	li $v0, 4									#NextLine
	la $a0, NextLine
	syscall

jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

print_address:
	move $t0,$a0								#Temporary array head initialization
	move $t1,$a1								#Temporary array size initialization
	li $t2,1									#Temporary counter initialization
	
	li $v0, 4									#Insert the Node number you want to see
	la $a0, asknode
	syscall
	li  $v0, 5									#Read in the integer id
	syscall
	move $t3,$v0
	bgt $t3,$t1,InexistingNodeLabelFunction6
	beforeWhileLabelFunction6:
	bge $t2,$t3,afterWhileLabelFunction6
		addi $t0,$t0,8							#Temporary Array index increase
		addi $t2,$t2,1							#Counter increase by 1
		b beforeWhileLabelFunction6
	afterWhileLabelFunction6:
	
	
	li $v0,4
	la $a0,ElementAdress
	syscall
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,NextLine
	syscall
jr $ra
InexistingNodeLabelFunction6:
	li $v0, 4									#There is no such node
	la $a0, InexistingNode
	syscall
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

print_head_address:
	move $t0,$a0
	li $v0,4
	la $a0,ListAdress
	syscall
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,NextLine
	syscall
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

minValueNodePrinter:
	move $t1, $a0								#t1 has the beginning of array
	move $t2, $a1								#t2 has the number of elements
	lw $t5, 0($t1)								#t5 will hold the min Id
	
	
	
	lb $t8,4($t1)	 #t8 holds the top byte
	lb $t9,5($t1)	 #t9 holds the bottom byte
	sll $t8, $t8, 4
	or $t9, $t8, $t9
	
	move $t4, $t9 								#t4 will hold the min value
	
	
	
	li $t6,1									
	li $t7,1									
	
	minloop:
		bgt $t6, $t2, end_loop				

		
		lb $t8,4($t1)	 #t8 holds the top byte
		lb $t9,5($t1)	 #t9 holds the bottom byte

		sll $t8, $t8, 4
		or $t9, $t8, $t9
		
		move $t3, $t9	#t3 holds the element
		
		
		blt $t3, $t4, new_min					
			addi $t1, $t1, 8					
			addi $t6, $t6, 1					
			b minloop						
	
		new_min:
			lw $t5, 0($t1)						
			move $t4, $t3						
			move $t7, $t6						
			addi $t1, $t1, 8					
			addi $t6, $t6, 1					
			b minloop						
	end_loop:
	
	li $v0,4
	la $a0,SmallestValue
	syscall
	li $v0,1
	move $a0,$t7
	syscall
	
	li $v0,4
	la $a0,ID
	syscall
	li $v0,1
	move $a0,$t5
	syscall
	
	li $v0,4
	la $a0,ValueIS
	syscall
	
	
	#srl $t4,$t4,8
	
	li $v0,1
	move $a0,$t4
	syscall
	
	li $v0,4
	la $a0,NextLine
	syscall
jr $ra

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






	
	


#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------