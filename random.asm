;Random Number Generator
.ORIG x4000

ST	R7, SaveR7	;Saves our Return Address

LD	R3, Num1	;Fills with 311
LD	R6, Num2	;Fills with 61
ADD	R4, R3, #0	;Puts 311 into R4 as well

ADD R1, R1, #-1		;incrament the seed by 1
AGAIN 	ADD R3, R4, R3		;Adds 311 to 311
ADD R1, R1, #-1		;Until R1 = 0;
BRp AGAIN
ADD R3, R3, R6		;Adds 61 to our Random number
	
LD  R4, Num4		;Load R4 with x7FFF which is the biggest positive number you can multiply
CheckPos ADD R4, R4, R3		;Adds R4 to our random number to check that it is positive
BRp MakePos		;if we add these numbers and get a pos then our seed is negative so we make it positive
BRnz Pos		;Otherwise it is already positive

MakePos	ADD R3, R3, R4		;if it's not positive we change it to a positive number
	
Pos	LD  R4, Num3		;We load R4 with #-100
MOD100 	ADD R3, R3, R4		;add -100 until the random number is negative
BRp MOD100
JSR NegateNum		;negate -100 so now its 100
ADD R3, R3, R4		;add back to R3 so R3 is positive
ADD R1, R3, #0		;Put the random number in R1

LD      R7, SaveR7	;Load the return address
RET
HALT

NegateNum	NOT 	R4, R4		;Negates R4
ADD	R4, R4, #1	
RET

Num1	.FILL	#311
Num2	.FILL	#61
Num3	.FILL	#-100
Num4	.FILL	x7FFF
SaveR7	.FILL	x0000 
   
.END 
