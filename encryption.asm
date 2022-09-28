;Assignment 2, Maxxfield Smith 1907915

INCLUDE Irvine32.inc

.data
arraySize DWORD ?
numsArray DWORD 50 DUP(?)
prompt1 BYTE "Please enter the size of the array: ",20h,0
prompt2 BYTE "Please enter the elements in the array: ",0AH,0DH,0
minstr BYTE "The minimum value is: ",020h,0
maxstr BYTE "The maximum value is: ",020h,0
min DWORD ?
max DWORD ?
prompt3 BYTE "The encrypted string is: ",020h,0
prompt4 BYTE "The unencrypted string is: ",020h,0

.code

find_min_max PROTO,
nums:PTR DWORD,
n:DWORD,


find_string PROTO,
nums:PTR DWORD,
n:DWORD

main PROC

	mov edx, OFFSET prompt1 ;output prompt 1
	call WriteString
	
	call ReadInt   ;read the size of the array
	mov arraySize,eax

	call CRLF   ;newline
	mov edx, OFFSET prompt2 ;output prompt 2
	call WriteString

	mov ecx, arraySize  ;read in elements in the array
	mov esi,OFFSET numsArray
	L1: call ReadInt
		mov [esi],eax
		add esi,4
		loop L1
	

	INVOKE find_min_max,ADDR numsArray,arraySize ;calls function to find max and min with parameters
	
	call CRLF		;outputs max and min values
	MOV edx,OFFSET minstr
	call WriteString
	mov eax,min
	call WriteInt
	call CRLF
	mov edx,OFFSET maxstr
	call WriteString
	mov eax,max
	call WriteInt
	call CRLF
	


	INVOKE find_string,ADDR numsArray,arraySize
	
	exit
main ENDP

find_min_max PROC,
nums:PTR DWORD,
n:DWORD

	

	mov ecx,n
	dec ecx
	mov esi,nums
	mov eax,[esi]
	mov min,eax
	mov max,eax

	

	FIND_MIN: add esi,4    ;searches and compares adjacent array values
			  mov eax,[esi]
			  cmp eax,[edi]
			  jb NEW_MIN
			  dec ecx
			  cmp ecx,0 
			  je MAXII
			  ja FIND_MIN
	
	NEW_MIN:  mov min,eax  ;if next value is smaller move to min
			  dec ecx
			  cmp ecx,0 
			  je MAXII	
			  ja FIND_MIN

	MAXII: mov esi,nums  ;sets up registers to find max values
		   mov ecx,n
		   dec ecx
		  

	FIND_MAX: add esi,4	  ;compares adjacent array values
			  mov ebx,[esi]
			  cmp ebx,[esi]
			  ja NEW_MAX
			  dec ecx
			  cmp ecx,0
			  je DONE
			  ja FIND_MAX
	
	NEW_MAX: mov max,ebx   ;if next value is larger move to max
			 dec ecx
			 cmp ecx,0
			 je DONE
			 ja FIND_MAX


	DONE: ret

		

find_min_max ENDP

find_string PROC,
nums:PTR DWORD,
n:DWORD

	mov esi,nums
	mov ecx,n
	mov edx,OFFSET prompt3
	call WriteString

	OUTPUT1: mov eax,[esi]   ;outputs encrypted string
			call WriteChar
			add esi,4
			loop OUTPUT1
	call CRLF

	mov esi,nums
	mov ecx,n

	SUBTRACT: mov eax,[esi]  ;subtracts one from each element in the array 
			  dec eax
			  mov [esi],eax
			  add esi,4
			  loop SUBTRACT

	mov ecx,n
	mov esi,nums
	mov edx,OFFSET prompt4
	call WriteString

	OUTPUT2: mov eax,[esi]  ;outputs unencrypted string
			call WriteChar
			add esi,4
			loop OUTPUT2
	call CRLF
	
	ret

	


find_string ENDP

END main


