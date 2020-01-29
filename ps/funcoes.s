.data
pula: .string "\n"
VETOR:  .word 5
ordem_pontos: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
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
	
	SORTEIO_FOR:
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
	
	 
	bge 	s1 s4 SORTEIO_MORREU #Verificando se s0 Ã© maior que s1, se for ele morre
	sw	t0 0(t2) #carregando na memoria s2
	
				
#	li a7, 1
#	ecall
			
#	la a0, pula
#	li a7 4
#	ecall
	
	addi 	s1 s1 1 #add 1 no contador s1
	j SORTEIO_FOR #retorna o loop
	
	SORTEIO_MORREU:
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
	
	
SWAP:	
slli 	t1 a1 2
add 	t1 a0 t1
lw 	t0 0(t1)
lw 	t2 4(t1)
sw 	t2 0(t1)
sw 	t0 4(t1)
ret

SORT:	
addi 	sp sp -20
sw 	ra 16(sp)
sw 	s3 12(sp)
sw 	s2 8(sp)
sw 	s1 4(sp)
sw 	s0 0(sp)
mv 	s2 a0
mv 	s3 a1
mv 	s0 zero
for1:
bge 	s0 s3 exit1
addi 	s1 s0 -1
for2:	
blt 	s1 zero exit2
slli 	t1 s1 2
add 	t2 s2 t1
lw 	t3 0(t2)
lw 	t4 4(t2)
bge 	t4 t3 exit2
mv 	a0 s2
mv 	a1 s1
jal SWAP
addi s1 s1 -1
j for2
exit2:	
addi s0 s0 1
j for1
exit1: 	
lw 	s0 0(sp)
lw 	s1 4(sp)
lw 	s2 8(sp)
lw 	s3 12(sp)
lw 	ra 16(sp)
addi 	sp sp 20
ret
	
#################################################################################################################
# ACESSA A MEMORIA ONDE ESTÃƒO ARMAZENADOS OS VALORES DO VETOR
# CARREGA 16 BITS EM S0 DO ENDEREÃ‡O EM T0
# CARREGA OS OUTROS 16 BITS EM S1
#
#################################################################################################################	
	
POSICAO_SHOW:
mv 	s2 a0   # n em s2
mv 	s4 a1   # Vetor em s4
add 	s3 zero zero
POSICAO_LOOP:
bge 	s3 s2 POSICAO_ENDLOOP
lh 	s0 0(s4)
lh 	s1 2(s4)
	
li 	a7 4
la 	a0 x
ecall
	
li 	a7 1
mv 	a0 s1
ecall
	
#	li a7 4
#	la a0 pula
#	ecall
	
li 	a7 4
la 	a0 y
ecall
	
li 	a7 1
mv 	a0 s0
ecall
	
li 	a7 4
la 	a0 pula
ecall
		
addi 	s4 s4 4
addi 	s3 s3 1
	
j POSICAO_LOOP
	
POSICAO_ENDLOOP:	
#ret
	

###########################################################################################
# ACESSAR_VETOR
# ARGUMENTOS: a0 = ponteiro para o vetor, a1 = NUMERO DA POSICAO DO VETOR A SER ACESSADO
# @RETURN A0 VALOR DE X, A1 VALOR DE Y
###########################################################################################
ACESSAR_VETOR:
addi 	sp sp -4
sw 	ra 0(sp)
	
slli 	a1 a1 2
add 	t0 a0 a1
lh   	a1 0(t0)
lh	a0 2(t0)

ACESSAR_VETOR_END:
lw 	ra 0(sp)
addi 	sp sp 4
ret
	

###########################################################################################
# LIGA_PONTOS
# ARGUMENTOS: a0 = ponteiro para o vetor, a1 = NUMERO DE PONTOS
# @RETURN Retorna a0 ponteiro para a pilha com o inicio do vetor 
###########################################################################################
LIGA_PONTOS:
addi 	sp sp -32
fsw  	fs0 28(sp)
sw 	s11 24(sp)
sw 	s10 20(sp)
sw 	s3 16(sp)
sw 	s2 12(sp)
sw 	s1 8(sp)
sw 	s0 4(sp)
sw 	ra 0(sp)

