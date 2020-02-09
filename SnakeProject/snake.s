.data
msg1: 	.string "SNAKE "
roda_pe: .string "OAC VERAO"
msg_start: .string "Inicializando o jogo: "
msg_high: .string "HIGHSCORE:"
msg_speed: .string "Level Speed:"
buffer: .string "                                "

.text
la t0,exceptionHandling	# carrega em tp o endere?o base das rotinas do sistema ECALL
csrw t0,utvec 		# seta utvec para o endere?o tp
csrsi ustatus,1 	# seta o bit de habilita??o de interrup??o em ustatus (reg 0)																																																				

jal CLS
jal str_snake
jal str_start
jal str_roda
jal SLEEP
jal CLS
jal str_snake
jal str_roda
jal str_high
jal str_speed
jal str_score_int
jal str_speed_int

jal botton_bord
jal left_bord
jal right_bord
jal top_bord

##### na funcao str score int t0 = pontuacao
# na funcao str speed t1 = pontuacao

li a7 10
ecall
																																		
# CLS Clear Screen
CLS:
li a0,0x00
li a7,148
li a1,0
ecall
ret
	
CLSV:	
li a7,141
ecall
li a7,148
li a1,0
ecall
ret

#########################
# a1 =  X (0 ate 320)   #
# a2 =  Y (0 ate 240)   #
######################### 		

# syscall "SNAKE"
str_snake: 
li a7,104
la a0,msg1
li a1,2
li a2,0
li a3,0x0038
li a4,0
ecall
ret		

# sycall "msg_start"
str_start: 
li a7,104
la a0, msg_start
li a1 80
li a2 102
li a3,0x0038
li a4,0
ecall
ret		

#sycall "HIGHSCORE"
str_high: 
li a7,104
la a0, msg_high
li a1 2
li a2 70
li a3,0x0038
li a4,0
ecall
ret		

#sycall "LEVEL SPEED"
str_speed: 
li a7,104
la a0, msg_speed
li a1 2
li a2 106
li a3,0x0038
li a4,0
ecall
ret		

#sycall "RODA PE"

str_roda:
li a7,104
la a0, roda_pe
li a1 2
li a2 230
li a3,0x0038
li a4,0
ecall
ret		

# syscall sleep
SLEEP:	
li t0, 2
LOOPHMS:
li a0,1000   # 1 segundo
li a7,132
ecall
addi t0,t0,-1

#print seg
mv a0,t0
li a7,101
li a1,162
li a2,112
li a3,0x0038
li a4,0
ecall
bne t0,zero,LOOPHMS	
ret

#syscall pontuacao
str_score_int:
li t0 0
li a7 101
mv a0 t0
li a1 2
li a2 90
li a3 0x0038
li a4 0
ecall 
ret

str_speed_int:
li t1 0
li a7 101
mv a0 t1
li a1 2
li a2 128
li a3 0x0038
li a4 0
ecall 
ret

#Draw map
left_bord:
li a7 147
li a0 105
li a1 5
li a2 105
li a3 235
li a4 0x0038
li a5 0
ecall
ret

top_bord:
li a7 147
li a0 105
li a1 5
li a2 314
li a3 5
li a4 0x0038
li a5 0
ecall
ret

right_bord:
li a7 147
li a0 314
li a1 5
li a2 314
li a3 234
li a4 0x0038
li a5 0
ecall
ret

botton_bord:
li a7 147
li a0 105
li a1 234
li a2 314
li a3 234
li a4 0x0038
li a5 0
ecall
ret










.include "SYSTEMv17b.s"

