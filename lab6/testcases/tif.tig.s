	.file "./testcases/tif.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L5:
	movq %rdi, -8(%rbp)
	movq $4, %rdx
	movq $9, %rsi
	movq %rbp, %rdi
	call g
	movq %rax, %rdi
	call printi


	leave
	ret

	.text
	.globl g
	.type g, @function
g:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L7:
	movq %rdi, -8(%rbp)
	movq %rsi, %rax
	cmp %rdx, %rax
	jg .L1
.L2:
	movq %rdx, %rax
.L3:
	jmp .L6
.L1:
	jmp .L3
.L6:


	leave
	ret

