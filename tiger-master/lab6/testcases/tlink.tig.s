	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L2:
	movq %rdi, -8(%rbp)
	movq $2, %rsi
	movq %rbp, %rdi
	call a
	movq %rax, %rdi
	call printi


	leave
	ret

	.text
	.globl a
	.type a, @function
a:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L4:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq $3, %rsi
	movq %rbp, %rdi
	call b


	leave
	ret

	.text
	.globl b
	.type b, @function
b:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L6:
	movq %rdi, -8(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	addq %rsi, %rax


	leave
	ret

