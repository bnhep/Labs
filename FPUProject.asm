TITLE template
;Author: Brandon Nhep
;last date modified: 5/2/2024
;Course Number/Section: CIS 231
;Assignment Number/Name: FPUProject
;Write a MASM code that uses FPU to calculate the 
;BMI for an adult, using the formula BMI = weight/height2.
;Then output the calculated value and the status based on the ranges

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; declare variables here
underweight		REAL8 18.499999999
normalLow		REAL8 18.599999999
normalHigh		REAL8 24.999999999
overweightLow	REAL8 25.099999999
overweightHigh	REAL8 39.999999999
obese			REAL8 40.099999999

epsilon REAL8 1.0E-12 
ctrlWord WORD ?

userHeight REAL8 ?
userWeight REAL8 ?

intNum DWORD ?

userBMI REAL8 41.0

openingStatement BYTE "Would you like to calculate your BMI? ", 0
heightEnter BYTE "Enter your height in meters: ",0
weightEnter BYTE "Enter your weight in kilograms: ",0

underweightPrompth BYTE "You are underweight and at risk ", 0
normalPrompth BYTE "You are normal ", 0
overweightPrompth BYTE "You are overweight and at risk ", 0
obesePrompth BYTE "You are obese and at risk ", 0
estimatedPrompth BYTE "Your estimated BMI is ", 0
.code
main PROC
       ;Inputstream for floating point units
       mov  edx,OFFSET openingStatement
       call WriteString
       call Crlf
       call Crlf
       mov  edx,OFFSET heightEnter  ;read the height from the user
       call WriteString
       call ReadFloat
       FSTP userHeight
       call Crlf
       mov  edx,OFFSET weightEnter  ;read the weight from the user
       call WriteString
       call ReadFloat
       FSTP userWeight
       call Crlf

       ;Calculate the BMI from the user input
       ;BMI = weight/height^2
       fld userHeight
       FMUL ST(0), ST(0)        ;height x height
       fld userWeight
       FDIV ST(0), ST(1)        ;weight/height^2
       FSTP userBMI
       FSTP ST(0)

underWeightTest:
       ;compares the underweight value 18.4 and if its below
       ;output message underweight otherwise jump to normaltest
       fld underWeight          ; ST(0) = underWeight
       fld userBMI              ; ST(0) = UserBMI, ST(1) = underWeight
       fcomi ST(0),ST(1)        ; compare ST(0) to ST(1)
       jnbe normalTest          ; ST(0) not < ST(1)? skip


       mov  edx,OFFSET underweightPrompth
       call WriteString
       call Crlf
       mov  edx,OFFSET estimatedPrompth
       call WriteString
       fld userBMI
       ;output as an decimal
       fistp intNum
       mov eax, intNum
       call WriteDec
       call Crlf
       jmp endTest
normalTest:
       ;compares the equality of normal low value with 
       ;user's bmi and if it is equal jump to normaltest1
       ;if not output the underweight message
       FINIT
       fld epsilon
       fld normalLow
       fsub userBMI
       fabs
       fcomi ST(0), ST(1)
       ja normalTest1

       ;output prompth telling user they are underweight
       mov  edx,OFFSET underweightPrompth
       call WriteString
       call Crlf
       mov  edx,OFFSET estimatedPrompth
       call WriteString
       fld userBMI
       ;output as an decimal
       fistp intNum
       mov eax, intNum
       call WriteDec
       call Crlf
       jmp endTest
normalTest1:
       ;compares the normal high value with user bmi
       ;if it is below the high output normal message
       ;otherwise jump to overweight test
       FINIT
       fld normalHigh           ; ST(0) = normalHigh
       fld userBMI              ; ST(0) = UserBMI, ST(1) = normalHigh
       fcomi ST(0),ST(1)        ; compare ST(0) to ST(1)
       jnbe overweightTest      ; ST(0) not < ST(1)? skip

       ;output prompth telling user they are normal
       mov  edx,OFFSET normalPrompth
       call WriteString
       call Crlf
       fld userBMI
       mov  edx,OFFSET estimatedPrompth
       call WriteString
       ;output as an decimal
       fistp intNum
       mov eax, intNum
       call WriteDec
       call Crlf
       jmp endTest

overweightTest:
       ;compares the equality of overweightlow with user bmi
       ;if it is below the low value output normal message
       ;otherwise jump to overweight test1
       FINIT
       fld epsilon
       fld overweightLow
       fsub userBMI
       fabs
       fcomi ST(0), ST(1)
       ja overweightTest1

       ;output prompth telling user they are underweight
       mov  edx,OFFSET underweightPrompth
       call WriteString
       call Crlf
       fld userBMI
       mov  edx,OFFSET estimatedPrompth
       call WriteString
       ;output as an decimal
       fistp intNum
       mov eax, intNum
       call WriteDec
       call Crlf
       jmp endTest
overweightTest1:
       FINIT
       fld overweightHigh       ; ST(0) = overweightHigh
       fld userBMI              ; ST(0) = UserBMI, ST(1) = overweightHigh
       fcomi ST(0),ST(1)        ; compare ST(0) to ST(1)
       jnbe obeseTest           ; ST(0) not < ST(1)? skip

       ;output prompth telling user they are overweight
       mov  edx,OFFSET overweightPrompth
       call WriteString
       call Crlf
       fld userBMI
       mov  edx,OFFSET estimatedPrompth
       call WriteString
       ;output as an decimal
       fistp intNum
       mov eax, intNum
       call WriteDec
       call Crlf
       jmp endTest

obeseTest:
       fld obese                ; ST(0) = obese
       fld userBMI              ; ST(0) = UserBMI, ST(1) = obese
       fcomi ST(0),ST(1)        ; compare ST(0) to ST(1)
       ja obeseTest             ; ST(0) not < ST(1)? skip
obestTest1:
       FINIT
       ;output prompth telling user they are obese
       mov  edx,OFFSET obesePrompth
       call WriteString
       call Crlf
       fld userBMI
       mov  edx,OFFSET estimatedPrompth
       call WriteString
       ;output as an decimal
       fistp intNum
       mov eax, intNum
       call WriteDec
       call Crlf
       FSTP ST(0)

endTest:
       FINIT



INVOKE ExitProcess,0
main ENDP
; (insert additional procedures here)
END main