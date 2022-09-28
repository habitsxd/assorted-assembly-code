;problem 1 from ch.3 solution

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	; declare variables here
.code
main proc
	mov eax,34 ;assigns integer values to different registers
	mov ebx,22
	mov ecx,4
	mov edx,12

	add eax,ebx ;adds value in ebx to eax (A+B) new value stored in eax
	add ecx,edx ;adds value in edx to ecx (C+D) new value stored in ecx
	sub eax,ecx ;subtracts value in ecx from eax (A+B) - (C+D) new value stored in eax


	invoke ExitProcess,0
main endp
end main