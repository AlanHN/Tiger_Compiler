	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L5:
	movq %rdi, -8(%rbp)
	movq $10, %rsi
	movq %rbp, %rdi
	call nfactor
	movq %rax, %rdi
	call printi


	leave
	ret

	.text
	.globl nfactor
	.type nfactor, @function
nfactor:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L7:
	movq %rdi, -8(%rbp)
	movq $0, %rax
	cmp %rax, %rsi
	je .L1
.L2:
	movq %rsi, -16(%rbp) # spilled def 133
	movq $1, %rax
	subq %rax, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call nfactor
	movq %rax, %rcx
	movq -16(%rbp), %rax # spilled use 133
	imulq %rcx, %rax
.L3:
	jmp .L6
.L1:
	movq $1, %rax
	jmp .L3
.L6:


	leave
	ret

