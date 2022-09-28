;Assignment 2, Maxxfield Smith 1907915

INCLUDE Irvine32.inc

.data
prompt1 BYTE "Original string: ",020h,0
prompt2 BYTE "The string following the delimiter is: ",020h,0
prompt3 BYTE "The delimiter character is: ',' ",020h,0Dh,0

prompt4 BYTE "No delimiter found!",0
string BYTE "Johnson,Calvin",0

.code

Str_nextword PROTO,
	str1:PTR BYTE,
	delimiter:BYTE

main PROC

	mov edx, OFFSET prompt1  ;output prompt1
	call WriteString
	mov edx, OFFSET string
	call WriteString
	call CRLF

	mov edx, OFFSET prompt3 ;output prompt2
	call WriteString
	call CRLF

	INVOKE Str_nextword,ADDR string,"," ;search for delimiter character
	jnz NOCHAR

	mov edx,OFFSET prompt2
	call WriteString
	mov edx,eax
	call WriteString
	call CRLF
	jmp DONE
	
	NOCHAR: 
		mov edx, OFFSET prompt4
		call WriteString
		call CRLF

	DONE: exit

main ENDP




Str_nextword PROC,
str1:PTR BYTE,
delimiter:BYTE

	mov edi,str1 ;move string to edi for scasb command 

	INVOKE Str_length,edi ;find length of string

	mov ecx,eax ;move string length to counter for rep command

	mov al,delimiter ;move character to al for comparison 

	cld  ;set direction to forward

	repne scasb ;search for delimiter

	jnz DONE ;if the delimiter character is not found return to main

	mov eax,edi  ;sets eax as a pointer to the beginning of the string after the delimiter

	dec edi  ;move cursor back to delimiter
	mov BYTE PTR [edi],0 ;set delimiter to 0
	mov ebx,1 ;set zero flag
	sub ebx,1

	DONE: ret

Str_nextword ENDP
END main