#DEFINE,SAVE
		; SAVE macro - glb.macro
		
		; R15 - pointer to STATE (mem)
		; R14 - scratch
		; R13 - ARG1
		; R12 - ARG2
		
		XOR R15, R15
		XOR R14, R14
		
		XOR R13, R13
		XOR R12, R12		

		MOV R13, %ARG1
		MOV R12, %ARG2		
	
		@CALL,PARSESTATE,[R13],[R14] ; parse filesystem
		
		MOV R15, R8 ; move location to new point (separate for clarity) 

		
		; save logic
		
		; GPRs
		MOV [R15 + 0*8], RAX
		MOV [R15 + 1*8], RBX
		MOV [R15 + 2*8], RCX
		MOV [R15 + 3*8], RDX
		MOV [R15 + 4*8], RBP
		MOV [R15 + 5*8], RSP
		MOV [R15 + 6*8], RSI
		MOV [R15 + 7*8], RDI	
		; MOV [R15 + 8*8], R8 - used by PARSESTATE
		; MOV [R15 + 9*8], R9 - used by PARSESTATE
		; MOV [R15 + 10*8], R10 - used by PARSESTATE
		; MOV [R15 + 11*8], R11 - used by PARSESTATE
		; MOV [R15 + 12*8], R12 - used here
		; MOV [R15 + 13*8], R13 - used here		
		; MOV [R15 + 14*8], R14 - used here
		; MOV [R15 + 15*8], R15 - used here
		
		; RIP
		MOV R14, [RSP]
		MOV [R15+ 16*8], R14
		
		; RFLAGS
		PUSHFQ
		POP R14
		MOV [R15 + 17*8], R14
		
		; control
		MOV R14, CR0
		MOV [R15 + 18*8], R14

		MOV R14, CR3
		MOV [R15 + 19*8], R14

		MOV R14, CR4
		MOV [R15 + 20*8], R14

		; FPU
		LEA R14, [R15 + 256] ; offset 256 (give room to align)
		AND R14, -512 ; align to 512 bytes (required by FXSAVE)
		FXSAVE64, [R14]	

		; ZMM
		LEA R14, [R15 + 1024] ; start at 1024 for space
		
		VMOVDQA64 [R14 + 0*64], ZMM0
		VMOVDQA64 [R14 + 1*64], ZMM1
		VMOVDQA64 [R14 + 2*64], ZMM2
		VMOVDQA64 [R14 + 3*64], ZMM3
		VMOVDQA64 [R14 + 4*64], ZMM4
		VMOVDQA64 [R14 + 5*64], ZMM5
		VMOVDQA64 [R14 + 6*64], ZMM6
		VMOVDQA64 [R14 + 7*64], ZMM7
		VMOVDQA64 [R14 + 8*64], ZMM8
		VMOVDQA64 [R14 + 9*64], ZMM9
		VMOVDQA64 [R14 + 10*64], ZMM10
		VMOVDQA64 [R14 + 11*64], ZMM11
		VMOVDQA64 [R14 + 12*64], ZMM12
		VMOVDQA64 [R14 + 13*64], ZMM13
		VMOVDQA64 [R14 + 14*64], ZMM14
		VMOVDQA64 [R14 + 15*64], ZMM15
		VMOVDQA64 [R14 + 16*64], ZMM16
		VMOVDQA64 [R14 + 17*64], ZMM17
		VMOVDQA64 [R14 + 18*64], ZMM18
		VMOVDQA64 [R14 + 19*64], ZMM19
		VMOVDQA64 [R14 + 20*64], ZMM20
		VMOVDQA64 [R14 + 21*64], ZMM21
		VMOVDQA64 [R14 + 22*64], ZMM22
		VMOVDQA64 [R14 + 23*64], ZMM23
		VMOVDQA64 [R14 + 24*64], ZMM24
		VMOVDQA64 [R14 + 25*64], ZMM25
		VMOVDQA64 [R14 + 26*64], ZMM26
		VMOVDQA64 [R14 + 27*64], ZMM27
		VMOVDQA64 [R14 + 28*64], ZMM28
		VMOVDQA64 [R14 + 29*64], ZMM29
		VMOVDQA64 [R14 + 30*64], ZMM30
		VMOVDQA64 [R14 + 31*64], ZMM31
&ENDSEC,SAVE

#DEFINE,INCASCII
		; INCASCII macro - glb.macro
		
		; R10 - pointer to location (assumes low)

		XOR R10, R10
		MOV R10, %ARG1
				
	cmp:
		CMP R10, 57 ; check if =9
		JZ is ; jmp if =9
		INC [R10]

	is:
		ADD R10, 8 ; inc to next value
		JMP cmp				

&ENDSEC,INCASCII

#DEFINE,DECASCII
		; DECASCII macro - glb.macro
	
		; R10 - pointer to location (assumes high)

		XOR R10, R10
		MOV R10, %ARG1

	cmp:
		CMP R10, 48 ; check if =0
		JZ is ; jmp if =0
		DEC [R10]

	is:
		SUB R10, 8 ; dec to next value
		JMP cmp	
&ENDSEC,DECASCII


#DEFINE,YIELD
		; YIELD macro - glb.macro

		; THIS IS NOT DONE

		; R12 - arg1
		; R13 - arg2
		; R11 - current memfs
		; R10 - current ID

		XOR R13, R13
		XOR R12, R12
		XOR R11, R11
		XOR R10, R10

		MOV R13, %ARG1
		MOV R14, %ARG2

		MOV R11, RAX ; move the current memfs into R11 for clarity
		@CALL,PARSEITEM,sysstate,R11 ; get the location of sysstate
		MOV R10, [R8 + 2] ; location of the sysstate + 2 to get the current ID

		; edit system state info
		MOV [R10], R13 ; set controlling process

		; ARG1 in R13
		; ARG2 on R14
		; curremnt memfs in R11
		; current (controlling) process in R10

&ENDSEC,YIELD
		
#DEFINE,PARSEITEM
		
		; PARSEITEM macro - glb.macro

		; R10 - output file location
		; R11 - output file size
		; R8  - arg1 input
		; R9  - arg2 input
		; R12 - R15 - scratch

		XOR R10, R10
		XOR R11, R11

		MOV R8, %ARG1
		MOV R9, %ARG2

		XOR R12, R12
		MOV R11, 64
		
	scanfs:
		MOV R13, R12 ; memfs canidate metadata base
		MOV R14, R8 ; pointer to filesystem name to cmp
		MOV R15, 12 ; length of name

	cmp_name:
		MOV R12b, [R13] ; load byte from canidate
		MOV R13b, [R14] ; load byte from fs name
		CMP R12b, R13b
		JNE adv ; not equal - advance canidate
		TEST R12b, R12b
		JE foundfs ; end if match
		INC R13 ; inc canidate pointer

		DEC R15
		JNZ cmp_name

	foundfs:
		ADD R13, 64 ; skip metadata
		XOR R14, R14 ; entry counter

	scanen:
		MOV R15, R13 ; file entry point
		ADD R15, R14*64 ; offset for entry
		CMP R14, R9 ; check if reached desired index
		JE founden
		INC R14
		JMP scanen
		
	founden:
		MOV R10, R15 ; output = file data address
		RET

	adv:
		INC R12 ; inc mem pointer
		JMP scanfs

&ENDSEC,PARSEMEMFS
