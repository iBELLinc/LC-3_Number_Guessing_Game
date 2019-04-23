# LC-3_Number_Guessing_Game
## By Cindy Cherry &amp; Ian Bell
 
*This is the final project for CS2810 Computer Organization and Architecture class at Utah Valley University.*
 
### Purpose:
This project is a game in which the computer randomly generates a number based on a seed and the user tries to guess the number.
<br><br><br>
### Registers:
**R0** was used primarily for input/output though some calculations did occur using it. This always resulted in the calculated value being output to the screen.  
**R1** was used to store the value of the random number created by the random number generator  
**R5** was used to store the address of the user input array location so that user input could easily be stored or loaded from this array or .BLKW  
**R7** was used to store addresses for JSR and JSRR instructions. When loading subroutines outside of main, the value was saved in the subroutine so that it would not be lost during the subroutines' calculations and then reloaded prior to a RET statement.  
**R2-R4 & R6** were all used for various purposes throughout the program and subroutines. These registers did not have 1 specific purpose and were used to do calculations and load and store information or process offsets.
<br><br><br>
### Labels:
###### main.asm:
##### PLAY_AGAIN 
Loops the player back to the begining of the program so they can play again
##### INPUT_LOOP
Reset point for program to loop back to in the event that an input error occurs
<br><br>
##### TOO_HIGH
Branch to run when the number entered by user is too high
##### TOO_LOW
Branch to run when the number entered by user is too low
<br><br>
##### CORRECT
Branch to run when the user correctly guesses the random number
##### INPUT_ERROR
Called by the code at Firstt_Input when the user enters a character that is not 'y' or 'n'
##### FIRST_INPUT
Checks the character that the user entered to make sure it is either 'y' or 'n'. Based on answer it either halts the program or loops back to Play_Again to start the game over
<br><br>
##### DONE
Prints a "Thanks for playing!" message to the screen and halts the program
<br><br>
##### CALC_TENS
Calculates the decimal value of the tens digit input by the user
##### PLUS_TEN
Adds 10 to R3 for every iteration it goes through
##### RETURN
Returns PC back to the main program after the Calc_Tens subroutine finishes
<br><br>
###### welcome.asm:
N/A
<br><br>
###### random.asm:
##### AGAIN
Adds 311 until the seed number is 0
##### CheckPos
Checks that our random number value is positive ie the multiplication didn't go into a negative binary value
##### MakePos
Changes the random number to positive if the binary number did become negative
##### Pos
Makes sure we load R4 with -100
##### MOD100
Subtracts 100 until the number is negative then adds back 100 (ie integer division by 100)
##### NegateNum
Negates the value in R4 so we can add 100 back
<br><br>
###### test_input.asm:
##### TEST_INPUT
Extra unneeded label that marked the begining of the Test_Input code when it was part of the main.asm file
##### GOOD_INPUT
Branch label for the subroutine to branch to when the input is deemed a valid number character (0-9)
##### BAD_INPUT
Branch label for the subroutine to branch to when the input is deemed a non valid number character (anything other than 0-9)
<br><br>
###### linebreak.asm:
N/A
<br><br><br>
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
<br><br><br>
### TESTS:
###### Test 1
Prior to adding the number generator code a single line stating `ADD R1, R1, #10` was used to initialize R1 (the random number) to the decimal value 10 to make sure all the code in the main program as well as the subroutines for testing input were all functioning correctly.
###### Test 2
Added the random number generator code and tested it multiple times on two different machines to make sure:
1. The numbers at the start of each individual game were random
2. The program was accurately identifying user input errors and prompting the user to try again
3. The program was able to properly loop and generate a new random number for the second iteration of the game
4. The program was accurately calculating whether the user's input was equivalent to the random number generated
<br><br><br>
### Additional Info:
Project written in LC-3 Assembly Language and tested in the LC-3 simulator available for free here: https://wchargin.github.io/lc3web/
