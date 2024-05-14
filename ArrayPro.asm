TITLE template
;Author: Brandon Nhep
;last date modified: 5/14/2024
;Course Number/Section: CIS 231
;Assignment Number/Name: Array Project
;Write a MASM program that use a loop and indexed 
;addressing mode to calculate the sum of all
;the gaps between successive array elements.
;First declare an array of 100 uninitialized doubleword elements
;Prompth user to enter count for number array elements
;validate the count and make sure its a positive integer
;fill the array with count elements, sort the array in ascending order
;and calculate the sum of all the gaps between successive array elements.

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
; declare variables here
;count for number of array elements to be initialized
count DWORD ?
;array of unintialized doubleword elements
myArray DWORD 100 DUP(?)            


promptBad BYTE "Invalid input, please enter again ",0
promptNegative BYTE "Please Enter a positive number ",0
enterElements BYTE "How many elements do you want to enter? ",0
validateElements BYTE "Enter element ",0
space BYTE ": ",0
elementOutput BYTE "Invalid input, please enter again: ",0
promptElement BYTE "Please Enter a positive element: ",0
spaceElement BYTE ", ",0
sortArrayOutput BYTE "The sorted array is ",0
gapOutput BYTE "The gaps are ",0
sumOutput BYTE "The sum is ",0

.code
main PROC
;allows user to enter elements and validates them at the same time
;calls function to get user entry number for array elements
	call validateCount				
	push OFFSET myArray
	push count
	call ArrayEntry                 

;Calls the arraySort function to
;sort the array in ascending order
    mov  edx,OFFSET sortArrayOutput
    call WriteString
	push OFFSET myArray
	push count
    call arraySort                  


;call outputArray to output
;elements in the array
	push OFFSET myArray
	push count
    call outputArray

;call findGaps function to find the gap
;between elements of the array
	call Crlf
    mov  edx,OFFSET gapOutput
    call WriteString
	push OFFSET myArray
    dec count
	push count
    call findGaps

	push OFFSET myArray
	push count
    call outputArray

;Call the findSum function to find and output the sum
;find the sum of the gap elements and outputs the total sum
	call Crlf
    mov  edx,OFFSET sumOutput
    call WriteString
	push OFFSET myArray
	push count
    call findSum


INVOKE ExitProcess,0
main ENDP
;----------------------------------------------------
;Prompths the user to enter the number of elements
;stores value into memory count
;Receives: nothing
;returns: nothing
;----------------------------------------------------
validateCount PROC
read:
    mov  edx,OFFSET enterElements
    call WriteString
    call ReadInt
    ;jumps to negative number if no overflow
    ;if overflow loop to read again
    jno  negativeNumber
    mov  edx,OFFSET promptBad
    call WriteString
	call Crlf
    jmp  read        ;go input again
negativeNumber:
    ;Checks if number is not negative signed if so then jump to goodinput
    ;if it is signed then loop back to read
    jns goodInput
    mov  edx,OFFSET promptNegative
    call WriteString
	call Crlf
    jmp  read       ;go input again        
goodInput:
    cmp eax, 100
    jg read
    mov count,eax  ;store good value
	ret
validateCount ENDP

;----------------------------------------------------
;Prompths the user to enter the number of elements
;A function for the entry validation
;Receives: address of the array, value of count
;returns: nothing
;----------------------------------------------------
ArrayEntry PROC
	push ebp
	mov ebp, esp
	pushad
	mov esi,[ebp+12]    ;move array to esi
	mov ecx,[ebp+8]     ;move count value to ecx
	cmp ecx, 0
	je Loop2
    mov ebx, 1          ;output element counter
Loop1:
    mov  edx,OFFSET validateElements
    call WriteString
    mov eax, ebx
    call WriteDec
    mov  edx,OFFSET space
    call WriteString
    inc ebx
    call validateEntry
	mov [esi], eax      ;add the element to array
	add esi, TYPE DWORD ;iterate through the array
	loop Loop1
