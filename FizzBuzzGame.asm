TITLE template
;Author: Brandon Nhep
;last date modified: 4/12/2024
;Course Number/Section: CIS 231
;Assignment Number/Name: FizzBuzzGame
;Write a MASM code that will print the typical round of 
;the FizBuzz Game up to the number 46 (range 1- 46). Then modify 
;the code to ask the user to enter the range of numbers you want 
;to start with and stop the game. Validate your entries, make sure 
;both are positive integers, and the second number is greater than 
;the first number.
;Use functions for the game, for validation, for getting the values.
;Make sure that main has a one function call (to play the game)

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; declare variables here
intNum    DWORD 1
intNum2    DWORD 46
GameButton DWORD ?

playGame BYTE "Would you like to play the FizzBuzzGame? ",0
promptBad BYTE "Invalid entry try again. Enter a positive integer: ",0
promptNegative BYTE "Invalid entry. We ask for a positive integer: ",0
promptEnterFirst BYTE "Enter your starting number: ",0
promptEnterSecond BYTE "Enter your final number: ",0

fizzPrompt BYTE "Fizz ",0
buzzPrompt BYTE "Buzz ",0
fizzBuzzPrompt BYTE "Fizz Buzz ",0


EnterMenu1 BYTE "Enter 1 to Play a Typical game (Range:1-46) ",0
EnterMenu2 BYTE "Enter 2 to Play a Custom game (Insert a Range) ",0
EnterMenu0 BYTE "Enter 0 to Exit and not play the game ",0
MenuError BYTE "Invalid entry try again. Please Enter 1 or 2 or 0: ",0
userEntry BYTE "Enter your number: ",0

NoSwap BYTE "Second Number is Less Than the First. Please Try Again. ",0
pleaseEnter0 BYTE "Enter a number that is 1 or Greater: ",0


.code
main PROC

call StartGame
INVOKE ExitProcess,0

main ENDP
; (insert additional procedures here)
StartGame PROC
;This procedure will call the MainMenu proc
;to open a menu for the user
;and prompting them to enter numbers 1,2, or 0 
;each number leads to a different procedure
;such as a typical game, custom game or exit game
;preconditions: Gamebutton memory initialized
;postcondition: output the menu for the user
;Registers modified: none
        ; Output message to prompth the user to play the game
            mov  edx,OFFSET playGame
            call WriteString
            call Crlf
            call MainMenu

StartGame ENDP

EnterAndValidate PROC
;This procedure will validate the user's input
;for the custom game. Checking if the user has
;input a postitive integer and that it is greater
;than 0. Else it will loop and warn the user to 
;input the integers again.
;preconditions: none
;postcondition: Initialized the memory variables of
;the first number and second number.
;Registers modified: edx, eax
    enterSignal:

            ;Output message for user to enter the first number
            mov  edx,OFFSET promptEnterFirst
            call WriteString
    read:
            call ReadInt
            ;jumps to negative number if no overflow
            ;if overflow loop to read again
            jno  negativeNumber
    
            mov  edx,OFFSET promptBad
            call WriteString

            jmp  read        ;go input again


    negativeNumber:
            ;Checks if number is not negative signed if so then jump to goodinput
            ;if it is signed then loop back to read
            jns goodInput
            mov  edx,OFFSET promptNegative
            call WriteString
            jmp  read       ;go input again
        
    goodInput:
            ;Check if user enterered a 1 or greater for first number
            mov  intNum,eax  ;store good value
            cmp intNum, 1   ;makes sure first input is 1 or greater
            jl enterSignal2
            ;jump to second input stream when 
            ;user enters a 1 or greater
            ;
            call Crlf
            mov  edx,OFFSET promptEnterSecond
            call WriteString
            jmp read2
    enterSignal2:
            ;repeat the loop for user to enter a 1 or greater
            ;output a message saying to enter 1 2 or 0
            mov  edx,OFFSET pleaseEnter0
            call WriteString
            jmp read


    read2:
            ;jumps to negative number if no overflow
            ;if overflow loop to read again
            call ReadInt
            jno  negativeNumber2   
            mov  edx,OFFSET promptBad
            call WriteString
            jmp  read2        ;go input again


    negativeNumber2:
            ;Checks if number is not negative signed if so then jump to goodinput
            ;if it is signed then loop back to read
            jns goodInput2
            mov  edx,OFFSET promptNegative
            call WriteString
            jmp  read2       ;go input again

    goodInput2:     
            mov  intNum2,eax  ;store good value
EnterAndValidate ENDP

ValidateGreater PROC
;Validate if user's entry for second number is less than
;the first number, if so then loop for user to enter again
;User entry will be validated when the second number is greater
;than the first number
;preconditions: Initialized memory variables for the first and 
;second number in order for this procedure to function
;postcondition: Re-initializing memory variables due to value
;checking if needed.
;Registers modified: eax, ebx, edx
    validateLoop:
        mov eax, intNum
        mov ebx, intNum2

        ;compares ebx to eax
        ;if it is greater or equal the numbers are perfect(re-entry not needed)
        ;else if it less than or equal jump to greater branch
        ;loop the user entry and validation again until correct entries
        cmp ebx, eax
        jge perfect
        jle greater


    greater:
        call Clrscr
        mov  edx,OFFSET NoSwap
        call WriteString
        call Crlf
        call EnterAndValidate
        jmp validateLoop
    perfect:
        
ValidateGreater ENDP

