	.file "./testcases/twhi.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L8:
	movq %r15, -16(%rbp)
	movq %rdi, -8(%rbp)
	movq $10, %r15
.L5:
	movq $0, %rax
	cmp %rax, %r15
	jge .L6
.L1:
	movq $0, %rax
	movq -16(%rbp), %r15
	jmp .L7
.L6:
	movq %r15, %rdi
	call printi
	movq $1, %rax
	subq %rax, %r15
	movq $2, %rax
	cmp %rax, %r15
	je .L2
.L3:
	jmp .L5
.L2:
	jmp .L1
.L7:


	leave
	ret

