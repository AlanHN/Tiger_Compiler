	.file "./testcases/dec2bin.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L7:
	movq %rdi, -8(%rbp)
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
	subq $8, %rsp
.L9:
	movq %rdi, -8(%rbp)
	movq $100, %rdi
	call printi
	leaq .L4(%rip), %rdi
	call print
	movq $100, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	leaq .L5(%rip), %rdi
	call print
	movq $200, %rdi
	call printi
	leaq .L4(%rip), %rdi
	call print
	movq $200, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	leaq .L5(%rip), %rdi
	call print
	movq $789, %rdi
	call printi
	leaq .L4(%rip), %rdi
	call print
	movq $789, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	leaq .L5(%rip), %rdi
	call print
	movq $567, %rdi
	call printi
	leaq .L4(%rip), %rdi
	call print
	movq $567, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	leaq .L5(%rip), %rdi
	call print


	leave
	ret

	.section .rodata
.L5:
	.string "\001\000\000\000\012"
	.section .rodata
.L4:
	.string "\004\000\000\000\011->\011"
	.text
	.globl dec2bin
	.type dec2bin, @function
dec2bin:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L11:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq $0, %rax
	movq -16(%rbp), %rcx
	cmp %rax, %rcx
	jg .L1
.L2:
	movq $0, %rax
	jmp .L10
.L1:
	movq $2, %rcx
	movq -16(%rbp), %rax
	cltd
	idivq %rcx
	movq %rax, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	movq $2, %rcx
	movq -16(%rbp), %rax
	cltd
	idivq %rcx
	movq $2, %rcx
	imulq %rcx, %rax
	movq -16(%rbp), %rdi
	subq %rax, %rdi
	call printi
	jmp .L2
.L10:


	leave
	ret

