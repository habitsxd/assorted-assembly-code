;Assignment 3, Maxxfield Smith 1907915

INCLUDE Irvine32.inc

.data
intArray DWORD 100 DUP(?)
inputCount DWORD ?
searchKey DWORD ?
min DWORD ?
msg1 BYTE "Enter number of elements: ",0Ah,0Dh,0
msg2 BYTE "Enter integer elements: ",0Ah,0Dh,0
msg3 BYTE "Enter an integer to search for: ",0Ah,0Dh,0
msg4 BYTE "Integer was found: ",0Ah,0Dh,0
msg5 BYTE "The integer you searched for was was bigger than any other element in the array: Not Found",0Ah,0Dh,0
msg6 BYTE "A larger integer was found,but not specific integer: ",0Ah,0Dh,0
msg7 BYTE "Unsorted array: ",0Ah,0Dh,0
msg8 BYTE "Sorted array: ",0Ah,0Dh,0



.code
main PROC
	mov edx, OFFSET msg1 ;outputs prompt to user
	call WriteString

	call readArray ;reads array from user input

	mov edx,OFFSET msg7 ;lets user know the following printed array is unsorted
	call WriteString

	call printArray ;prints unsorted array

	call selectionSort ;sorts array

	mov edx,OFFSET msg8 ;lets user know printed array is sorted
	call WriteString

	call printArray ;prints sorted array

	call binarySearch ;does a half binary search according to user input

		
	
	exit
main ENDP

readArray PROC   ;reads in an array from user input
	call ReadInt   ;takes in the number of elements in the array from the user
	mov inputCount, eax

	mov edx,OFFSET msg2
	call WriteString

	mov ecx, inputCount ;sets counter for L1 to the specified number input from user
	mov esi,0

	L1:            ;takes input from user and places them in intArray 
		call ReadInt
		mov intArray[esi],eax
		add esi,4
		loop L1

	ret		;return to main
readArray ENDP


selectionSort PROC ;sorts array
	mov ecx, inputCount
	dec ecx ;since number of comparisons in selection sort is n-1, we decrement ecx here
	mov esi, OFFSET intArray ;used for general element pointer throughout algorithm
	mov edi, OFFSET intArray ;used to point to first element of UNSORTED portion of array
	mov eax,[esi]  
	mov min,eax	;sets first element of array as the current minimum

	SORT:		;header to loop through finding minimum
		push ecx ;keep track of outer loop
		push esi ;keep track of esi for later use during swaps

		
	MINIMUM:
		add esi,4	;moves pointer to second element in UNSORTED portion of array
		mov eax,[esi] ;moves value esi is pointing to to eax
		cmp eax,min  ;compare second value in unsorted array to current minimum
		jb NEWMIN    ;if second value is less than current mimimum, jump to header new min
		dec ecx		;next lines are used as a loop
		cmp ecx,0	
		ja MINIMUM	;if ecx is not zero, jump to mimimum and keep comparing
		je SWAP		;if ecx is zero go to swap (all comparisons are made and min has been found)
		
	NEWMIN:
		mov edx,[esi] ;move current value of esi to edx
		mov min,edx  ;set current value of esi to the new min
		mov ebx,esi	 ;mov address of current min to ebx for later use in the swap
		dec ecx		;next 4 lines are loop
		cmp ecx,0
		ja minimum ;if ecx above zero, jump to minimum and keep comparing 
		je SWAP		;if ecx is zero, jump to swap to perform sort

	SWAP:
		mov eax,min ;move current minimum to eax
		mov edx,[edi] ;move current value of the first unsorted element to edx
		cmp eax,edx ;compare current minimum to first value of unsorted 
		je NOSWAP ;if these two values are equal, no need to swap go to noswap
		mov eax,min ;move minimum to eax
		mov edx,[edi] ;move first value of unsorted array to edx
		mov esi,ebx   ;move address of current minimum to esi
		mov [edi],eax ;swap minimum to unsorted index
		mov [esi],edx ;swap first unsorted index to current minumums old index
		pop esi			;restore esi's value to original
		pop ecx			;restore count for outer loop
		add esi,4		;move esi to next element
		add edi,4		;move edi to next element
		mov eax,[esi]	;move current esi value to eax
		mov min,eax		;set the first element in new unsorted part of array to the new mimium
		loop SORT		;go back to sort
		ret				;if ecx is 0, return
	NOSWAP: ;if no swap is needed, code will jump here, performs everything besides swap algorithm
		pop esi
		pop ecx
		add esi,4
		add edi,4
		mov eax,[esi]
		mov min,eax
		loop SORT
		ret ;if ecx is zero, return to main



