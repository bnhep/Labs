TITLE template
;Author: Brandon Nhep
;last date modified: 3/8/2024
;Course Number/Section: CIS 231
;Assignment Number/Name: LabW8-Madlips part B
;Description:Write a code that allows the user to enter
;verbs, adjectives, body parts, adverbs, nouns, animals and color.
;Using the user's inputs create a madlibs phrasal template word game
;and substitute the input to fill in the blank spaces of the template

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
    ;output variables for questions beting asked to the user
	verb_1 BYTE "Enter a verb of choice, and press enter: ",0
	adj_1 BYTE "Enter an adjective of choice, and press enter: ",0
	verb_2 BYTE "Enter second verb of choice, and press enter: ",0
	body_part BYTE "Enter a body part name of choice, and press enter: ",0
	adverb BYTE "Enter an adverb of choice, and press enter: ",0
	body_part_2 BYTE "Enter a body name of your choice, and press enter: ",0
	noun BYTE "Enter a noun of choice, and press enter: ",0
	verb_3 BYTE "Enter the third verb of choice, and press enter: ",0
	animal BYTE "Enter name of any animal of choice, and press enter: ",0
	noun_2 BYTE "Enter a noun of choice , and press enter: ",0
	verb_4 BYTE "Enter the fourth verb of choice, and press enter: ",0
	adj_2 BYTE "Enter an adjective of choice, and press enter: ",0
	color BYTE "Enter any color name, and press enter: ",0

	;input variables for the madlibs story
	MAX = 80						 ;max chars to read
	input_verb_1 BYTE MAX+1 DUP (?)  
	input_adj_1 BYTE MAX+1 DUP (?)  
	input_verb_2 BYTE MAX+1 DUP (?) 
	input_body_part BYTE MAX+1 DUP (?) 
	input_adverb BYTE MAX+1 DUP (?) 
	input_body_part_2 BYTE MAX+1 DUP (?) 
	input_noun BYTE MAX+1 DUP (?) 
	input_verb_3 BYTE MAX+1 DUP (?) 
	input_animal BYTE MAX+1 DUP (?) 
	input_noun_2 BYTE MAX+1 DUP (?) 
	input_verb_4 BYTE MAX+1 DUP (?)
	input_adj_2 BYTE MAX+1 DUP (?) 
	input_color BYTE MAX+1 DUP (?)

	;prompth for the output of the madlibs story
	prompth1 BYTE "Most doctors agree that bicycle of ",0
	prompth2 BYTE " is a/an ",0
	prompth3 BYTE " form of exercise. ",0
	prompth4 BYTE " a bicycle enables you to develop your ",0
	prompth5 BYTE " muscles as well as ",0
	prompth6 BYTE " increase the rate of a ",0
	prompth7 BYTE " beat. More ",0
	prompth8 BYTE " around the world ",0
	prompth9 BYTE " bicycles than drive ",0
	prompth10 BYTE ". No matter what kind of ",0
	prompth11 BYTE " you ",0
	prompth12 BYTE ", always be sure to wear a/an ",0
	prompth13 BYTE " helmet. Make sure to have ",0
	prompth14 BYTE " reflectors too! " ,0

