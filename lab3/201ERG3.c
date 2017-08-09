#include <stdio.h>
#include <stdlib.h>
typedef struct{
	
	int id ;
	short value ;
	struct Node* next ;
	
}Node;


void menu(void);
void Insert();
void Count(Node* tmp);
void deletefirst();
void print();
void printlocation();
void printnodeloc();
void printdetailloc();
void printlistsize(Node* tmp);
void nodesizeprint(Node* tmp);



int R0=0 ,               
	at,   //------------------------------------- assembler temporary register
	v0, v1,   //--------------------------------- expression evaluation and function result
	a0, a1, a2, a3,  //-------------------------- procedure arguments
	t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, //--- temporary
	s0, s1, s2, s3, s4, s5, s6, s7 //------------ saved temporaries		
;



int main(void){
	
	
	int createdList=0;
	
	
	Node *head=NULL;  ///
	Node *tmp=NULL;   ///
	
	
	void (*menu_p)(void)=&menu;
    void (*Insert_p)()=&Insert;
    void (*deletefirst_p)()=&deletefirst;
    void (*print_p)()=&print;
    void (*printlocation_p)()=&printlocation;
    void (*printnodeloc_p)()=&printnodeloc;
    void (*printdetailloc_p)()=&printdetailloc;
    void (*printlistsize_p)(Node* )=&printlistsize;
    void (*nodesizeprint_p)(Node* )=&nodesizeprint;
	s4 = 0 ;
	s5 = 0 ;
	
    loop_start:	
    
    a0 = (int)head;
	a1 = (int)tmp;
		    
    
         
    //s0=createdList;         
    menu();
	
	//s0 = (int)head;
	
	
    if (v0 == 1)goto case1;
    if (v0 == 2)goto case2;
    if (v0 == 3)goto case3;
    if (v0 == 4)goto case4;
    if (v0 == 5)goto case5;
    if (v0 == 6)goto case6;
    if (v0 == 7)goto case7;
    if (v0 == 8)goto case8;
    if (v0 == 9)goto case9;
    if (v0 == 10)goto case10;
    if (v0 == 11)goto case11;
    if (v0 == 12)goto case12;
    
    
    
    
    
    
    
    goto loop_start;
    
    	


		case1 : 
            
			if(!(s0==(int)NULL && !(s0)))goto case1else;
                            
            a3 = ++s5 ; 		
			s4++;
			
			      
            Insert_p(); 
            
            
            head=(Node*)a0 ;
            tmp = (Node*)a1 ;
			        
            s0=1; 
            
            createdList = s0;
            printf("\nList was succesfully created!\n");
            goto loop_start;    
            
            case1else:            	
           	printf("List Already Created\n");
            
			goto loop_start;
		case2 :
              
            if(s0==0)goto case2else;
            
            
			a3 = ++s5 ;  
			s4++ ; 
			             
            Insert_p();
            
            tmp = (Node*)a1 ;
            
            goto loop_start;    
            
            case2else:            	
           	printf("No List Created\n");
            
			goto loop_start;
                
                		
		case3 :
                
            if(s0==0)goto case3else;
            
			a3 = s4 ;                
            
			deletefirst_p();
			
			s4 = a3 ;
			head=(Node*)a0 ;
            tmp = (Node*)a1 ;
			
            goto loop_start;    
            
            
            
            case3else:            	
           	printf("No List Created\n");
            
			goto loop_start;
                
                
                	
		case4 :
				
				a3 = s4 ;
				print_p();
				goto loop_start;		
					
		case5 :printf("\n %d Nodes\n", s4);		
				goto loop_start;		
				
		case6 :
				
				a3 = s4 ;
				printlocation_p();
				
				goto loop_start;		
		case7 :
				a2 = a0 ;
				printnodeloc_p();
				goto loop_start;
		case8 :
				a3 = s4 ;
				printdetailloc_p();
				
				goto loop_start;		
		case9 :printlistsize_p(head);
				
				goto loop_start;		
		case10:nodesizeprint_p(head);
				
				goto loop_start;
		case11:
               
               printf("\nmenu: %d\n",menu_p);
               printf("Insert: %d\n",Insert_p);
               printf("Count: %d\n",s4);
               printf("deletefirst: %d\n",deletefirst_p);
               printf("print: %d\n",print_p);
               printf("printlocation: %d\n",printlocation_p);
               printf("printnodeloc: %d\n",printnodeloc_p);
               printf("printdetailloc: %d\n",printdetailloc_p);
               printf("printlistsize: %d\n",printlistsize_p);
               printf("nodesizeprint: %d\n\n",nodesizeprint_p);

               
		                             
		       goto loop_start;                      
		case12:printf("GoodBye");
}


