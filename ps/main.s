.eqv N 20

.data

x: .string " x: "
y: .string " y: "


.text


## S11 = N
## S10 = Vetor

MAIN: 
la 	t0 exceptionHandling
csrw 	t0 utvec
csrwi	ustatus 1

li 	s11 N
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
call POSICAO$SHOW

mv 	a0 s10
li 	a1 N
call liga_pontos

# a0 ponteiro do inicio do vetor
addi 	a1 zero 0
mv	a2 s10
call print_liga_pontos

li a7 10
ecall























.include "funcoes.s"
.include "a_da_reta.s"
.include "SYSTEMv17b.s"
