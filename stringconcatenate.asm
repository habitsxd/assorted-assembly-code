;Assignment 2, Maxxfield Smith 1907915

INCLUDE Irvine32.inc

.data
prompt1 BYTE "This is the original string: ",020h,0
prompt2 BYTE "This is the new string: ",020h,0
prompt3 BYTE "After concatenation: ",020h,0
targetstring BYTE "ABCDE",5 DUP(0)
sourcestring BYTE "FGH",0


.code
Str_concat PROTO,
	target:PTR BYTE,
	source:PTR BYTE

main PROC
	mov edx, OFFSET prompt1    ;print prompt 1
	call WriteString
	mov edx, OFFSET targetstring  ;print target string
	call WriteString
	call CRLF
	mov edx, OFFSET prompt2 ;print prompt 2
	call WriteString
	mov edx, OFFSET sourcestring   ;print source string
	call WriteString
	call CRLF

	INVOKE Str_concat, ADDR targetstring, ADDR sourcestring ;invoke concatenation procedure

	mov edx, OFFSET prompt3  ;print result
	call WriteString
	mov edx, OFFSET targetstring
	call WriteString
	call CRLF



	


	



	
	exit
main ENDP



Str_concat PROC USES edx eax esi edi,
	target:PTR BYTE,
	source:PTR BYTE

	mov edi, target
	mov esi, source

	INVOKE Str_length,edi
	add edi,eax				;move pointer to the end of source

	INVOKE Str_length, esi
	mov ecx,eax           ;set counter to length of target

	cld
	rep movsb    ;move source to target

	ret      ;return to main


Str_concat ENDP

END main