selectionSort ENDP     

printArray PROC ;prints array
	mov esi,0
	mov ecx,inputCount

	L1:
		mov eax,intArray[esi]
		call WriteInt
		add esi,4
		loop L1
	CALL CRLF
	ret
	
printArray ENDP

linearSearch PROC ;searches for an element in the array
	mov edx, OFFSET msg3 
	call WriteString ;prints prompt for user
	call ReadInt  ;takes input from user to determine an integer to search the array for
	mov searchKey, eax ;moves the input to memory
	
	
	mov ecx, inputCount
	mov esi,0


	SEARCH:
		mov eax,intArray[esi] ;loops through array
		CMP eax,searchKey
		JE FOUND ;if value is found, jump to found
		JG FOUNDG ;if value is greater jump to foundg
		add esi,4
		loop SEARCH
		jmp NOTFOUND
	FOUND:				;lets user know that integer was found, and prints the integer
		mov eax,intArray[esi]
		mov edx,OFFSET msg4
		call WriteString
		call WriteInt
		ret
	FOUNDG:			;lets user know a larger integer was found but not integer
		mov eax,intArray[esi]
		mov edx,OFFSET msg6
		call WriteString
		call WriteInt
		ret
	NOTFOUND:        ;if input integer was larger than any other in the array, and was not found let user know
		mov edx, OFFSET msg5
		call WriteString
		ret

linearSearch ENDP

binarySearch PROC ;implements a half binary search
	mov edx, OFFSET msg3 
	call WriteString ;prints prompt for user
	call ReadInt  ;takes input from user to determine an integer to search the array for
	mov searchKey, eax ;moves the input to memory

	mov ebx,0	;left index
	mov edx,inputCount;right index
	dec edx	
	mov esi,0	;sets esi to 0 index
	mov ecx,searchKey

	BEGINSEARCH:
		push esi		;save esi for later use
		add esi,inputcount	;set esi to number of elements
		dec esi				;set esi to n-1
		cmp ecx,intArray[esi*TYPE intArray] ;compare search key and last element of array 
		pop esi ;restore esi to 0
		jg NOTFOUND ;if search key is greater than last element of sorted array, it will not be found
		
		
		mov eax,ebx ;move first index of unsearched array into eax
		add eax,edx	;add last index of array to eax
		shr eax,1  ;eax is now the midpoint
		mov edi,esi ;move first index to edi
		add edi,eax ;add current midpoint to edi
		cmp ecx,intArray[edi*TYPE intArray] ;compare search key and midpoint
		je FOUND ;if search key is equal to midpoint, key has been found
		jb FOUNDG ;if search key is less than midpoint,jump to foundg
		jg	RIGHTSEARCH	;if search key is greater, split array and search again
		

	RIGHTSEARCH:
		add eax,1	;add one to current midpoint
		mov ebx,eax	;set mid + 1 as new first index of array
		jmp BEGINSEARCH

	FOUND:
		mov edx,OFFSET msg4 
		call WriteString ;write msg4 for user
		mov eax,intArray[edi*TYPE intArray] ;move found number to eax
		call WriteInt ;output found number
		ret
	FOUNDG:
		mov edx, OFFSET msg6 ;a greater integer way fount
		call WriteString
		mov eax,intArray[edi*TYPE intArray]
		call WriteInt ;output greater found number
		ret
	NOTFOUND:          ;search key was not found
		mov edx, OFFSET msg5
		call WriteString
		ret

		



binarySearch ENDP

END main