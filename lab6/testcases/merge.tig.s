	.file "./testcases/merge.tig"
	.text
	.globl tigermain
	.type tigermain, @function
tigermain:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
.L45:
	movq %rdi, -8(%rbp)
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -32(%rbp)
	call getchar
	movq -32(%rbp), %rcx
	movq %rax, (%rcx)
	movq %rbp, %rdi
	call readlist
	movq %rax, -24(%rbp)
	movq $-16, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq %rax, -40(%rbp)
	call getchar
	movq -40(%rbp), %rcx
	movq %rax, (%rcx)
	movq %rbp, %rdi
	call readlist
	movq %rax, %rdx
	movq -24(%rbp), %rsi
	movq %rbp, %rdi
	call merge
	movq %rax, %rsi
	movq %rbp, %rdi
	call printlist


	leave
	ret

	.text
	.globl printlist
	.type printlist, @function
printlist:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L47:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq $0, %rax
	movq -16(%rbp), %rcx
	cmp %rax, %rcx
	je .L41
.L42:
	movq $0, %rcx
	movq -16(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call printint
	leaq .L8(%rip), %rdi
	call print
	movq $8, %rcx
	movq -16(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call printlist
.L43:
	jmp .L46
.L41:
	leaq .L9(%rip), %rdi
	call print
	jmp .L43
.L46:


	leave
	ret

	.text
	.globl printint
	.type printint, @function
printint:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L49:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq $0, %rax
	movq -16(%rbp), %rcx
	cmp %rax, %rcx
	jl .L38
.L39:
	movq $0, %rax
	movq -16(%rbp), %rcx
	cmp %rax, %rcx
	jg .L35
.L36:
	leaq .L1(%rip), %rdi
	call print
.L37:
.L40:
	jmp .L48
.L38:
	leaq .L34(%rip), %rdi
	call print
	movq $0, %rsi
	movq -16(%rbp), %rax
	subq %rax, %rsi
	movq %rbp, %rdi
	call f
	jmp .L40
.L35:
	movq -16(%rbp), %rsi
	movq %rbp, %rdi
	call f
	jmp .L37
.L48:


	leave
	ret

	.section .rodata
.L34:
	.string "\001\000\000\000-"
	.text
	.globl f
	.type f, @function
f:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
.L51:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq $0, %rax
	movq -16(%rbp), %rcx
	cmp %rax, %rcx
	jg .L31
.L32:
	movq $0, %rax
	jmp .L50
.L31:
	movq $10, %rcx
	movq -16(%rbp), %rax
	cltd
	idivq %rcx
	movq %rax, %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call f
	movq $10, %rcx
	movq -16(%rbp), %rax
	cltd
	idivq %rcx
	movq $10, %rcx
	imulq %rcx, %rax
	movq -16(%rbp), %rcx
	subq %rax, %rcx
	movq %rcx, -24(%rbp)
	leaq .L1(%rip), %rdi
	call ord
	movq -24(%rbp), %rdi
	addq %rax, %rdi
	call chr
	movq %rax, %rdi
	call print
	jmp .L32
.L50:


	leave
	ret

	.text
	.globl merge
	.type merge, @function
merge:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
.L53:
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdx, -24(%rbp)
	movq $0, %rax
	movq -16(%rbp), %rcx
	cmp %rax, %rcx
	je .L28
.L29:
	movq $0, %rax
	movq -24(%rbp), %rcx
	cmp %rax, %rcx
	je .L25
.L26:
	movq $0, %rcx
	movq -16(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rcx
	movq $0, %rdx
	movq -24(%rbp), %rax
	addq %rdx, %rax
	movq (%rax), %rax
	cmp %rax, %rcx
	jl .L22
.L23:
	movq $16, %rdi
	call allocRecord
	movq %rax, -48(%rbp)
	movq $0, %rcx
	movq -24(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq -48(%rbp), %rcx
	movq %rax, 0(%rcx)
	movq $8, %rcx
	movq -48(%rbp), %rax
	addq %rcx, %rax
	movq %rax, -32(%rbp)
	movq $8, %rcx
	movq -24(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rdx
	movq -16(%rbp), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call merge
	movq -32(%rbp), %rcx
	movq %rax, (%rcx)
	movq -48(%rbp), %rax
.L24:
.L27:
.L30:
	jmp .L52
.L28:
	movq -24(%rbp), %rax
	jmp .L30
.L25:
	movq -16(%rbp), %rax
	jmp .L27
.L22:
	movq $16, %rdi
	call allocRecord
	movq %rax, -56(%rbp)
	movq $0, %rcx
	movq -16(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq -56(%rbp), %rcx
	movq %rax, 0(%rcx)
	movq $8, %rcx
	movq -56(%rbp), %rax
	addq %rcx, %rax
	movq %rax, -40(%rbp)
	movq -24(%rbp), %rdx
	movq $8, %rcx
	movq -16(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call merge
	movq -40(%rbp), %rcx
	movq %rax, (%rcx)
	movq -56(%rbp), %rax
	jmp .L24
.L52:


	leave
	ret

	.text
	.globl readlist
	.type readlist, @function
readlist:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
.L55:
	movq %rdi, -8(%rbp)
	movq $8, %rdi
	call allocRecord
	movq $0, %rcx
	movq %rcx, 0(%rax)
	movq %rax, -16(%rbp)
	movq -16(%rbp), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call readint
	movq %rax, -32(%rbp)
	movq $0, %rcx
	movq -16(%rbp), %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $0, %rcx
	cmp %rcx, %rax
	jne .L19
.L20:
	movq $0, %rax
.L21:
	jmp .L54
.L19:
	movq $16, %rdi
	call allocRecord
	movq %rax, -40(%rbp)
	movq -32(%rbp), %rax
	movq -40(%rbp), %rcx
	movq %rax, 0(%rcx)
	movq $8, %rcx
	movq -40(%rbp), %rax
	addq %rcx, %rax
	movq %rax, -24(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rdi
	call readlist
	movq -24(%rbp), %rcx
	movq %rax, (%rcx)
	movq -40(%rbp), %rax
	jmp .L21
.L54:


	leave
	ret

	.text
	.globl readint
	.type readint, @function
readint:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
.L57:
	movq %rdi, -8(%rbp)
	movq %rsi, -40(%rbp)
	movq $0, %rax
	movq %rax, -16(%rbp)
	movq %rbp, %rdi
	call skipto
	movq $0, %rcx
	movq -40(%rbp), %rax
	addq %rcx, %rax
	movq %rax, -24(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rsi
	movq %rbp, %rdi
	call isdigit
	movq -24(%rbp), %rcx
	movq %rax, (%rcx)
.L17:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rsi
	movq %rbp, %rdi
	call isdigit
	movq $0, %rcx
	cmp %rcx, %rax
	jne .L18
.L16:
	movq -16(%rbp), %rax
	jmp .L56
.L18:
	movq $10, %rcx
	movq -16(%rbp), %rax
	imulq %rcx, %rax
	movq %rax, -56(%rbp)
	movq -56(%rbp), %rax
	movq %rax, -64(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rdi
	call ord
	movq -64(%rbp), %rcx
	addq %rax, %rcx
	movq %rcx, -32(%rbp)
	leaq .L1(%rip), %rdi
	call ord
	movq -32(%rbp), %rcx
	subq %rax, %rcx
	movq %rcx, -16(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq %rax, -48(%rbp)
	call getchar
	movq -48(%rbp), %rcx
	movq %rax, (%rcx)
	jmp .L17
.L56:


	leave
	ret

	.text
	.globl skipto
	.type skipto, @function
skipto:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.L59:
	movq %rdi, -8(%rbp)
.L14:
	leaq .L8(%rip), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-8, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rdi
	call stringEqual
	movq $0, %rcx
	cmp %rcx, %rax
	jne .L10
.L11:
	leaq .L9(%rip), %rsi
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-8, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rdi
	call stringEqual
.L12:
	movq $0, %rcx
	cmp %rcx, %rax
	jne .L15
.L13:
	movq $0, %rax
	jmp .L58
.L10:
	movq $1, %rax
	jmp .L12
.L15:
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-8, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	call getchar
	movq -16(%rbp), %rcx
	movq %rax, (%rcx)
	jmp .L14
.L58:


	leave
	ret

	.section .rodata
.L9:
	.string "\001\000\000\000\012"
	.section .rodata
.L8:
	.string "\001\000\000\000 "
	.text
	.globl isdigit
	.type isdigit, @function
isdigit:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
.L61:
	movq %rdi, -8(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-8, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rdi
	call ord
	movq %rax, -24(%rbp)
	leaq .L1(%rip), %rdi
	call ord
	movq -24(%rbp), %rcx
	cmp %rax, %rcx
	jge .L3
.L4:
	movq $0, %rax
.L5:
	jmp .L60
.L3:
	movq $1, %rax
	movq %rax, -16(%rbp)
	movq $-8, %rcx
	movq %rbp, %rax
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-8, %rcx
	addq %rcx, %rax
	movq (%rax), %rax
	movq $-16, %rcx
	addq %rcx, %rax
	movq (%rax), %rdi
	call ord
	movq %rax, -32(%rbp)
	leaq .L2(%rip), %rdi
	call ord
	movq -32(%rbp), %rcx
	cmp %rax, %rcx
	jle .L6
.L7:
	movq $0, %rax
	movq %rax, -16(%rbp)
.L6:
	movq -16(%rbp), %rax
	jmp .L5
.L60:


	leave
	ret

	.section .rodata
.L2:
	.string "\001\000\000\0009"
	.section .rodata
.L1:
	.string "\001\000\000\0000"
