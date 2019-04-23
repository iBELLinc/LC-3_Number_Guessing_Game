.ORIG x3150

TEST_INPUT			ST R7, RETURN_FROM_TEST
				AND R3, R3, #0
				AND R6, R6, #0
				LD R3, TO_BINARY
			
				ADD R0, R0, R3 				                                  ; Check if less than 0
				BRn BAD_INPUT 				                                  ; If R0 < 0 then R0 is not a number
			
				ADD R0, R0, #-9 			                                  ; Check if greater than 9
				BRp BAD_INPUT 				                                  ; If R0 > 0 then R0 is not a number
                    
				LD R3, TO_ASCII                                         ; Convert back to ascii for printing
				ADD R0, R0, R3
			
GOOD_INPUT			LD R7, RETURN_FROM_TEST
				RET

BAD_INPUT			LD R7, LINEBREAK
				JSRR R7
				LEA R0, NOT_A_NUMBER
				PUTS
                    		
				LD R7, RETURN_FROM_TEST
				ADD R6, R6, #-1
				RET
			
				HALT

TO_BINARY			.FILL #-48
TO_ASCII			.FILL #57
LINEBREAK			.FILL x3200
			
RETURN_FROM_TEST		.BLKW #1

NOT_A_NUMBER			.STRINGZ "Please only enter digits from 0-9: "

.END