.code
main PROC
	;;;;START OF THE INPUT/OUTPUT FOR ENTERING DATA
    mov  edx,OFFSET verb_1				;output asking user for verb
    call WriteString
	mov  edx,OFFSET input_verb_1		;input stream for verb
    mov  ecx,MAX            
    call ReadString

    mov  edx,OFFSET adj_1				;output asking user for adjective
    call WriteString  
	mov  edx,OFFSET input_adj_1			;input stream for adj
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET verb_2				;output asking user for 2nd verb
    call WriteString
	mov  edx,OFFSET input_verb_2		;input stream for 2nd verb
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET body_part			;output asking user for body part
    call WriteString
	mov  edx,OFFSET input_body_part		;input stream for body part
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET adverb				;output asking user for adverb
    call WriteString
	mov  edx,OFFSET input_adverb		;input stream for adverb
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET body_part_2		;output asking user for 2nd body part
    call WriteString
	mov  edx,OFFSET input_body_part_2	;input 2nd body part
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET noun				;output asking user for noun
    call WriteString
	mov  edx,OFFSET input_noun			;input stream for noun
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET verb_3				;output asking user for 3rd verb
    call WriteString
	mov  edx,OFFSET input_verb_3		;input stream for verb
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET animal				;output asking user for animal
    call WriteString
	mov  edx,OFFSET input_animal		;input stream for animal
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET noun_2				;output asking user for 2nd noun
    call WriteString
	mov  edx,OFFSET input_noun_2		;input stream for 2nd noun
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET verb_4				;output asking user for 4th verb
    call WriteString
	mov  edx,OFFSET input_verb_4		;input stream for 2nd 4th verb
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET adj_2			;output asking user for 2nd adjective
    call WriteString
	mov  edx,OFFSET input_adj_2			;input stream for 2nd adjective
    mov  ecx,MAX            
    call ReadString

	mov  edx,OFFSET color				;output asking user for color
    call WriteString
	mov  edx,OFFSET input_color			;input stream for color
    mov  ecx,MAX            
    call ReadString

	;START OF THE OUTPUTs OF THE PROMPTH INCLUDING THE DATA
	;ENTERED BY THE USER
    mov  edx,OFFSET prompth1		;output of story prompth1	
    call WriteString
    mov  edx,OFFSET input_verb_1    ;output of first verb       
    call WriteString

    mov  edx,OFFSET prompth2		;output of story prompth2	
    call WriteString  
	mov  edx,OFFSET input_adj_1     ;output of first adjective	      
    call WriteString

	mov  edx,OFFSET prompth3		;output of story prompth3
    call WriteString
	mov  edx,OFFSET input_verb_2    ;output of 2nd verb       
    call WriteString

	mov  edx,OFFSET prompth4		;output of story prompth4
    call WriteString
	mov  edx,OFFSET input_body_part ;output of bodypart	         
    call WriteString

	mov  edx,OFFSET prompth5		;output of story prompth5
    call WriteString
	mov  edx,OFFSET input_adverb    ;output of adverb      
    call WriteString

	mov  edx,OFFSET prompth6		;output of story prompth6
    call WriteString
	mov  edx,OFFSET input_body_part_2  ;output of bodypart2       
    call WriteString

	mov  edx,OFFSET prompth7		;output of story prompth7
    call WriteString
	mov  edx,OFFSET input_noun      ;output of noun      
    call WriteString

	mov  edx,OFFSET prompth8		;output of story prompth8
    call WriteString
	mov  edx,OFFSET input_verb_3    ;output of verb3       
    call WriteString

	mov  edx,OFFSET prompth9		;output of story prompth9
    call WriteString
	mov  edx,OFFSET input_animal	;output of animal     
    call WriteString

	mov  edx,OFFSET prompth10	    ;output of story prompth10
    call WriteString
	mov  edx,OFFSET input_noun_2    ;output of noun2        
    call WriteString

	mov  edx,OFFSET prompth11		;output of story prompth11
    call WriteString
	mov  edx,OFFSET input_verb_4    ;output of verb4      
    call WriteString

	mov  edx,OFFSET prompth12		;output of story prompth12
    call WriteString
	mov  edx,OFFSET input_adj_2     ;output of adjective       
    call WriteString

	mov  edx,OFFSET prompth13		;output of story prompth13
    call WriteString
	mov  edx,OFFSET input_color     ;output of color      
    call WriteString

	mov  edx,OFFSET prompth14		;output of story prompth14
    call WriteString


	call DumpRegs
INVOKE ExitProcess,0

main ENDP
; (insert additional procedures here)
END main
