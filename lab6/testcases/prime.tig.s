	.file "./testcases/prime.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L9:
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
.L11:
	movq %rdi, -8(%rbp)
	movq $56, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $23, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $71, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $72, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $173, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $181, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $281, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $659, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $729, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $947, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print
	movq $945, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call check
	movq %rax, %rdi
	call printi
	leaq .L7(%rip), %rdi
	call print


	leave
	ret

	.section .rodata
.L7:
	.string "\001\000\000\000\012"
	.text
	.globl check
	.type check, @function
check:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L13:
	movq %rdi, -8(%rbp)
	movq $1, %rcx
	movq $2, %rax
	movq %rax, -16(%rbp)
.L5:
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rdi
	movq $2, %r8
	movq %rsi, %rax
	cltd
	idivq %r8
	cmp %rax, %rdi
	jle .L6
.L1:
	movq %rcx, %rax
	jmp .L12
.L6:
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rdi
	movq %rsi, %rax
	cltd
	idivq %rdi
	movq $-16, %rdi
	movq %rbp, %rdx
	addq %rdi, %rdx
	movq (%rdx), %rdi
	imulq %rdi, %rax
	cmp %rsi, %rax
	je .L2
.L3:
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $1, %rdx
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	jmp .L5
.L2:
	movq $0, %rcx
	jmp .L1
.L12:


	leave
	ret

