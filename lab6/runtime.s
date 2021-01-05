	.file	"runtime.c"
	.text
	.globl	initArray
	.type	initArray, @function
initArray:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	-20(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L2
.L3:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	-24(%rbp), %eax
	cltq
	movq	%rax, (%rdx)
	addl	$1, -12(%rbp)
.L2:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L3
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	initArray, .-initArray
	.globl	allocRecord
	.type	allocRecord, @function
allocRecord:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	-36(%rbp), %eax
	cltq
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L6
.L7:
	movq	-16(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -16(%rbp)
	movl	$0, (%rax)
	movl	-20(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -20(%rbp)
.L6:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L7
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	allocRecord, .-allocRecord
	.globl	stringEqual
	.type	stringEqual, @function
stringEqual:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L10
	movl	$1, %eax
	jmp	.L11
.L10:
	movq	-24(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	je	.L12
	movl	$0, %eax
	jmp	.L11
.L12:
	movl	$0, -4(%rbp)
	jmp	.L13
.L15:
	movq	-24(%rbp), %rdx
	movl	-4(%rbp), %eax
	cltq
	movzbl	4(%rdx,%rax), %ecx
	movq	-32(%rbp), %rdx
	movl	-4(%rbp), %eax
	cltq
	movzbl	4(%rdx,%rax), %eax
	cmpb	%al, %cl
	je	.L14
	movl	$0, %eax
	jmp	.L11
.L14:
	addl	$1, -4(%rbp)
.L13:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L15
	movl	$1, %eax
.L11:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	stringEqual, .-stringEqual
	.globl	print
	.type	print, @function
print:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L17
.L18:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	addl	$1, -12(%rbp)
	addq	$1, -8(%rbp)
.L17:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L18
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	print, .-print
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	printi
	.type	printi, @function
printi:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	printi, .-printi
	.globl	flush
	.type	flush, @function
flush:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	flush, .-flush
	.comm	consts,2048,32
	.globl	empty
	.bss
	.align 8
	.type	empty, @object
	.size	empty, 8
empty:
	.zero	8
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L22
.L23:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	consts(%rip), %rax
	movl	$1, (%rdx,%rax)
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+consts(%rip), %rax
	movb	%cl, (%rdx,%rax)
	addl	$1, -4(%rbp)
.L22:
	cmpl	$255, -4(%rbp)
	jle	.L23
	movl	$0, %edi
	movl	$0, %eax
	call	tigermain@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.globl	ord
	.type	ord, @function
ord:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L26
	movl	$-1, %eax
	jmp	.L27
.L26:
	movq	-8(%rbp), %rax
	movzbl	4(%rax), %eax
	movzbl	%al, %eax
.L27:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	ord, .-ord
	.section	.rodata
.LC1:
	.string	"chr(%d) out of range\n"
	.text
	.globl	chr
	.type	chr, @function
chr:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	js	.L29
	cmpl	$255, -4(%rbp)
	jle	.L30
.L29:
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %edi
	call	exit@PLT
.L30:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	consts(%rip), %rax
	addq	%rdx, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	chr, .-chr
	.globl	size
	.type	size, @function
size:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	size, .-size
	.section	.rodata
	.align 8
.LC2:
	.string	"substring([%d],%d,%d) out of range\n"
	.text
	.globl	substring
	.type	substring, @function
substring:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	cmpl	$0, -28(%rbp)
	js	.L35
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	addl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jle	.L36
.L35:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	-32(%rbp), %ecx
	movl	-28(%rbp), %edx
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %edi
	call	exit@PLT
.L36:
	cmpl	$1, -32(%rbp)
	jne	.L37
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %eax
	cltq
	movzbl	4(%rdx,%rax), %eax
	movzbl	%al, %eax
	leaq	0(,%rax,8), %rdx
	leaq	consts(%rip), %rax
	addq	%rdx, %rax
	jmp	.L38
.L37:
	movl	-32(%rbp), %eax
	cltq
	addq	$4, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	-32(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -12(%rbp)
	jmp	.L39
.L40:
	movl	-28(%rbp), %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	movq	-24(%rbp), %rdx
	cltq
	movzbl	4(%rdx,%rax), %ecx
	movq	-8(%rbp), %rdx
	movl	-12(%rbp), %eax
	cltq
	movb	%cl, 4(%rdx,%rax)
	addl	$1, -12(%rbp)
.L39:
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	.L40
	movq	-8(%rbp), %rax
.L38:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	substring, .-substring
	.globl	concat
	.type	concat, @function
concat:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L42
	movq	-32(%rbp), %rax
	jmp	.L43
.L42:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L44
	movq	-24(%rbp), %rax
	jmp	.L43
.L44:
	movq	-24(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	addl	%edx, %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	cltq
	addq	$4, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -16(%rbp)
	jmp	.L45
.L46:
	movq	-24(%rbp), %rdx
	movl	-16(%rbp), %eax
	cltq
	movzbl	4(%rdx,%rax), %ecx
	movq	-8(%rbp), %rdx
	movl	-16(%rbp), %eax
	cltq
	movb	%cl, 4(%rdx,%rax)
	addl	$1, -16(%rbp)
.L45:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -16(%rbp)
	jl	.L46
	movl	$0, -16(%rbp)
	jmp	.L47
.L48:
	movq	-24(%rbp), %rax
	movl	(%rax), %edx
	movl	-16(%rbp), %eax
	leal	(%rdx,%rax), %esi
	movq	-32(%rbp), %rdx
	movl	-16(%rbp), %eax
	cltq
	movzbl	4(%rdx,%rax), %ecx
	movq	-8(%rbp), %rdx
	movslq	%esi, %rax
	movb	%cl, 4(%rdx,%rax)
	addl	$1, -16(%rbp)
.L47:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -16(%rbp)
	jl	.L48
	movq	-8(%rbp), %rax
.L43:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	concat, .-concat
	.globl	not
	.type	not, @function
not:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	sete	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	not, .-not
	.globl	__wrap_getchar
	.type	__wrap_getchar, @function
__wrap_getchar:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	stdin(%rip), %rax
	movq	%rax, %rdi
	call	getc@PLT
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L52
	leaq	empty(%rip), %rax
	jmp	.L53
.L52:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	consts(%rip), %rax
	addq	%rdx, %rax
.L53:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	__wrap_getchar, .-__wrap_getchar
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
