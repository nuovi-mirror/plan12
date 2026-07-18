

	init:										; init code
		mov rbx, *startmem						; alias start memory
		mov rcx, *endmem						; alias end memory
		@call,parsefs,fsys,rax,fsys,nocreat		; get the fsys file
		mov rdx, [r8 + 189]						; get my id

	checksig:									; entry for checking the signal
		@call,parsefs,rax,rdx'.s6',nocreat		; find my signal file
		cmp r12, 1								; check if not found
		@call,fall,%arg1						; round-robin