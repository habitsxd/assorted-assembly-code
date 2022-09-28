; problem 2 chapter 3 solution
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
    ;define integer constants for each day of the week
	sunday = 0
	monday = 1
	tuesday = 2
	wednesday = 3
	thursday = 4
	friday = 5
	saturday = 6
.data
	;define array using symbolic integer constants
	days BYTE sunday,monday,tuesday,wednesday,thursday,friday,saturday
.code
main proc
	;test to move sunday (0) into eax register, and monday (1) into ebx
	mov eax,sunday
	mov ebx,monday

	invoke ExitProcess,0
main endp
end main