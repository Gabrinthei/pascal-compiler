MOV SP D0
ADD SP #3 SP
RD 2(D0)
PUSH #0
POP 1(D0)
PUSH #0
POP 0(D0)
L0:
PUSH 0(D0)
PUSH 1(D0)
ADDS
POP 0(D0)
PUSH 1(D0)
PUSH #1
ADDS
POP 1(D0)
PUSH 1(D0)
WRTS
PUSH 0(D0)
WRTLNS
BLE 1(D0) 2(D0) L1
BGT 1(D0) #100 L1
BR L0
L1:
MOV D0 SP
HLT
