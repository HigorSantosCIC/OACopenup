.eqv N 10
.data
VETOR:  .word 10
#9,2,5,1,8,2,4,3,6,7,10,2,32,54,2,12,6,3,1,78,54,23,1,54,2,65,3,6,55,31
#V: .word 20

.text
	MAIN: 
	lw a0 VETOR
	jal SORTEIO
	li a7, 10
	ecall
	
#	la a0,VETOR
#	li a1,N
#	jal SHOW

	la a0,VETOR
	li a1,N
	jal SORT

	la a0,VETOR
	li a1,N
	jal SHOW

	li a7,10
	ecall
	
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
	addi 	s1 s1 1 #add 1 no contador s1
	j SORTEIO$FOR #retorna o loop
	
	SORTEIO$MORREU:
	ret
	
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
