.data

V: .word 20


.text
	li 	a0 10
	
	SORTEIO:
	mv 	s0 a0
	addi 	s1 zero 0
	
	SORTEIO$FOR:
	addi 	a7 zero 42 #ecall que chama os rand
	li 	a1 319
	li 	a0 1
	ecall	
	mv 	s2 a0 ## salvando o valor aleatorio em s1 de x	
		
	addi 	a7 zero 42 #ecall que chama os rand
	li 	a1 239
	li 	a0 1
	ecall	
	mv 	s3 a0 ## salvando o valor aleatorio em s1 de y
	
	slli	s2 s2 16
	or	s2 s2 s3
	
	la	t0 V
	slli	t1 s1 2
	add	t0 t0 t1
	sw	s2 0(t0)
	ebreak
	
	bge 	s1 s0 SORTEIO$END
	addi 	s1 s1 1 
	call SORTEIO$FOR
	
	SORTEIO$END:
	ret
	
	
	














	#addi sp, sp, -12
	#sw ra, 0(sp)
	#sw  a0, 4(t0) 
	#sw a1, 8(t1)	
	#lw a1, 8(t1)
	#lw a0, 4(t0)
	#lw ra, 0(sp)
	#addi sp, sp, 12
	
