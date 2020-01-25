.data
pula: .string "\n"
VETOR:  .word 5
.text
###########################################################################################
# ARGUMENTOS: A0 = NUMERO DE PONTOS 
# @BRIEF ELE SELECIONA O "n" NUMERO DE PONTOS ALEATORIOS QUE SERAO GERADOS PARA AS COORDENADAS X E Y SALVOS NO VETOR
# @RETURN NENHUM
#
###########################################################################################
	
	## S2 = Vetor desordenado
	## S4 = N
	## S3 = Vetor ordenado
	SORTEIO:
	add 	s1 zero zero
	
	SORTEIO$FOR:
	addi 	a7 zero 42 #ecall que chama os rand
	li 	a1 319 #definindo o teto
	li 	a0 1
	ecall	
	mv 	t0 a0 ## salvando o valor aleatorio em s2
			
	addi 	a7 zero 42 #ecall que chama os rand
	li 	a1 239 #definindo o teto
	li 	a0 1
	ecall	
	mv 	t1 a0 ## salvando o valor aleatorio em s3
	
	slli	t0 t0 16 #movendo os 16 bits 
	or	t0 t0 t1 #fazendo um or pra juntar na word
	
	slli	t1 s1 2 #multiplicando por 4 s1, e salvando em t1
	add	t2 t1 s2 #colocando o valor de t1 em t0
	
	 
	bge 	s1 s4 SORTEIO$MORREU #Verificando se s0 é maior que s1, se for ele morre
	sw	t0 0(t2) #carregando na memoria s2
	
				
#	li a7, 1
#	ecall
			
#	la a0, pula
#	li a7 4
#	ecall
	
	addi 	s1 s1 1 #add 1 no contador s1
	j SORTEIO$FOR #retorna o loop
	
	SORTEIO$MORREU:
	ret
##############################################################
#
# TESTAR O HALFWORD NA MARRA
#
#	lh s5 0(s2)
	#lh s6 2(s2)
	
	#li a7, 1
	#mv a0 s5
	#ecall
	
	#li a7, 1
	#mv a0 s6
	#ecall
##############################################################	
	
	
SWAP:	slli t1,a1,2
	add t1,a0,t1
	lw t0,0(t1)
	lw t2,4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	ret

SORT:	addi sp,sp,-20
	sw ra,16(sp)
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)
	mv s2,a0
	mv s3,a1
	mv s0,zero
for1:	bge s0,s3,exit1
	addi s1,s0,-1
for2:	blt s1,zero,exit2
	slli t1,s1,2
	add t2,s2,t1
	lw t3,0(t2)
	lw t4,4(t2)
	bge t4,t3,exit2
	mv a0,s2
	mv a1,s1
	jal SWAP
	addi s1,s1,-1
	j for2
exit2:	addi s0,s0,1
	j for1
exit1: 	lw s0,0(sp)
	lw s1,4(sp)
	lw s2,8(sp)
	lw s3,12(sp)
	lw ra,16(sp)
	addi sp,sp,20
	ret
	
#################################################################################################################
# ACESSA A MEMORIA ONDE ESTÃO ARMAZENADOS OS VALORES DO VETOR
# CARREGA 16 BITS EM S0 DO ENDEREÇO EM T0
# CARREGA OS OUTROS 16 BITS EM S1
#
#################################################################################################################	
	
	POSICAO$SHOW:
	mv s2 a0   # n em s2
	mv s4 a1   # Vetor em s4
	add s3 zero zero
	POSICAO$LOOP:
	bge s3 s2 POSICAO$ENDLOOP

	lh s0 0(s4)
	lh s1 2(s4)
	
	li a7 4
	la a0 x
	ecall
	
	li a7 1
	mv a0 s1
	ecall
	
#	li a7 4
#	la a0 pula
#	ecall
	
	li a7 4
	la a0 y
	ecall
	
	li a7 1
	mv a0 s0
	ecall
	
	li a7 4
	la a0 pula
	ecall
		
	addi s4 s4 4
	addi s3 s3 1
	
	j POSICAO$LOOP
	
	POSICAO$ENDLOOP:	
	#ret