Loop2:
	popad
	pop ebp
	ret 8
ArrayEntry ENDP

;----------------------------------------------------
;Prompths the user to enter the number of elements
;A function for the entry validation
;Receives: address of the array, value of count
;returns: nothing
;----------------------------------------------------
validateEntry PROC
read:
    call ReadInt
    ;jumps to negative number if no overflow
    ;if overflow loop to read again
    jno  negativeNumber

    mov  edx,OFFSET elementOutput
    call WriteString
    jmp  read        ;go input again

negativeNumber:
    ;Checks if number is not negative signed if so then jump to goodinput
    ;if it is signed then loop back to read
    jns goodInput
    mov  edx,OFFSET promptElement
    call WriteString
    jmp  read       ;go input again
        
goodInput:
	ret
validateEntry ENDP

;----------------------------------------------------
;Sorts the array using the bubblesort algorithm
;Receives: address of the array, value of count
;returns: nothing
;----------------------------------------------------
arraySort PROC
    push ebp
    mov ebp, esp
    pushad
    mov ecx,[ebp+8] ;value of count stored in ecx
    dec ecx
Loop1:
    push ecx
    mov esi,[ebp+12]        ;point to array address in esi
Loop2:         
    mov eax, [esi]          ;if element is less than next element
    cmp [esi+4], eax        ;no exchange needed
    jg Loop3                
    xchg eax, [esi+4]       ;else exchange the pair
    mov [esi], eax
Loop3:
    add esi, 4              ;move both pointers
    loop Loop2              ;inner loop
    pop ecx
    loop Loop1              ;outer loop

Loop4:
    popad
    pop ebp
    ret 8
arraySort ENDP

;----------------------------------------------------
;Function for finding the gaps between each element
;Receives: address of the array, value of count
;returns: nothing
;----------------------------------------------------
findGaps PROC
	push ebp
	mov ebp, esp
	pushad
	mov esi,[ebp+12]      ;pointer to array address
	mov ecx,[ebp+8]       ;counter
	cmp ecx, 0
	je Loop2
Loop1:    
    mov eax, [esi+4]      ;subtract the next element
    mov ebx, [esi]        ;with the current element
    sub eax, ebx
	mov [esi], eax        ;store new value in array
	add esi, TYPE DWORD
	loop Loop1
Loop2:
	popad
	pop ebp
    ret 8
findGaps ENDP

;----------------------------------------------------
;Iterates through the array and outputting the array
;Receives: address of the array, value of count
;returns: nothing
;----------------------------------------------------
outputArray PROC
	push ebp
	mov ebp, esp
	pushad
	mov esi,[ebp+12]       ;pointer to array
	mov ecx,[ebp+8]        ;counter
Loop1:
	mov eax, [esi]                  ;move element
	call WriteDec
    mov  edx,OFFSET spaceElement    ;output element value
    call WriteString
	add esi, TYPE DWORD             ;iterate through array
    cmp ecx, 2                      ;once it hits last element
    je Loop2                        ;break loop
	loop Loop1
Loop2: 
    mov eax, [esi]                  ;move last element
    add esi, TYPE DWORD             ;output last element
	call WriteDec
    popad
    pop ebp
    ret 8
outputArray ENDP

;----------------------------------------------------
;Prompths the user to enter the number of elements
;Function for calculating the sum of the gaps
;----------------------------------------------------
findSum PROC
	push ebp
	mov ebp, esp
	pushad
    mov eax, 0
	mov esi,[ebp+12]        ;pointer to array
	mov ecx,[ebp+8]         ;count
	cmp ecx, 0
	je Loop2
Loop1:    
    add eax, [esi]          ;adds everything in array to
	add esi, TYPE DWORD     ;to first element
	loop Loop1
Loop2:
    call WriteDec           ;outputs the eax which is the total
	popad
	pop ebp
    ret 8
findSum ENDP

END main