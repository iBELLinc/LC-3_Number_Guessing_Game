.ORIG         x3200
              
LINEBREAK		  ST R7, RETURN_FROM_BREAK
              AND R0, R0, #0		              ; zero R5
			        ADD R0, R0, #10		              ; set R5 to newline char
			        OUT			                        ; print to screen
              
			        LD R7, RETURN_FROM_BREAK
			        RET
              
			        HALT
              
              RETURN_FROM_BREAK	.BLKW #1
             
.END
