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

	SORTEIO:
	mv 	s0 a0
	addi 	s1 zero 0
	
	SORTEIO$FOR:
	addi 	a7 zero 42 #ecall que chama os rand
	li 	a1 319 #definindo o teto
	li 	a0 1
	ecall	
	mv 	s2 a0 ## salvando o valor aleatorio em s2
			
	addi 	a7 zero 42 #ecall que chama os rand
	li 	a1 239 #definindo o teto
	li 	a0 1
	ecall	
	mv 	s3 a0 ## salvando o valor aleatorio em s3
	
	slli	s2 s2 16 #movendo os 16 bits 
	or	s2 s2 s3 #fazendo um or pra juntar na word
	
	la	t0 VETOR #carregando o endereço de V em t0
	slli	t1 s1 2 #multiplicando por 4 s1, e salvando em t1
	add	t0 t0 t1 #colocando o valor de t1 em t0
	
	 
	bge 	s1 s0 SORTEIO$MORREU #Verificando se s0 é maior que s1, se for ele morre
	sw	s2 0(t0) #carregando na memoria s2
	
	li a7, 1
	ecall	
	la a0, pula
	li a7 4
	ecall
	addi 	s1 s1 1 #add 1 no contador s1
	j SORTEIO$FOR #retorna o loop
	
	SORTEIO$MORREU:
	ret
	
	
#########################################################################################
#
# ARGUMENTO: PEGA OS PONTOS NO VETOR E ORDENA, VERIFICANDO A PRECEDENCIA DA ORDEM CRESCENTE, SALVA O VALOR DE A0 EM S2
# E SALVA O VALOR DE A1 EM S3
# @BRIEF:
# @RETORNO:
#
#########################################################################################
	
	SWAP:	slli t1,a1,2
	add t1,a0,t1
	lw t0,0(t1)
	lw t2,4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	ret
	
	SORT:	
	addi sp,sp,-20
	sw ra,16(sp)
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)
	mv s2,a0
	mv s3,a1
	mv s0,zero
	
	FOR1:	
	bge s0,s3,EXIT1
	addi s1,s0,-1
	
	FOR2:	
	blt s1,zero,EXIT2
	slli t1,s1,2
	add t2,s2,t1
	lw t3,0(t2)
	lw t4,4(t2)
	bge t4,t3,EXIT2
	mv a0,s2
	mv a1,s1
	jal SWAP
	addi s1,s1,-1
	j FOR2
	
	EXIT2:	
	addi s0,s0,1
	j FOR1
	
	EXIT1: 	lw s0,0(sp)
	lw s1,4(sp)
	lw s2,8(sp)
	lw s3,12(sp)
	lw ra,16(sp)
	addi sp,sp,20
	ret

	SHOW:	
	mv t0,a0
	mv t1,a1
	mv t2,zero

	LOOP1: 	
	beq t2,t1,FIM1
	li a7,1
	lw a0,0(t0)
	ecall
	li a7,11
	li a0,9
	ecall
	addi t0,t0,4
	addi t2,t2,1
	j LOOP1

	FIM1:	
	li a7,11
	li a0,10
	ecall
	ret
	
#################################################################################################################
# ACESSA A MEMORIA ONDE ESTÃO ARMAZENADOS OS VALORES DO VETOR
# CARREGA 16 BITS EM S0 DO ENDEREÇO EM T0
# CARREGA OS OUTROS 16 BITS EM S1
#
#################################################################################################################	
	
	POSICAO$SHOW:
	mv s2 a0   # n
	la s4 VETOR
	li s3 0
	POSICAO$LOOP:
	bge s3 s2 POSICAO$ENDLOOP

	lh s0 0(s4)
	lh s1 2(s4)
	
	li a7 4
	la a0 x
	ecall
	
	li a7 1
	mv a0 s0
	ecall
	
	li a7 4
	la a0 pula
	ecall
	
	li a7 4
	la a0 y
	ecall
	
	li a7 1
	mv a0 s1
	ecall
	
	li a7 4
	la a0 pula
	ecall
		
	addi s4 s4 4
	addi s3 s3 1
	
	j POSICAO$LOOP
	
	POSICAO$ENDLOOP:	
	#ret