void menu(void){
    
	printf("1) Create List\n");
	printf("2) Insert List Node\n");
	printf("3) Delete First Node\n");
	printf("4) Print Node's Value\n");
	printf("5) Print Node Quantity\n");
	printf("6) Print Node's Location \n");
	printf("7) Print Head Location\n");
	printf("8) Print Node's Detailed Location \n");
	printf("9) Print List Size\n");
	printf("10) Print Node Size\n");
	printf("11) Print Function Pointer Locations\n");
	printf("12) Exit\n");
	printf("Option : ");
	
	scanf("\n %d", &v0);

}

//void Insert(Node** head,Node** tmp,int i_d){
//	if (*head==NULL){
//		*head=(Node*)malloc(sizeof(Node));
//		 *tmp=*head;
//	}
//	else{
//		(*tmp)->next=(Node*)malloc(sizeof(Node));
//		*tmp=(*tmp)->next;
//	}
//	
//	printf("Value : ");
//	scanf("\n %d",&((**tmp).value));
//	((**tmp).id)=++i_d;
//	(**tmp).next=NULL;
//}


void Insert(){
    t8 = a0 ;
    t9 = a1 ;
	
	 
     

	if ((Node*)t8 !=NULL)goto else_label;
                                                    
                                                    
		t8=(int)((Node*)malloc(sizeof(Node)));
		t9 = t8 ;
		
		goto after_label;
		 
    else_label:
    	
    	
    	t7 =(int)(malloc(sizeof(Node)));       
    	           
				                    
		*((int*)(t9 + 8))= t7 ;          //////////////////
		
		
		t9 = *((int*)(t9+8));
			
		
	after_label:
	printf("Value : ");
	scanf("\n %d",&t1);
	
	*((short*)(t9+4))=(short)t1;
	
	*((int*)t9)=a3;
	
	*((int*)(t9+8))=NULL;
	
	
	a0 = t8 ;
    a1 = t9 ;
	
}



//void deletefirst(Node** head){
//	if(*head!=NULL){
//		*head=(*head)->next;
//			printf("Head Node Deleted\n");
//	}
//	
//}

void deletefirst(){
	if((Node*)a0 == NULL){goto empty;}
	
	a0=*((int*)(a0+8));
	
	printf("Head Node Deleted\n");
	
	a3 -- ;
	
	empty:
		
    printf("\n");
	
	
}




//void print(int max,Node* tmp){
//	int print=0;
//	int i=0;
//	int i_d;
//	printf("Insert Node id:");
//	scanf("\n %d", &i_d);
//	while(i<max && print==0){
//		if ((*tmp).id == i_d){
//			print=1;
//			printf("\n %d\n",(*tmp).value);			
//			break;
//		}
//		else{
//			i++;
//			tmp=tmp->next;
//			
//		}
//	}
//	if(print==0){
//		printf("No node found with this id");
//	}
//}

