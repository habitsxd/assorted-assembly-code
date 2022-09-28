;Assignment 2, Maxxfield Smith 1907915

INCLUDE Irvine32.inc

.data
prompt1 BYTE "Please enter a string of characters in ascii hex(Use capital letters): ",0Ah,0Dh,0
prompt2 BYTE "The given ascii values are: ",09h,0
buffer BYTE 80 DUP(?)
byteCount DWORD ?




.code
main PROC

mov edx, OFFSET prompt1 
call WriteString ;prompts user to enter a string of values

mov edx,OFFSET buffer ;setup for readstring
mov ecx,SIZEOF buffer

call ReadString

mov edx, OFFSET prompt2 ;let's user know the following are the return values
call WriteString

mov byteCount, eax ;stores number of elements in array from readstring

call convert ;starts conversion process
	
	exit
main ENDP




convert PROC
	mov esi,0 ;sets esi to 0
	mov ecx,byteCount ;sets count to number of elements in array
	sub ecx,2
	mov eax,0 ;resets ecx and ebx
	mov ebx,0
	
	L1:
		mov al,buffer[esi] ;moves first element to al
		.IF al >= 30h && al <= 39h ;if al is a hex number execute following
		sub al, 30h ;sub 30 to get original value
		shl al,4 ;shl by 4 bits to accomodate next value
		inc esi ;move pointer to next element
		mov bl,buffer[esi] ;move next element to bl
			.IF bl >= 30h && bl <= 39h ;if bl is a hex number
			sub bl,30h ;sub 30 to get back original value
			add al,bl ;add values together to get full ascii value
			.ELSEIF bl >= 41h && bl <= 05Ah ;if bl is ascii for a letter
			sub bl,37h ;sub 37 to get back original value
			add al,bl ;add together
			.ENDIF
		.ELSEIF al >= 41h && al <= 05Ah ;the rest follows the same logic, if al is ascii for letter execute this
		sub al, 37h
		shl al,4
		inc esi
		mov bl,buffer[esi]
			.IF bl >= 30h && bl <= 39h
			sub bl,30h
			add al,bl
			call WriteChar
			.ELSEIF bl >= 41h && bl <= 05Ah
			sub bl,37h
			add al,bl
			.ENDIF
		.ENDIF
		inc esi
		call WriteChar ;display character whose ascii value is in al
		loop L1


			

	DONE:
		ret



convert ENDP
END main
