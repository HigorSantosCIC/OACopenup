.eqv N 3

.data

x: .string " x: "
y: .string " y: "

.text

## S11 = N
## S10 = Vetor
##MEU A6 É O N DEUS

MAIN: 
la 	t0 exceptionHandling
csrw 	t0 utvec
csrwi	ustatus 1
li 	s6 N

addi a6 zero 20


loop_main:

beq s6 a6 end_int
jal clear_screen

add 	s11 s11 s6
slli 	t0 s11 2
sub 	sp sp t0  	#Alocando espaço na pilha para o vetor
add 	s10 zero sp 	# Ponteiro para o vetor

add 	s2 s10 zero
add 	s4 s11 zero
jal SORTEIO	

add	a0 zero s10
add 	a1 zero s11
jal SORT

add 	a1 zero s10
add 	a0 zero s11
call POSICAO_SHOW

mv 	a0 s10
add a1 zero s6
call LIGA_PONTOS

# a0 ponteiro do inicio do vetor
addi 	a1 zero 0
mv	a2 s10
call print_LIGA_PONTOS
addi	s6 s6 1

li a0 10
li a7 32
ecall

call loop_main

end_int:
li a7 10
ecall












.include "funcoes.s"
.include "a_da_reta.s"
.include "SYSTEMv17b.s"
