	.file "./testcases/qsort.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
.L31:
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
	call dosort


	leave
	ret

	.text
	.globl dosort
	.type dosort, @function
dosort:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L33:
	movq %rdi, -8(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call init
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rdx
	movq $1, %rax
	subq %rax, %rdx
	movq $0, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call quicksort
	movq $0, %rax
	movq %rax, -16(%rbp)
.L28:
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
	jle .L29
.L27:
	leaq .L1(%rip), %rdi
	call print
	jmp .L32
.L29:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-24, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $8, %rsi
	imulq %rsi, %rax
	addq %rax, %rcx
	movq (%rcx), %rdi
	call printi
	leaq .L1(%rip), %rdi
	call print
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $1, %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	jmp .L28
.L32:


	leave
	ret

	.text
	.globl quicksort
	.type quicksort, @function
quicksort:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
.L35:
	movq %rdi, -8(%rbp)
	movq %rdx, -24(%rbp)
	movq %rsi, -16(%rbp)
	movq -24(%rbp), %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %rdi
	movq $8, %r8
	movq %rsi, %rax
	imulq %r8, %rax
	addq %rax, %rdi
	movq (%rdi), %rdi
	movq -24(%rbp), %rax
	cmp %rax, %rsi
	jl .L24
.L25:
	movq $0, %rax
	jmp .L34
.L24:
.L22:
	movq -16(%rbp), %rax
	cmp %rcx, %rax
	jl .L23
.L5:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-24, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq -16(%rbp), %rcx
	movq %rdi, (%rax,%rcx,8)
	movq $1, %rax
	movq -16(%rbp), %rdx
	subq %rax, %rdx
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call quicksort
	movq -24(%rbp), %rdx
	movq $1, %rax
	movq -16(%rbp), %rsi
	addq %rax, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call quicksort
	jmp .L25
.L23:
.L12:
	movq -16(%rbp), %rax
	cmp %rcx, %rax
	jl .L6
.L7:
	movq $0, %r8
.L8:
	movq $0, %rax
	cmp %rax, %r8
	jne .L13
.L11:
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %r8
	movq $8, %r9
	movq %rcx, %rax
	imulq %r9, %rax
	addq %rax, %r8
	movq (%r8), %r8
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %rax
	movq -16(%rbp), %rdx
	movq %r8, (%rax,%rdx,8)
.L20:
	movq -16(%rbp), %rax
	cmp %rcx, %rax
	jl .L14
.L15:
	movq $0, %r8
.L16:
	movq $0, %rax
	cmp %rax, %r8
	jne .L21
.L19:
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %r8
	movq $8, %r9
	movq -16(%rbp), %rax
	imulq %r9, %rax
	addq %rax, %r8
	movq (%r8), %r8
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %rax
	movq %r8, (%rax,%rcx,8)
	jmp .L22
.L6:
	movq $1, %r8
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %r9
	movq $8, %r10
	movq %rcx, %rax
	imulq %r10, %rax
	addq %rax, %r9
	movq (%r9), %rax
	cmp %rax, %rdi
	jle .L9
.L10:
	movq $0, %r8
.L9:
	jmp .L8
.L13:
	movq $1, %rax
	subq %rax, %rcx
	jmp .L12
.L14:
	movq $1, %r8
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %r9
	movq $8, %r10
	movq -16(%rbp), %rax
	imulq %r10, %rax
	addq %rax, %r9
	movq (%r9), %rax
	cmp %rax, %rdi
	jge .L17
.L18:
	movq $0, %r8
.L17:
	jmp .L16
.L21:
	movq $1, %rdx
	movq -16(%rbp), %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	jmp .L20
.L34:


	leave
	ret

	.text
	.globl init
	.type init, @function
init:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L37:
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
	jmp .L36
.L4:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $-16, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	subq %rax, %rcx
	movq $-8, %rdx
	movq %rbp, %rax
	addq %rdx, %rax
	movq (%rax), %rax
	movq $-24, %rdx
	addq %rdx, %rax
	movq (%rax), %rdx
	movq $-16, %rsi
	movq %rbp, %rax
	addq %rsi, %rax
	movq (%rax), %rax
	movq %rcx, (%rdx,%rax,8)
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
.L36:


	leave
	ret

	.text
	.globl nop
	.type nop, @function
nop:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
.L39:
	movq %rdi, -8(%rbp)
	leaq .L1(%rip), %rdi
	call print


	leave
	ret

	.section .rodata
.L1:
	.string "\000\000\000\000"