addi 	s0 zero 1 
addi 	s1 zero N

# Criar vetor com a sequencia de pontos a serem ligados ########
la 	s2 ordem_pontos
slli 	t0 s1 2
add 	s2 s2 t0
sw	zero 0(s2) 	# Salva o primeiro ponto que é o valor 0
addi	s2 s2 -4	# Salva o ponteiro para os numeros abaixo
addi	s3 s2 8 	# Salva o ponteiro para os numeros acima
# Criar vetor com a sequencia de pontos a serem ligados ########

mv 	s10 a0
mv 	s11 a1

mv 	a0 s10
addi	a1 zero 0
addi 	a2 zero N
addi 	a2 a2 -1
call coeficiente_angular

fmv.s	fs0 fa0		# coeficiente angular 

LIGA_PONTOS_for: 
bge 	s0 s1 LIGA_PONTOS_end_for
mv 	a0 s10	 # ponteiro para as coordenadas ordenadas
add 	a1 zero s0
addi	a2 zero 0
call coeficiente_angular

fle.s 	t0 fa0 fs0

beq 	t0 zero LIGA_PONTOS_acima

LIGA_PONTOS_abaixo:
sw	s0 0(s2)	# Salva o numero do ponto
addi	s2 s2 -4	# desloca o ponteiro para a posicao anterior
j	LIGA_PONTOS_endif

LIGA_PONTOS_acima:
sw	s0 0(s3)	# salva o numero do ponto
addi	s3 s3 4		# desloca o ponteiro para a proxima posicao 

LIGA_PONTOS_endif:	
addi 	s0 s0 1
j	LIGA_PONTOS_for

LIGA_PONTOS_end_for:

# Deve adicionar e subtrair pois os ponteiros são adicionados a mais no loop
addi	a0 s2 4

LIGA_PONTOS_end:
flw 	fs0 28(sp)
lw 	s11 24(sp)
lw 	s10 20(sp)
lw 	s3 16(sp)
lw 	s2 12(sp)
lw 	s1 8(sp)
lw 	s0 4(sp)
lw 	ra 0(sp)
addi 	sp sp 32
ret


###########################################################################################
# print_LIGA_PONTOS
# ARGUMENTOS: a0 = ponteiro para inicio do vetor, a1 = frame a ser printada, a2 = ponteiro para as coordenadas
# @RETURN nada
###########################################################################################
print_LIGA_PONTOS:
addi 	sp sp -20
lw 	s3 16(sp)
lw 	s2 12(sp)
lw 	s1 8(sp)
lw 	s0 4(sp)
sw 	ra 0(sp)

mv 	s0 a0
addi 	s1 zero 0
li 	s2 N
mv 	s3 a2
mv 	a4 a1

mv 	t2 s0
lw 	t1 0(t2)
slli 	t3 s2 2
add	t2 t2 t3
sw 	t1 0(t2) 	# Armazena o primeiro ponto no fim do vetor

print_LIGA_PONTOS_for:
beq 	s1 s2 print_LIGA_PONTOS_for_end 	

lw 	t0 0(s0)  	# pega o valor da memoria
mv 	a0 s3		# Ponteiro para o vetor
mv 	a1 t0		# Posicao do vetor
call ACESSAR_VETOR

mv 	a2 a0		# a2 = x0
mv 	a3 a1		# a3 = y0

lw 	t0 4(s0)  	# pega o valor da memoria
mv 	a0 s3		# Ponteiro para o vetor
mv 	a1 t0		# Posicao do vetor
call ACESSAR_VETOR

# a0 = x1
# a1 = y1
# a2 = x0
# a3 = y0
li 	a4 0xff
li	a5 0
li 	a7 147
ecall

addi 	s0 s0 4 # proxima posicao do vetor
addi 	s1 s1 1
j	print_LIGA_PONTOS_for
print_LIGA_PONTOS_for_end:


sw 	s3 16(sp)
sw 	s2 12(sp)
sw 	s1 8(sp)
sw 	s0 4(sp)
lw 	ra 0(sp)
addi 	sp sp 20
ret
