.data

V: .word 20

.text

	MAIN: 
	lw a0 V
	jal SORTEIO
	
#	li a7 1
#	ecall
	
	li a7, 10
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
	
	la	t0 V #carregando o endereço de V em t0
	slli	t1 s1 2 #multiplicando por 4 s1, e salvando em t1
	add	t0 t0 t1 #colocando o valor de t1 em t0
	bge 	s1 s0 SORTEIO$MORREU #Verificando se s0 é maior que s1, se for ele morre
	sw	s2 0(t0) #carregando na memoria s2
	addi 	s1 s1 1 #add 1 no contador s1
	j SORTEIO$FOR #retorna o loop
	
	SORTEIO$MORREU:
	ret
		
.include "SYSTEMv17b.S"
