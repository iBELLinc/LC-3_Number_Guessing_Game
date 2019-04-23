; 				#########################################
;				#	  Number Guessing Game		#
; 				#	   A combined work by       	#
; 				#	 Cindy Cherry & Ian Bell	#
; 				#########################################
;
;		#################################################################
;		#			Registers: 				#
;		#    =================================================		#
; 		#   R0 = I/O			||	R4 = 			#
; 		#   R1 = Random Number		||	R5 = DIGITS Pntr	#
; 		#   R2  			||	R6 = 			#
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

			LD R7, WELCOME
			JSRR R7				; print welcome message

; #########################################################################

PLAY_AGAIN		LD R1, RANDOM
			LD R7, RANDNUM
			JSRR R7			; GENERATOR Function Call
			ST R1, RANDOM

; #########################################################################

			LEA R5, DIGITS
			LEA R0, PROMPT_FIRST_GUESS
			PUTS

INPUT_LOOP		LD R4, TO_BINARY
			GETC
			LD R7, TEST_INPUT
			JSRR R7
			ADD R6, R6, #0
			BRn INPUT_LOOP
			
			OUT				; print 10s digit
			
			ADD R0, R0, R4
			STR R0, R5, #0			; save 10s digit
			GETC
			LD R7, TEST_INPUT
			JSRR R7
			ADD R6, R6, #0
			BRn INPUT_LOOP
			
			OUT				; print 1s digit
			
			ADD R0, R0, R4
			STR R0, R5, #1			; save 1s digit
			LD R7, LINEBREAK
			JSRR R7
			JSR CALC_TENS			; calculate tens place value

			LDR R0, R5, #1			; reload units into R0
			ADD R0, R0, R3			; add units + tens place = R0

							; ~R0 now holds dec value in ascii~

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
			BRnzp INPUT_LOOP		; TRY_AGAIN

; =================================================================

TOO_LOW			LEA R0, PROMPT_TOO_LOW
			PUTS
			BRnzp INPUT_LOOP		; TRY_AGAIN

; =================================================================

CORRECT 		LEA R0, PROMPT_CORRECT				; congratulate user
			PUTS
			
			LD R7, LINEBREAK
			JSRR R7
			LD R7, LINEBREAK
			JSRR R7

			LEA R0, PROMPT_PLAY_AGAIN			; ask user to play again
			PUTS
			BRnzp FIRST_INPUT				; jump to user input LOOP

INPUT_ERROR		LD R7, LINEBREAK
			JSRR R7
			LEA R0, PROMPT_Y_OR_N
			PUTS
FIRST_INPUT		GETC						; get user input
			OUT

; --------------------------------------------------------------------------------------------------------------------

											; ~evaluate user input~

			AND R6, R6, #0
			LD R6, N							; load R6 with -110
			ADD R0, R0, R6							; subtract 110 from R0
			BRz DONE							; if (R0 = 0) >> R0 = ‘n’

			ADD R0, R0, #-11						; if (R0 = 0)  >> R0 = ‘y’
			BRz PLAY_AGAIN
			BRnzp INPUT_ERROR						; input not valid

; #########################################################################

DONE 		NOT R6, R6
		ADD R6, R6, #1
		ADD R0, R0, R6 				; put R0 back to ascii value
		OUT 					; print ‘n’ to screen
		LD R7, LINEBREAK
		JSRR R7
		LEA R0, PROMPT_STOP
		PUTS 					; "Thanks for playing!"
		
		HALT

; #########################################################################

CALC_TENS		AND R3, R3, #0			; prep sum register
			LDR R4, R5, #0			; load first digit into R4 as iterator
			;LD R3, TO_BINARY
			;ADD R4, R4, R3			; Convert R4 to ascii
			BRz RETURN
			
PLUS_TEN		ADD R3, R3, #10
			ADD R4, R4, #-1			; decrement iterator
			BRnz RETURN
			BRnzp PLUS_TEN
RETURN			RET

; #########################################################################

Y				.FILL #121
N 				.FILL #-110
TO_BINARY			.FILL #-48
WELCOME				.FILL x3500
RANDNUM				.FILL x4000							; Generator Address Location
LINEBREAK			.FILL x3200
TEST_INPUT			.FILL x3150

RANDOM				.BLKW #1
DIGITS				.BLKW #2							; Array for 2 digit number input

PROMPT_FIRST_GUESS 		.STRINGZ "Guess a two digit number (01-99): "

PROMPT_TOO_HIGH 		.STRINGZ "Too high. Guess again: "
PROMPT_TOO_LOW 			.STRINGZ "Too low. Guess again: "
PROMPT_CORRECT 			.STRINGZ "Congratulations! You found the number!"

PROMPT_PLAY_AGAIN 		.STRINGZ "Would you like to play again? (y or n): "

PROMPT_Y_OR_N			.STRINGZ "Invalid input! Please enter either 'y' or 'n': "

PROMPT_STOP 			.STRINGZ "Thanks for playing!"

.END
