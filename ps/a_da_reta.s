.data



.text
###########################################################################################
# coeficiente_angular
# ARGUMENTOS: a0 = ponteiro para o vetor, a1 = POSICAO 1, a2 = POSICAO 2
# OBS: ponto 1 deve ter o x maior
# @RETURN fa0 coeficiente angular
###########################################################################################
coeficiente_angular:
addi 	sp sp -20
sw 	s3 16(sp)
sw 	s2 12(sp)
sw 	s1 8(sp)
sw 	s0 4(sp)
sw 	ra 0(sp)

mv 	s4 a0  # ponteiro para o vetor
#	a1 = a1
call ACESSAR_VETOR

mv 	s2 a0 # x0 
mv	s3 a1 # y0

mv 	a0 s4
mv 	a1 a2
call ACESSAR_VETOR

mv s0 a0 #x1
mv s1 a1 #y1

sub t0 s1 s3 # y1 - y0
sub t1 s0 s2 # x1 - x0

fcvt.s.w ft0 t0 #converte  para float
fcvt.s.w ft1 t1 #converte para float
fdiv.s 	fa0 ft0 ft1 #divide e salva em a

coeficiente_angular_end:
lw 	s3 16(sp)
lw 	s2 12(sp)
lw 	s1 8(sp)
lw 	s0 4(sp)
lw 	ra 0(sp)
addi 	sp sp 20
ret
