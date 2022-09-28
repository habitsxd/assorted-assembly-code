; AddVariables_64.asm - Chapter 3 problem 6 solution.

ExitProcess PROTO
; got rid of stack and memory calls for 64bit
;changed build to 64 bit version, which resolved syntax errors
.data
; changed data types from dword to qword
firstval  QWORD 20002000h
secondval QWORD 11111111h
thirdval QWORD 22222222h
sum QWORD 0

.code
main proc
; changed various syntax to 64bit and most importantly switched to rax 
;(rax is 64bit version of eax)
	mov	rax,firstval				
	add	rax,secondval		
	add rax,thirdval
	mov sum,rax

	call ExitProcess
main endp
end