.data

.include "menu.s"

.text
FORA:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1, menu		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	beq t1,t2,FIM	# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1			# volta a verificar

FIM:	li a7,10		# syscall de exit
	ecall
.data
FLOAT: 	.float 	3.14159265659
msg1: 	.string "Snake OAC/VERAO 2020"
msg_start: .string "Inicializando o jogo: ..."
msg2: .string "HIGHSCORE:"
msg3: .string "Level Speed:"
buffer: .string "                                "

.text
 	la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
 	csrw tp,utvec 		# seta utvec para o endere�o tp
 	csrsi ustatus,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)																																																				
	
	
	jal CLSV
	jal CLS
	ebreak
	jal PRINTSTR1
	jal SLEEP
	li a7,10
	ecall
				
# CLS Clear Screen
CLS:	li a0,0x00
	li a7,148
	li a1,0
	ecall
	ret
	
CLSV:	li a7,141
	ecall
	li a7,148
	li a1,0
	ecall
	ret

				
# syscall print string
PRINTSTR1: li a7,104
	la a0,msg1
	li a1,0
	li a2,0
	li a3,0x0038
	li a4,0
	ecall
	ret		
# syscall sleep
SLEEP:	li t0,5
LOOPHMS:li a0,1000   # 1 segundo
	li a7,132
	ecall
	addi t0,t0,-1
	#print seg
	mv a0,t0
	li a7,101
	li a1,120
	li a2,120
	li a3,0x0038
	li a4,0
	ecall
	bne t0,zero,LOOPHMS	
	ret




.include "SYSTEMv17b.s"

DRAW:	li t2,0	
	li t0,0
	li s4,10
	li s5,20
LOOPDRAW: li t1,0
	  li s0,0
	  li s1,0
	  li s2,319
	  li s3,239
	li t1,0	  
FOR1:	bge t1,s4, SAI1
	#mv a0,s0
	#mv a1,s1
	#mv a2,s2
	#mv a3,s3
	#mv a4,t2
	li a0 105
	li a1 5
	li a2 105
	li a3 235
	li a5,0
	li a7,47
	ecall
	addi s0,s0,1
	addi s2,s2,-1
	add t2,t2,t0
	addi t1,t1,1
	j FOR1

SAI1:	li s2,0
	li s1,0
	li s0,319
	li s3,239
	li t1,0
FOR2:	bge t1,s5, SAI2
	#mv a0,s0
	#mv a1,s1
	#mv a2,s2
	#mv a3,s3
	#mv a4,t2
	li a0 105
	li a1 5
	li a2 314
	li a3 5
	li a4 0x0038
	li a5,0
	li a7,47
	ecall
	addi s1,s1,1
	addi s3,s3,-1
	add t2,t2,t0
	addi t1,t1,1
	j FOR2
SAI2:	addi t0,t0,1
	j LOOPDRAW
DRAW:	li t2,0	
	li t0,0
	li s4,10
	li s5,20
LOOPDRAW: li t1,0
	  li s0,0
	  li s1,0
	  li s2,319
	  li s3,239
	li t1,0	  
FOR1:	bge t1,s4, SAI1
	#mv a0,s0
	#mv a1,s1
	#mv a2,s2
	#mv a3,s3
	#mv a4,t2
	li a0 105
	li a1 5
	li a2 105
	li a3 235
	li a5,0
	li a7,47
	ecall
	addi s0,s0,1
	addi s2,s2,-1
	add t2,t2,t0
	addi t1,t1,1
	j FOR1

SAI1:	li s2,0
	li s1,0
	li s0,319
	li s3,239
	li t1,0
FOR2:	bge t1,s5, SAI2
	#mv a0,s0
	#mv a1,s1
	#mv a2,s2
	#mv a3,s3
	#mv a4,t2
	li a0 105
	li a1 5
	li a2 314
	li a3 5
	li a4 0x0038
	li a5,0
	li a7,47
	ecall
	addi s1,s1,1
	addi s3,s3,-1
	add t2,t2,t0
	addi t1,t1,1
	j FOR2
SAI2:	addi t0,t0,1
	j LOOPDRAW





