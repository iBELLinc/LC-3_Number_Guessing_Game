; 				#########################################
;				#	Number Guessing Game		#
; 				#	    A combined work by       	#
; 				#	 Cindy Cherry & Ian Bell	#
; 				#########################################
;
;		#################################################################
;		#			Registers: 				#
;		#    =================================================		#
; 		#   R0 = I/O			||	R4 = Tens Digit Sum	#
; 		#   R1 = Random Number	||	R5 =				#
; 		#   R2 = Counter		||	R6 = #-110		#
; 		#   R3				||	R7 = JUMP Addresses	#
; 		#################################################################
; 
; 
; 
;
;			#########################################################
;			#							#
;			#		NOTES 	KEY:				#
;			#							#
;			#  ===================================================	#
;			#							#
;			#	#### 	|	Major Boundary			#
;			#	===	|	Minor Boundary			#
;			#	------	|	Sub Boundary	(of # || =)	#
;			#	~hi~	|	Code Block Description		#
;			#							#
;			#########################################################
;
;

.ORIG x3000

			BRnzp GENERATOR 		; skip PLAY_AGIN first time through

; #########################################################################

PLAY_AGAIN 		LEA R0, Y		; load ascii value for ‘y’ into R0
			PUTC			; print ‘y’ to screen
			JSR LINEBREAK
			ADD R2, R2, #1		; increment random generator counter

; #########################################################################

GENERATOR		; PLACEHOLDER
			LD R7, RANDNUM
			JSRR R7			; GENERATOR Function Call
			; PLACEHOLDER

; #########################################################################

			LEA R0, PROMPT_FIRST_GUESS
			PUTS

INPUT_LOOP		GETC
			STR R0, DIGITS, #0			; get 10s place
			GETC
			STR R0, DIGITS, #1			; get 1s place
			JSR CALC_TENS				; calculate tens place value

			LDR R0, DIGITS, #1			; reload units into R0
			ADD R0, R0, R3				; add units + tens place = R0

								; ~R0 now holds dec value
								; in binary~


; TRY_AGAIN		IN 					; take in the user input value

; --------------------------------------------------------------------------------------------------------------------

								; ~Compare value with R1~

			NOT R0, R0
			ADD R0, R0, #1 		; Negative version of user input
			ADD R0, R1, R0 		; R0 - R1 = R0

; --------------------------------------------------------------------------------------------------------------------

				; IF statements
			BRz CORRECT
			BRn TOO_HIGH
			BRp TOO_LOW

; #########################################################################
								; ~Branches~

TOO_HIGH		LEA R0, PROMPT_TOO_HIGH
			PUTS
			JSR LINEBREAK
			BRnzp INPUT_LOOP		; TRY_AGAIN

; =================================================================

TOO_LOW			LEA R0, PROMPT_TOO_LOW
			PUTS
			JSR LINEBREAK
			BRnzp INPUT_LOOP		; TRY_AGAIN

; =================================================================

CORRECT 		LEA R0, PROMPT_CORRECT				; congratulate user
			PUTS
			JSR LINEBREAK

			LEA R0, PROMPT_PLAY_AGAIN			; ask user to play again
			PUTS
			BRnzp FIRST_INPUT				; jump to user input LOOP

			INPUT_ERROR	LEA R0, PROMPT_Y_OR_N
			PUTS
FIRST_INPUT		GETC						; get user input

; --------------------------------------------------------------------------------------------------------------------

								; ~evaluate user input~

			AND R6, R6, #0
			LD R6, N				; load R6 with -110
			ADD R0, R0, R6				; subtract 110 from R0
			BRz DONE				; if (R0 = 0) >> R0 = ‘n’

			ADD R0, R0, #-11			; if (R0 = 0)  >> R0 = ‘y’
			BRz PLAY_AGAIN
			BRnzp INPUT_ERROR			; input not valid

; #########################################################################

DONE 	NOT R6, R6, #1
	ADD R0, R0, R6 				; put R0 back to ascii value
	PUTC 					; print ‘n’ to screen
	JSR LINEBREAK
	LEA R0, PROMPT_STOP
	PUTS 					; “Thanks for playing!”
	HALT

; #########################################################################

LINEBREAK		AND R5, R5, #0		; zero R5
			ADD R5, R5, #10		; set R5 to newline char
			PUTC			; print to screen
			RET
			HALT			; just in case something goes wrong

; #########################################################################

CALC_TENS		LDR R4, DIGITS, #0		; load first digit into R4 as iterator
			AND R3, R3, #0			; 0 sum out
			ADD R3, R3, #10
			ADD R4, R4, #-1			; decrement iterator
			BRnz RET
			BRnzp CALC_TENS

; #########################################################################

Y				.FILL #121
N 				.FILL #-110
RANDNUM				.FILL x0000							; Generator Address Location

DIGITS				.BLKW #2							; Array for 2 digit number input

PROMPT_FIRST_GUESS 		.STRINGZ “Guess a number 0-100: ”
PROMPT_TOO_HIGH 		.STRINGZ “Too high. Guess again: ”
PROMPT_TOO_LOW 			.STRINGZ “Too low. Guess again: ”
PROMPT_CORRECT 			.STRINGZ “Congratulations! You found the number!”
PROMPT_PLAY_AGAIN 		.STRINGZ “Would you like to play again? (y or n): ”
PROMPT_Y_OR_N			.STRINGZ “Invalid input! Please enter either ‘y’ or ‘n’: ”
PROMPT_STOP 			.STRINGZ “Thanks for playing!”

.END
