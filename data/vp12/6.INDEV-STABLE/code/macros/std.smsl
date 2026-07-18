#define,init

												; init macro - std.smsl

												; this macro will initalize stuff

												; clobbers
												; r8, r9, r10, r12, r13, r14, r15

		!!myfs,rax								; define the *myfs variable
		@call,parsefs,'fsys','*myfs','fsys','nocreat'	; get the fsys file
		mov byte [r8 + 191]
		!!myid,r10								; define the *myid variable

												; define the hardware-related variables
		!dsplfs,memfs01
		!multiplexer,1
		!display,2
		!tty,3

		!kbdfs,memfs02
		!kdb,1

		!diskfs,memfs03
		!disk,1
		!fs,2

&endsec.init

#define,dial

												; dial macro - std.smsl

												; arguments
												; arg1 - fs
												; arg2 - procid
												; arg3 - buffname

												; returns
												; r12 as 1 if exists
												; r11 as size of buffer
												; r8 as pointer to start of buffer data
												

		@call,init								; init stuff
		@call,parsefs,'buff','%arg1','%arg2.b%arg3','nocreat' 	; get the buffer, do not create 
		mov r11, [r8 + 188]						; set the size of the buffer
		add r8, 192								; set the start of the data area of the buffer
												; r12 should already have been set by parsefs

&endsec,dial

#define,create
												; create macro - std.smsl

												; arguments
												; arg1 - fs
												; arg2 - procid
												; arg3 - size
												; arg4 - buffname

												; returns
												; r12 as 1 if created
												; r11 as size of buffer
												; r8 as pointer to start of buffer data

		@call,parsefs,'buff','%arg1','%arg2.b%arg4','creat' 	; create the buffer file
		mov r11, [r8 + 192]						; set the size of the buffer
		add r8, 192								; set the start of the data area of the buffer
												; r12 should already have been set by parsefs

&endsec,create