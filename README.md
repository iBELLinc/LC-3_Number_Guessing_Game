# LC-3_Number_Guessing_Game
## By Cindy Cherry &amp; Ian Bell
 
*This is the final project for CS2810 Computer Organization and Architecture class at Utah Valley University.*
 
### Purpose:
This project is a game in which the computer randomly generates a number based on a seed and the user tries to guess the number.

=================================================================
|                         			Registers: 				                    |
|    =================================================		        |
|              R0 = I/O			         ||	R4 = 			                  |
|              R1 = Random Number		||	R5 = DIGITS Pntr	         |
|              R2 =			             ||	R6 = 			                  |
|              R3	=		              ||	R7 = JUMP Addresses	      |
#################################################################

### Labels:
##### main.asm:
###### PLAY_AGAIN 
Loops the player back to the begining of the program so they can play again

###### INPUT_LOOP
Reset point for program to loop back to in the event that an input error occurs

###### TOO_HIGH
Branch to run when the number entered by user is too high
###### TOO_LOW
Branch to run when the number entered by user is too low

###### CORRECT
Branch to run when the user correctly guesses the random number
###### INPUT_ERROR
Runs when the user enters a character that is not within 0-9
###### FIRST_INPUT


###### DONE

###### CALC_TENS
###### PLUS_TEN
###### RETURN

##### welcome.asm:
N/A

##### random.asm:
###### AGAIN
###### CheckPos
###### MakePos
###### Pos
###### MOD100
###### NegateNum

##### test_input.asm:
###### TEST_INPUT
###### GOOD_INPUT
###### BAD_INPUT

##### linebreak.asm:
N/A

### HOW TO PLAY:
- User recieves prompt for input of a two digit number
- User must enter a 2 digit (ex. 00) number
- If user fails to enter two numbers, either first of second digit, they will be prompted to try inputing again from the first digit
- If input is correct the program will check the user's guess verses the actual number
- If correct the program will congratulate the user
- If incorrect the program will prompt the user to guess again
- When the answer is correct the program will ask the user if they want to play again
- Choosing 'y' will loop the game back to the begining with the program picking a new random number
- Choosing 'n' will end the program, thanking the user for playing
- If the user enters anything other than 'y' or 'n', the program will loop back inform the user that their input was invalid and prompt the user to enter either 'y' or 'n'

### TESTS:


### Other Info:
Project written in LC-3 Assembly Language and tested in the LC-3 simulator here: https://wchargin.github.io/lc3web/
