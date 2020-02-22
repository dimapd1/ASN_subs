;
; AssemblerApplication1b.asm
;
; Created: 2/21/2020 6:35:10 PM
; Author : danra
;


.org 0x00
sub r3, r3		;checker if div3 == TRUE
sub r7, r7		;			div7 ==  TRUE		
ldi r20, 0		; div3==F & div7 ==F
sub r15, r15		;array position
ldi r19, 200			;200 int inputs		- counter
ldi r16, 26				;starting value
LDI XL, low(0x300)		;address to store lower half
LDI XH, high(0x300)		;					upper half
init:													;initialize 200 numbers from 26-225
ST X, r16				;store int to mem space
inc XL					;go to next mem alloc/addr
inc r16					;get next num, input
dec r19					;decrement counter
brne init



LDI XL, low(0x300)
LDI XH, high(0x300)
LDI YL, low(0x500)
LDI YH, high(0x500)
ldi r19, 200
ldi r16, 26

div7:
ldi ZL, low(0x600)
ldi ZH, high(0x600)
ld r1, X			;r1 = arr[0]
ldi r17, 7				;r17 = 7
lp7:
sub r1, r17				;r1 = arr[0] - 7
breq zero7				;if no remainder, divisible by 7
brpl lp7				;keep loop unless have remainder
jmp notdiv7								;go here if negative, not div by 7

zero7:		;test code, arr[i] is divisible by 7
inc r7
ld r1, X				;r1 = arr[0]
st Y, r1				;store to 0x500 for div7
jmp div3

notdiv7	:								;check if div by 3
dec r7
div3:
ld r1, X				;r1 = arr[0]
ldi r17, 3				;r17 = 3
lp3:
sub r1, r17				;r1 = arr[0] - 3
breq zero3				;if no remainder, divisible by 3
brpl lp3				;keep loop unless have remainder
jmp notdiv3								;go here if negative, not div by 7

notdiv3:
dec r3
jmp final_checking

zero3:
inc r3
ld r1, X				;r1 = arr[0]
st Z, r1				;store to 0x600 for div7

final_checking:

dec r7
brmi skip
dec r3
brpl both
jmp nextnum

both:
ldi ZL, low(0x700)		;store both to 0x700
ldi ZH, high(0x700)
add ZL, r15
ld r1, X
st Z, r1	
jmp nextnum

skip:
dec r3
brpl nextnum
ldi ZL, low(0x800)			;store else to 0x800
ldi ZH, high(0x800)
add ZL, r15
ld r1, X
st Z, r1


nextnum: 
sub r3, r3		;checker if div3 == TRUE
sub r7, r7		;			div7 ==  TRUE
inc r15			;i++
inc XL
dec r19
breq exit
jmp div7

exit:
jmp exit						;****part 1 and part 2 done*****
								;part 3, do sums
;yeah...lost on how im gonna do this part.

