.data



.text

A:
li s0 222 #x1
li s1 213 #y1
li s2 122 #x0
li s3 153 #y0

sub t0 s1 s3 # y1 - y0
sub t1 s0 s2 # x1 - x0

fcvt.s.w ft0 t0 #converte  para float
fcvt.s.w ft1 t1 #converte para float
fdiv.s fs0 ft0 ft1 #divide e salva em a

