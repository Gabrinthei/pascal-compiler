MOV SP D0
ADD SP #2 SP
RD 1(D0)
PUSH #1 
POP 0(D0) ;Putting 1 into I
L0:
BEQ 1(D0) 0(D0) L1
PUSH 0(D0)
WRTLNS
PUSH #1 
PUSH 0(D0)
ADDS
POP 0(D0) ;God dammit
BR L0
L1:
MOV D0 SP
HLT
