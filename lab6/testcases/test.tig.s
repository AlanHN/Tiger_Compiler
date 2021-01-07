	.file "testcases/test.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L2:
	movq %rdi, -8(%rbp)
	movq $1, %rdi
	movq $0, %rsi
	call initArray
	movq %rax, %rcx
	movq $0, %rax
	movq $8, %rsi
	imulq %rsi, %rax
	addq %rax, %rcx
	movq (%rcx), %rdi
	call printi


	leave
	ret

