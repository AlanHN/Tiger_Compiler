	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
.L8:
	movq %rdi, -8(%rbp)
	movq $4, %rax
	movq %rax, -24(%rbp) # spilled def 109
	movq $0, %rax
	movq %rax, -16(%rbp)
.L5:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq -24(%rbp), %rcx # spilled use 109
	cmp %rcx, %rax
	jle .L6
.L1:
	movq $0, %rax
	jmp .L7
.L6:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call printi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $3, %rcx
	cmp %rcx, %rax
	je .L2
.L3:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	jmp .L5
.L2:
	jmp .L1
.L7:


	leave
	ret

