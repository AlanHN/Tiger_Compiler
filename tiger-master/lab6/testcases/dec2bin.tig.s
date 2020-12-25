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
	movq $.L4, %rdi
	call print
	movq $100, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	movq $.L5, %rdi
	call print
	movq $200, %rdi
	call printi
	movq $.L4, %rdi
	call print
	movq $200, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	movq $.L5, %rdi
	call print
	movq $789, %rdi
	call printi
	movq $.L4, %rdi
	call print
	movq $789, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	movq $.L5, %rdi
	call print
	movq $567, %rdi
	call printi
	movq $.L4, %rdi
	call print
	movq $567, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	movq $.L5, %rdi
	call print


	leave
	ret

	.section .rodata
.L5:
	.int 1
	.string "\n"
	.section .rodata
.L4:
	.int 4
	.string "\t->\t"
	.text
	.globl dec2bin
	.type dec2bin, @function
dec2bin:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L11:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp) # spilled def 109
	movq $0, %rax
	movq -16(%rbp), %rcx # spilled use 109
	cmp %rax, %rcx
	jg .L1
.L2:
	movq $0, %rax
	jmp .L10
.L1:
	movq $2, %rcx
	movq -16(%rbp), %rax # spilled use 109
	cltd
	idivq %rcx
	movq %rax, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call dec2bin
	movq $2, %rcx
	movq -16(%rbp), %rax # spilled use 109
	cltd
	idivq %rcx
	movq $2, %rcx
	imulq %rcx, %rax
	movq -16(%rbp), %rdi # spilled use 109
	subq %rax, %rdi
	call printi
	jmp .L2
.L10:


	leave
	ret