CheckFizzBuzz PROC
;Checks each value from user's starting number to ending number
;to see if they are divisible by 15(if so print FizzBuzz), divisble
;by three(print Fizz) or divisible by 5(print buzz). Print's each
;integer within the range with appropriate replacement
;preconditions: Initialized memory variables for the first and 
;second number in order for this procedure to function
;postcondition: Output's each integer within the range
;also replaced the integer if divisible validation is met.
;Registers modified: eax, ebx, edx, ecx
        ;This branch verifies the divisible values of each
        ;number in the range of the user's entry
        ;integers from first number to second number
        mov eax, 0            ;Reset eax to 0
        mov ebx, intNum       ;store the first num to ebx
        call Crlf

    CheckEntries:
        ;Check if number within the range is divisible by 15
        mov eax, ebx
        cdq
        mov ecx, 15
        idiv ecx
        cmp edx, 0
        ;if so then jump to fizzbuzzchange to output a FizzBuzz
        ;instead of an integer
        je FizzBuzzChange

        ;Check if number within the range is divisible by 3
        mov eax, ebx
        cdq
        mov ecx, 3
        idiv ecx
        cmp edx, 0
        je FizzChange

        ;Check if number within the range is divisible by 5
        mov eax, ebx
        cdq
        mov ecx, 5
        idiv ecx
        cmp edx, 0
        je BuzzChange


        myWrite:
        ;if none are divisible by 15, 3, or 5 output the integer
        mov eax, ebx            
        call WriteDec
        jmp myLoop

    FizzChange:
                ;Outputs "Fizz" instead of an integer
                mov  edx,OFFSET fizzPrompt
                call WriteString
                jmp myLoop

    BuzzChange:
                ;Outputs "Buzz" instead of an integer
                mov  edx,OFFSET buzzPrompt
                call WriteString
                jmp myLoop

    FizzBuzzChange:
                ;Outputs "FizzBuzz" instead of an integer
                mov  edx,OFFSET fizzBuzzPrompt
                call WriteString
                jmp myLoop


    myLoop:
                ;inc ebx to be next value to validate
                ;checks if the counter is less than or equal
                ;to user's final number entry if so then continue the loop else continue
                call Crlf
                inc ebx                 
                cmp ebx, intNum2        
                jle CheckEntries        

CheckFizzBuzz ENDP


MainMenu PROC
;Main menu for user to choose if they would like to exit, play
;a typical game 1-46 or a custom game with their own range entry
;The menu prompts the user an option for each menu item; validates
;the entry and also endlessly loops until the user chooses to exit.
;preconditions: none
;postcondition: User chooses the option 0 to exit, If user chooses
;the option for typical game memory variables for user's entry will
;be initialized with 1 and 46 then printed out through the CheckFizzBuzz
;procedure. If user chooses custom; input validation proceeds and also
;print out numbers through the CheckFizzBuzz procedure.
;Registers modified: eax, edx
    MenuLoop:
        ;Output the menu for user to choose whether or not 
        ;they want to play a typical game(1-46) or a custom
        ;game with their own entry. If not then they can choose
        ;to exit the game
        call Crlf
        mov  edx,OFFSET EnterMenu1
        call WriteString
        call Crlf
        mov  edx,OFFSET EnterMenu2
        call WriteString
        call Crlf
        mov  edx,OFFSET EnterMenu0
        call WriteString
        call Crlf
        mov  edx,OFFSET userEntry
        call WriteString

    MenuEntry:
        ;Input stream for the menu, user must enter 1, 2 , or 0
        call ReadInt
        ;jumps to negative number if no overflow
        ;if overflow loop to read again
        jno  negativeNumber
        mov  edx,OFFSET MenuError
        call WriteString
        jmp  MenuEntry        ;go input again

    negativeNumber:
        ;Checks if number is not negative signed if so then jump to goodinput
        ;if it is signed then loop back to read
        jns goodInput
        mov  edx,OFFSET MenuError
        call WriteString
        jmp  MenuEntry       ;go input again
        
    goodInput:
        ;Validates if user has entered a 0, 1 or 2 for the menu else 
        ;they would need to enter the number again
        mov  GameButton,eax  ;store value into gamebutton memory
        cmp GameButton, 0
        je MenuEqual
        cmp GameButton, 1
        je MenuEqual1
        cmp GameButton, 2
        je MenuEqual2
    
        call Clrscr
        mov  edx,OFFSET MenuError
        call WriteString
        jmp MenuLoop

    MenuEqual:
            ;If user chooses to enter a 0 the program exits
            Exit
    MenuEqual1:
            ;If user chooses to enter a 1 the program will
            ;initialize the starting number with 1 and ending number with 46
            ;It will check each number within the range and output the values
            ;with the appropriate Fizz, Buzz or FizzBuzz. Loops back to the menu.
            call Clrscr
            mov intNum, 1
            mov intNum2, 46
            call CheckFizzBuzz
            jmp MenuLoop
    MenuEqual2:
            ;If User chooses to enter a 2 the program will
            ;ask the user to enter a starting and ending number.
            ;It will then validate if the second number is greater
            ;It will check each number within the range and output the values
            ;with the appropriate Fizz, Buzz or FizzBuzz. Loops back to the menu.
            ;Loops back to menu.
            call Clrscr
            call EnterAndValidate
            call ValidateGreater
            call CheckFizzBuzz
            jmp MenuLoop

MainMenu ENDP

END main