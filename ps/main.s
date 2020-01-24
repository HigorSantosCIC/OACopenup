.data

x: .string "x: "
y: .string " y: "


.text

MAIN: 
lw a0 VETOR
jal SORTEIO	

		
la a0 VETOR
jal SORT
	
li a0 5	
ebreak
call POSICAO$SHOW

li a7,10
ecall























.include "funcoes.s"
