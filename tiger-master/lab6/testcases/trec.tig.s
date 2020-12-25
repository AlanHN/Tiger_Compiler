	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L2:
	movq %rdi, -8(%rbp)
	movq $16, %rdi
	call allocRecord
	movq $3, %rcx
	movq %rcx, 0(%rax)
	movq $4, %rcx
	movq %rcx, 8(%rax)
	movq %rax, -16(%rbp) # spilled def 110
	movq $0, %rcx
	movq -16(%rbp), %rax # spilled use 110
	addq %rcx, %rax
	movq (%rax), %rdi
	call printi
	movq $8, %rcx
	movq -16(%rbp), %rax # spilled use 110
	addq %rcx, %rax
	movq (%rax), %rdi
	call printi


	leave
	ret