void print(){
     



	t2=0; //print
	t3=0; //i
	t4=0; //i_d
	
	
	t5=a3;    ///count
	t6=a0 ; 
	
	
	printf("Insert Node id:");
	scanf("\n %d", &t4);
	
	
	print_start:
	
	
	if(t3>=t5 || t2!=0){goto print_stop;}
	
	
   
    if (*((int*)t6) != t4){goto print_nn;}  //print nn == print NEXT NODE
    t2=1;
	
	
	
	printf("\n %d \n", *((int*)(t6+4)) );			
	goto print_stop;
	
	
	print_nn:
	
	
    t3++;
    
    
    t6 = *((int*)(t6 + 8)) ;
		
    goto print_start;
    
	print_stop:   
               
			   
			                
	if(t2==0){
         printf("No node found with this id");
	}
	
}



//void printlocation(int max,Node* tmp){
//	int print=0;
//	int i=0;
//	int i_d;
//	printf("Insert Node id:");
//	scanf("\n %d", &i_d);
//	while(i<max && print==0){
//		if ((*tmp).id == i_d){
//			print=1;
//			printf("\n %d\n",&(*tmp));			
//			break;
//		}
//		else{
//			i++;
//			tmp=tmp->next;
//			
//		}
//	}
//	if(print==0){
//		printf("No node found with this id");
//	}
//}

void printlocation(){
	t2=0; //print
		t3=0; //i
		t4=0; //i_d
		
		
		t5=a3;    ///count
		t6=a0 ; 
		
		
		printf("Insert Node id:");
		scanf("\n %d", &t4);
		
		
		print_start:
		
		
		if(t3>=t5 || t2!=0){goto print_stop;}
		
		
	   
	    if (*((int*)t6) != t4){goto print_nn;}  //print nn == print NEXT NODE
	    t2=1;
		
		
		
		printf("\n %d \n", t6 );			//PRINT
		goto print_stop;
		
		
		print_nn:
		
		
	    t3++;
	    
	    
	    t6 = *((int*)(t6 + 8)) ;
			
	    goto print_start;
	    
		print_stop:   
               
			   			                
	if(t2==0){
         printf("No node found with this id");
	}
}







void printnodeloc(){
	printf("\n %d\n",a2);			
	
}


//void printdetailloc(int max,Node* tmp){
//	int print=0;
//	int i=0;
//	int i_d;
//	printf("Insert Node id:");
//	scanf("\n %d", &i_d);
//	while(i<max && print==0){
//		if ((*tmp).id == i_d){
//			print=1;
//			printf("\nValue Location : %d\n",&(*tmp).value);
//			printf("\nID Location : %d\n",&(*tmp).id);
//			printf("\nNext Location : %d\n",&(*tmp).next);			
//			break;
//		}
//		else{
//			i++;
//			tmp=tmp->next;
//			
//		}
//	}
//	if(print==0){
//		printf("No node found with this id");
//	}
//}

//void printlistsize(int count,Node* tmp){
//	printf("\n %d\n",count*sizeof(*tmp));
//}


void printdetailloc(){
	t2=0; //print
		t3=0; //i
		t4=0; //i_d
		
		
		t5=a3;    ///count
		t6=a0 ; 
		
		
		printf("Insert Node id:");
		scanf("\n %d", &t4);
		
		
		print_start:
		
		
		if(t3>=t5 || t2!=0){goto print_stop;}
		
		
	   
	    if (*((int*)t6) != t4){goto print_nn;}  //print nn == print NEXT NODE
	    t2=1;
		
		
		
		printf("\nValue Location : %d\n",t6 +4);
 		printf("\nID Location : %d\n",t6);
		printf("\nNext Location : %d\n",t6 + 8);			//PRINT
		
		goto print_stop;
		
		
		print_nn:
		
		
	    t3++;
	    
	    
	    t6 = *((int*)(t6 + 8)) ;
			
	    goto print_start;
	    
		print_stop:   
               
			   			                
	if(t2==0){
         printf("No node found with this id");
	}

}


	void printlistsize(Node* tmp){
	    
	    int sum =0 ;
	    
		int i=0;
		
		while(tmp != NULL){
	        sum = sum + sizeof(*tmp);
			tmp=tmp->next;
			i++;
		}
		printf("%d\n",sum);
				
	}



void nodesizeprint(Node* tmp){
	printf("\n %d\n",sizeof(*tmp));			
	
}


