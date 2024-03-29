TITLE template
;Author: Brandon Nhep
;last date modified: 3/27/2024
;Course Number/Section: CIS 231
;Assignment Number/Name: LabW9-Labw9
;Write an interactive assembly code using MASM, that asks the user to enter two integer values,
;gets each value, and makes sure that each one is a valid, positive integer.
;Then the code should calculate and output the summation of all the integer values between the
;two entered integers.

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; declare variables here
intNum    DWORD ?
intNum2    DWORD ?
Sum    DWORD ?

promptBad BYTE "Invalid entry try again. Enter a positive integer: ",0
promptNegative BYTE "Invalid entry. We ask for a positive integer: ",0
promptEnter BYTE "Please enter two positive integers and I will give you the sum of all integers between them(including the entered integers). ",0

promptEnterFirst BYTE "Enter the first one: ",0
promptEnterSecond BYTE "Enter the second one: ",0

promptSwapMessage BYTE "Upper Limit (Second Number) ",0
promptSwapMessage1 BYTE " is less than the Lower Limit (First Number) ",0

promptSwap1 BYTE "Currently Swapping the two values ",0
promptSwap2 BYTE "Numbers entered correctly. No swap needed. ",0

promptSwapComplete BYTE "Lower Limit (First Number) is now: ",0
promptSwapComplete1 BYTE "Upper Limit (Second Number) is now: ",0

promptSummation BYTE "The running total integer from ",0
promptSummation1 BYTE " and ",0
promptSummation2 BYTE " is ",0
.code
main PROC
; Output message to prompth the user to enter
    mov  edx,OFFSET promptEnter
    call WriteString
    call Crlf
    call Crlf


;Input Stream for the user's First number
;
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
    mov  intNum,eax  ;store good value
    

;Input Stream for the user's second number
;
;
    call Crlf
    mov  edx,OFFSET promptEnterSecond
    call WriteString
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


;Swap numbers
;Swap numbers if second number is less than the first

    mov eax, intNum
    mov ebx, intNum2

    ;compares ebx to eax
    ;if it is greater or equal to not swap
    ;else if it less than or equal jump to swap
    cmp ebx, eax
    jge notSwap
    jle swap

swap:

    ;Output message for user to know
    ;when a swap has begun
    call Crlf
    mov  edx,OFFSET promptSwapMessage
    call WriteString

    mov eax, intNum2    ;output the upper limit
    call WriteDec

    mov  edx,OFFSET promptSwapMessage1
    call WriteString

    mov eax, intNum    ;output the lower limit
    call WriteDec

    ;Output message for user to know
    ;when a swap has begun
    call Crlf
    mov  edx,OFFSET promptSwap1
    call WriteString

    ;Restoring memory values in eax and ebx
    mov eax, intNum
    mov ebx, intNum2
    ;Initiate swap by temporarily storing 
    ;eax to ecx, and taking the second number
    ;to store into eax, then take the first number stored
    ;in ecx to ebx

    mov ecx, eax
    mov eax, ebx
    mov ebx, ecx

    ;This will store the new values in global memory 
    ;intNum and intNum2 for further use in the main proc
    mov intNum, eax
    mov intNum2, ebx

    ;output the message showing the result of the swap
    call Crlf
    call Crlf
    mov  edx,OFFSET promptSwapComplete 
    call WriteString
    mov eax, intNum
    call WriteDec

    call Crlf
    mov  edx,OFFSET promptSwapComplete1
    call WriteString
    mov eax, intNum2
    call WriteDec

    jmp findSum


notSwap:
    ;Output a message when swap is not needed 
    ;That means the second number is greater than the first
    call Crlf
    mov  edx,OFFSET promptSwap2
    call WriteString

findSum:

    ;This branch calculates the summation of the entered
    ;integers from first number to second number
    mov eax, sum            ;create a sum eax = 0
    mov ebx, intNum         ;store the first num to ebx
    mov ecx, intNum2        ;store the second number to ecx
    sub ecx, intNum         ;create the loop iterations High - low + 1
    inc ecx
    Summation:
        add eax, ebx        ; sum = sum + ebx
        inc ebx             ; inc ebx to be next value to add
        loop Summation      ; loops until ecx == 0
        mov sum, eax

    ;Outputs a message showing the numbers Entered and the total
    ;summation from the first number to the second number
    call Crlf
    call Crlf
    mov  edx,OFFSET promptSummation 
    call WriteString

    mov eax, intNum         ;outputs the first number
    call WriteDec

    mov  edx,OFFSET promptSummation1
    call WriteString

    mov eax, intNum2        ;outputs the second number
    call WriteDec

    mov  edx,OFFSET promptSummation2
    call WriteString

    mov eax, sum            ;outputs the sum of the summation
    call WriteDec



INVOKE ExitProcess,0
main ENDP
; (insert additional procedures here)
END main