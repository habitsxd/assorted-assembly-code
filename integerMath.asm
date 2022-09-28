;Assignment 2, Maxxfield Smith 1907915

INCLUDE Irvine32.inc

.data
buffer BYTE 50 DUP(?)
bytecount DWORD	 ?


.code
main PROC

mov edx, OFFSET buffer
mov ecx, SIZEOF buffer
call ReadString
mov bytecount, eax

mov ecx,bytecount
mov esi, 0

L1:
	movzx eax,buffer[esi]
	inc esi
	push eax
	loop L1

mov ecx,bytecount
mov esi, 0
L2:
	pop eax
	mov buffer[esi],al
	inc esi
	loop L2

mov edx, offset buffer
call writestring

	
	


	



	
	exit
main ENDP
END main