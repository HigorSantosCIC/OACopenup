.data

.include "imgs\preparando.s"
.include "imgs\ML1.s"
.include "imgs\ML2.s"
.include "imgs\ML3.s"
.include "imgs\menu.s"
.include "imgs\frame0.s"

.text

menu0:	
li t1 0xFF000000	# endereco inicial da Memoria VGA - Frame 0
li t2 0xFF012C00	# endereco final 
la s1 preparando
addi s1 s1 8		# primeiro pixels depois das informações de nlin ncol
menu_loop: 	
beq t1 t2 menu_ml3
lw t3 0(s1)		
sw t3 0(t1)	
addi t1 t1 4
addi s1 s1 4
j menu_loop		

menu_ml3:	
li t1 0xFF000000	# endereco inicial da Memoria VGA - Frame 0
li t2 0xFF012C00	# endereco final 
la s1 ML3
addi s1 s1 8		# primeiro pixels depois das informações de nlin ncol
menu_ml3_loop: 	
beq t1 t2 menu_ml2
lw t3 0(s1)		
sw t3 0(t1)	
addi t1 t1 4
addi s1 s1 4
j menu_ml3_loop		

menu_ml2:	
li t1 0xFF000000	# endereco inicial da Memoria VGA - Frame 0
li t2 0xFF012C00	# endereco final 
la s1 ML2
addi s1 s1 8		# primeiro pixels depois das informações de nlin ncol
menu_ml2_loop: 	
beq t1 t2 menu_ml1
lw t3 0(s1)		
sw t3 0(t1)	
addi t1 t1 4
addi s1 s1 4
j menu_ml2_loop		

menu_ml1:	
li t1 0xFF000000	# endereco inicial da Memoria VGA - Frame 0
li t2 0xFF012C00	# endereco final 
la s1 ML1
addi s1 s1 8		# primeiro pixels depois das informações de nlin ncol
menu_ml1_loop: 	
beq t1 t2 menu_frame0
lw t3 0(s1)		
sw t3 0(t1)	
addi t1 t1 4
addi s1 s1 4
j menu_ml1_loop		

menu_frame0:	
li t1 0xFF000000	# endereco inicial da Memoria VGA - Frame 0
li t2 0xFF012C00	# endereco final 
la s1 frame0
addi s1 s1 8		# primeiro pixels depois das informações de nlin ncol
frame0_loop: 	
beq t1 t2 FIM
lw t3 0(s1)		
sw t3 0(t1)	
addi t1 t1 4
addi s1 s1 4
j frame0_loop		

draw_coord: 
li a7 147
li a0 105
li a1 5
li a2 314
li a3 235
li a4 0xAA
li a5 0
ecall

FIM:
li a7 10
ecall

