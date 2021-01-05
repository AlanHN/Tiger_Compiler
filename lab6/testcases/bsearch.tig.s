	.file "./testcases/bsearch.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
.L12:
	movq %rdi, -8(%rbp)
	movq $16, %rax
	movq %rax, -16(%rbp)
	movq $-24, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -32(%rbp)
	movq $0, %rsi
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call initArray
	movq -32(%rbp), %rcx
	movq %rax, (%rcx)
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
.L14:
	movq %rdi, -8(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call init
	movq $7, %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-16, %rdx
	addq %rdx, %rax
	movq (%rax), %rdx
	movq $1, %rax
	subq %rax, %rdx
	movq $0, %rsi
	movq $-8, %rdi
	movq %rbp, %rax
	addq %rdi, %rax
	movq (%rax), %rdi
	call bsearch
	movq %rax, %rdi
	call printi
	leaq .L1(%rip), %rdi
	call print


	leave
	ret

	.text
	.globl bsearch
	.type bsearch, @function
bsearch:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L16:
	movq %rdi, -8(%rbp)
	movq %rsi, %rdi
	movq %rdx, %r8
	cmp %r8, %rdi
	je .L8
.L9:
	movq %rdi, %rax
	addq %r8, %rax
	movq $2, %rsi
	cltd
	idivq %rsi
	movq %rax, %rsi
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %r9
	movq $8, %r10
	movq %rsi, %rax
	imulq %r10, %rax
	addq %rax, %r9
	movq (%r9), %rax
	cmp %rcx, %rax
	jl .L5
.L6:
	movq %rsi, %rdx
	movq %rdi, %rsi
	movq $-8, %rdi
	movq %rbp, %rax
	addq %rdi, %rax
	movq (%rax), %rdi
	call bsearch
.L7:
	movq %rax, %rdi
.L10:
	movq %rdi, %rax
	jmp .L15
.L8:
	jmp .L10
.L5:
	movq %r8, %rdx
	movq $1, %rax
	addq %rax, %rsi
	movq $-8, %rdi
	movq %rbp, %rax
	addq %rdi, %rax
	movq (%rax), %rdi
	call bsearch
	jmp .L7
.L15:


	leave
	ret

	.text
	.globl init
	.type init, @function
init:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L18:
	movq %rdi, -8(%rbp)
	movq $0, %rax
	movq %rax, -16(%rbp)
.L3:
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
	jle .L4
.L2:
	movq $0, %rax
	jmp .L17
.L4:
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $2, %rcx
	imulq %rcx, %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq $-8, %rdx
	movq %rbp, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq $-24, %rdx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movq $-16, %rsi
	movq %rbp, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movq %rax, (%rdx,%rcx,8)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call nop
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	jmp .L3
.L17:


	leave
	ret

	.text
	.globl nop
	.type nop, @function
nop:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L20:
	movq %rdi, -8(%rbp)
	leaq .L1(%rip), %rdi
	call print


	leave
	ret

	.section .rodata
.L1:
	.string "\000\000\000\000"
