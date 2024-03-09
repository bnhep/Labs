TITLE template
;Author: Brandon Nhep
;last date modified: 3/8/2024
;Course Number/Section: CIS 231
;Assignment Number/Name: LabW8-Madlips part A
;Description:Write an interactive code that asks 
;the user to enter their name, the year was born, and the
;current year. And output a message showing the person’s name and age.

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD


.data
	;declare variables here
	MAX = 80                     ;max chars to read
	stringIn BYTE MAX+1 DUP (?)  ;room for null
	prompt1 BYTE "Enter your name: ",0
	prompt2 BYTE "Enter the year you were born: ",0
	prompt3 BYTE "Enter the current year: ", 0
	prompt4 BYTE "Hello, ", 0 , 0ah , 0dh
	prompt5 BYTE "your Age is ", 0

	intNum DWORD ?
	intNum1 DWORD ?
	intNum2 DWORD ?
	promptBad BYTE "Invalid input, please enter again",0

.code
	main PROC
	;output message for user to enter name
	mov edx, OFFSET prompt1
	call WriteString

	;input for the name of the user 
	mov edx,OFFSET stringIn
    mov ecx,MAX            ;buffer size - 1
    call ReadString

	;output message for user to enter year you were born
	mov edx, OFFSET prompt2
	call WriteString

	;input integer for user to enter year
	read:	call ReadInt
			jno  goodInput

			mov  edx,OFFSET promptBad
			call WriteString
			jmp  read        ;go input again

	goodInput:
			mov  intNum,eax  ;store good value

	;output message for user to enter current year
	mov edx, OFFSET prompt3
	call WriteString

	;input integer for user to enter current year
	read1:	call ReadInt
			jno  goodInput1

			mov  edx,OFFSET promptBad
			call WriteString
			jmp  read1        ;go input again

	goodInput1:
			mov  intNum1,eax  ;store good value

    ;output the message with person's name and age
	mov edx, OFFSET prompt4
	call WriteString
	mov edx, OFFSET stringIn
	call WriteString

	mov al, ' '		;create a space between name and next phrase
	call WriteChar

	;subtract current year with year user was born
	mov eax, intNum1
	sub eax, intNum
	mov intNum2, eax


	;output age including the prompth for saying user's age
	mov edx, OFFSET prompt5
	call WriteString
	mov edx, OFFSET intNum2
	call WriteInt	
	
	call DumpRegs
INVOKE ExitProcess,0


main ENDP
; (insert additional procedures here)
END main
