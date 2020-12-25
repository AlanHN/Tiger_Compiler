	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
.L33:
	movq %rdi, -8(%rbp)
	movq $8, %rax
	movq %rax, -16(%rbp)
	movq $-24, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -72(%rbp) # spilled def 149
	movq $0, %rsi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call initArray
	movq -72(%rbp), %rcx # spilled use 149
	movq %rax, (%rcx)
	movq $-32, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -80(%rbp) # spilled def 147
	movq $0, %rsi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call initArray
	movq -80(%rbp), %rcx # spilled use 147
	movq %rax, (%rcx)
	movq $-40, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -56(%rbp) # spilled def 145
	movq $0, %rsi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	addq %rax, %rdi
	movq $1, %rax
	subq %rax, %rdi
	call initArray
	movq -56(%rbp), %rcx # spilled use 145
	movq %rax, (%rcx)
	movq $-48, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -64(%rbp) # spilled def 143
	movq $0, %rsi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	addq %rax, %rdi
	movq $1, %rax
	subq %rax, %rdi
	call initArray
	movq -64(%rbp), %rcx # spilled use 143
	movq %rax, (%rcx)
	movq $0, %rsi
	movq %rbp, %rdi
	call try


	leave
	ret

	.text
	.globl try
	.type try, @function
try:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
.L35:
	movq %rdi, -8(%rbp)
	movq %rsi, -24(%rbp) # spilled def 109
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq -24(%rbp), %rcx # spilled use 109
	cmp %rax, %rcx
	je .L29
.L30:
	movq $0, %rax
	movq %rax, -16(%rbp)
.L27:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-16, %rdx
	addq %rdx, %rax
	movq (%rax), %rax
	movq $1, %rdx
	subq %rdx, %rax
	cmp %rax, %rcx
	jle .L28
.L13:
	movq $0, %rax
.L31:
	jmp .L34
.L29:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call printboard
	jmp .L31
.L28:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-24, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $8, %rsi
	imulq %rsi, %rax
	addq %rax, %rcx
	movq (%rcx), %rax
	movq $0, %rcx
	cmp %rcx, %rax
	je .L14
.L15:
	movq $0, %rcx
.L16:
	movq $0, %rax
	cmp %rax, %rcx
	jne .L19
.L20:
	movq $0, %rcx
.L21:
	movq $0, %rax
	cmp %rax, %rcx
	jne .L24
.L25:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	jmp .L27
.L14:
	movq $1, %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-40, %rdx
	addq %rdx, %rax
	movq (%rax), %rsi
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq -24(%rbp), %rdx # spilled use 109
	addq %rdx, %rax
	movq $8, %rdi
	imulq %rdi, %rax
	addq %rax, %rsi
	movq (%rsi), %rax
	movq $0, %rdx
	cmp %rdx, %rax
	je .L17
.L18:
	movq $0, %rcx
.L17:
	jmp .L16
.L19:
	movq $1, %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-48, %rdx
	addq %rdx, %rax
	movq (%rax), %rsi
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $7, %rdx
	addq %rdx, %rax
	movq -24(%rbp), %rdx # spilled use 109
	subq %rdx, %rax
	movq $8, %rdi
	imulq %rdi, %rax
	addq %rax, %rsi
	movq (%rsi), %rax
	movq $0, %rdx
	cmp %rdx, %rax
	je .L22
.L23:
	movq $0, %rcx
.L22:
	jmp .L21
.L24:
	movq $1, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-24, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq %rsi, (%rcx,%rax,8)
	movq $1, %rdx
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-40, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rsi
	movq %rbp, %rax
	addq %rsi, %rax
	movq (%rax), %rax
	movq -24(%rbp), %rsi # spilled use 109
	addq %rsi, %rax
	movq %rdx, (%rcx,%rax,8)
	movq $1, %rdx
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-48, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rsi
	movq %rbp, %rax
	addq %rsi, %rax
	movq (%rax), %rax
	movq $7, %rsi
	addq %rsi, %rax
	movq -24(%rbp), %rsi # spilled use 109
	subq %rsi, %rax
	movq %rdx, (%rcx,%rax,8)
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-32, %rdx
	addq %rdx, %rax
	movq (%rax), %rax
	movq -24(%rbp), %rdx # spilled use 109
	movq %rcx, (%rax,%rdx,8)
	movq $1, %rax
	movq -24(%rbp), %rsi # spilled use 109
	addq %rax, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call try
	movq $0, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-24, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq %rsi, (%rcx,%rax,8)
	movq $0, %rdx
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-40, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rsi
	movq %rbp, %rax
	addq %rsi, %rax
	movq (%rax), %rax
	movq -24(%rbp), %rsi # spilled use 109
	addq %rsi, %rax
	movq %rdx, (%rcx,%rax,8)
	movq $0, %rdx
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-48, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rsi
	movq %rbp, %rax
	addq %rsi, %rax
	movq (%rax), %rax
	movq $7, %rsi
	addq %rsi, %rax
	movq -24(%rbp), %rsi # spilled use 109
	subq %rsi, %rax
	movq %rdx, (%rcx,%rax,8)
	jmp .L25
.L34:


	leave
	ret

	.text
	.globl printboard
	.type printboard, @function
printboard:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
.L37:
	movq %rdi, -8(%rbp)
	movq $0, %rax
	movq %rax, -16(%rbp)
.L11:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-16, %rdx
	addq %rdx, %rax
	movq (%rax), %rax
	movq $1, %rdx
	subq %rdx, %rax
	cmp %rax, %rcx
	jle .L12
.L1:
	movq $.L10, %rdi
	call print
	jmp .L36
.L12:
	movq $0, %rax
	movq %rax, -24(%rbp)
.L8:
	movq $-24, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-16, %rdx
	addq %rdx, %rax
	movq (%rax), %rax
	movq $1, %rdx
	subq %rdx, %rax
	cmp %rax, %rcx
	jle .L9
.L2:
	movq $.L10, %rdi
	call print
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	jmp .L11
.L9:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-32, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $8, %rsi
	imulq %rsi, %rax
	addq %rax, %rcx
	movq (%rcx), %rcx
	movq $-24, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	cmp %rax, %rcx
	je .L5
.L6:
	movq $.L4, %rdi
.L7:
	call print
	movq $-24, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq %rax, -24(%rbp)
	jmp .L8
.L5:
	movq $.L3, %rdi
	jmp .L7
.L36:


	leave
	ret

	.section .rodata
.L10:
	.int 1
	.string "\n"
	.section .rodata
.L4:
	.int 2
	.string " ."
	.section .rodata
.L3:
	.int 2
	.string " O"
