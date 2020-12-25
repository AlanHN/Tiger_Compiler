	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L9:
	movq %rdi, -8(%rbp)
	movq $5, %rax
	movq %rax, -16(%rbp)
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call printi
	movq $.L7, %rdi
	call print
	movq $2, %rsi
	movq %rbp, %rdi
	call g
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call printi


	leave
	ret

	.section .rodata
.L7:
	.int 1
	.string "\n"
	.text
	.globl g
	.type g, @function
g:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L11:
	movq %rdi, -8(%rbp)
	movq $1, %rax
	movq $3, %rcx
	cmp %rcx, %rsi
	jg .L1
.L2:
	movq $0, %rax
.L1:
	movq $0, %rcx
	cmp %rcx, %rax
	jne .L4
.L5:
	movq $4, %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq %rcx, -16(%rax)
	movq $0, %rax
.L6:
	jmp .L10
.L4:
	movq $.L3, %rdi
	call print
	jmp .L6
.L10:


	leave
	ret

	.section .rodata
.L3:
	.int 20
	.string "hey! Bigger than 3!\n"
