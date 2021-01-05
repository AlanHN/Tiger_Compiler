	.file "./testcases/tbi.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L14:
	movq %rdi, -8(%rbp)
	movq $8, %rax
	movq %rax, -16(%rbp)
	movq %rbp, %rdi
	call printb


	leave
	ret

	.text
	.globl printb
	.type printb, @function
printb:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
.L16:
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
	leaq .L10(%rip), %rdi
	call print
	jmp .L15
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
	leaq .L10(%rip), %rdi
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
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-24, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	cmp %rax, %rcx
	jg .L5
.L6:
	leaq .L4(%rip), %rdi
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
	leaq .L3(%rip), %rdi
	jmp .L7
.L15:


	leave
	ret

	.section .rodata
.L10:
	.string "\001\000\000\000\012"
	.section .rodata
.L4:
	.string "\001\000\000\000y"
	.section .rodata
.L3:
	.string "\001\000\000\000x"
