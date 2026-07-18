		@call,parsefs,fsys,rax,fsys,nocreat		; get the fsys file
		mov rdx, [r8 + 128]						; get my process id
		@call,parsefs,buff,rax,rdx'.bin',creat	; create by buffer
		mov rsi, 512							; set the size of the buffer
		mov [r8 + 192], rsi						; actually set the size of the buffer

	settable:									; set up the ascii table
		mov rax, [*startmem]					; set the entry for the table
		cmp *endmem, 256						; check if alloacted at least n bytes of memory
		jl exitcase								; exit if not
		mov [rax], '`1234567'					; `1234567
		mov [rax + 8], '890-='0x00080009'q'		; 890-[bs][ht]q
		mov [rax + 16], 'w'


												; how the table works should be pretty obvious
												; read an entry from the table, the table start
												; + the scancode and the entry will be an ascii
												; character. 
												; finish the rest of the table some time lol

	reset:
		mov rbz, 0								; zero the counter and continue

	checkkey:									; check if a key is pressed
		cmp rsi, rax							; check against pointer
		je reset								; reset if so

		in al, 0x64								; get the 'char ready' thing
		test al, 1								; check if 'char ready' set
		je checkkey								; jump if set

		in al, 0x60								; read the scan code
		inc rbx									; incriment the counter
		cmp rbx, rsi							; check if buffer full
		je reset								; if so, reset
		mov byte [r8 + rbx] [rax + al]			; push the ascii character into the buffer
		jmp checkkey							; ONE MORE TIME!

	exit:										; exit case
		@call,exit								; just exit lol
