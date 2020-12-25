.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $64, %rsp

L31:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 32(%rsp)
movq %r14, 24(%rsp)
movq %r15, 16(%rsp)
movq $16, %rax
movq %rax, 48(%rsp)
movq %rsp, %rbx
addq $64, %rbx
addq $-24, %rbx
movq 48(%rsp), %rdi
movq $0, %rsi
call initArray
movq %rax, (%rbx)
movq %rsp, %rdi
addq $64, %rdi
call dosort
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 32(%rsp), %r13
movq 24(%rsp), %r14
movq 16(%rsp), %r15
jmp L30
L30:


addq $64, %rsp
ret
.text
.globl dosort
.type dosort, @function
dosort:
subq $48, %rsp

L33:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 32(%rsp)
movq %r14, 24(%rsp)
movq %r15, 16(%rsp)
movq %rdi, 40(%rsp)
movq 40(%rsp), %rdi
call init
movq 40(%rsp), %rdi
movq $0, %rsi
movq 40(%rsp), %rax
movq -16(%rax), %rdx
subq $1, %rdx
call quicksort
movq $0, %rbx
L27:
movq 40(%rsp), %rax
movq -16(%rax), %rax
subq $1, %rax
cmpq %rax, %rbx
jg L25
L28:
movq 40(%rsp), %rax
movq -24(%rax), %rdx
movq %rbx, %rax
imulq $8, %rax
addq %rax, %rdx
movq (%rdx), %rdi
call printi
leaq .L26(%rip), %rdi
call print
addq $1, %rbx
jmp L27
L25:
leaq .L29(%rip), %rdi
call print
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 32(%rsp), %r13
movq 24(%rsp), %r14
movq 16(%rsp), %r15
jmp L32
L32:


addq $48, %rsp
ret
.section .rodata
.L29:
.int 1
.string "\x0A"
.section .rodata
.L26:
.int 1
.string "\x20"
.text
.globl quicksort
.type quicksort, @function
quicksort:
subq $80, %rsp


movq 40(%rsp), %rax

movq 32(%rsp), %r10

movq 48(%rsp), %rcx

movq 16(%rsp), %rcx

L35:
movq %rbx, 56(%rsp)
movq %r12, 64(%rsp)
movq %r13, 24(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 72(%rsp)
movq %rsi, %r11
movq %rdx, %rax
movq %rax, 40(%rsp)
movq %r11, %r10
movq %r10, 32(%rsp)
movq %rax, %rcx
movq %rcx, 48(%rsp)
movq 40(%rsp), %rax
movq %rax, %rcx
movq 72(%rsp), %rax
movq -24(%rax), %rax
movq %r11, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq (%rax), %rax
movq %rax, %rcx
movq %rcx, 16(%rsp)
movq 40(%rsp), %rax
cmpq %rax, %r11
jl L22
L23:
movq $0, %rax
L24:
movq 56(%rsp), %rbx
movq 64(%rsp), %r12
movq 24(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L34
L22:
L20:
movq 48(%rsp), %rcx
cmpq %rcx, %r10
movq 32(%rsp), %r10
cmpq %rcx, %r10
jl L21
L5:
movq 72(%rsp), %rax
movq -24(%rax), %rax
movq 32(%rsp), %r10
movq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq 16(%rsp), %rcx
movq %rcx, (%rax)
movq 72(%rsp), %rdi
movq %r11, %rsi
movq 32(%rsp), %r10
movq %r10, %rdx
subq $1, %rdx
call quicksort
movq 72(%rsp), %rdi
movq 32(%rsp), %r10
movq %r10, %rsi
addq $1, %rsi
movq 40(%rsp), %rax
movq %rax, %rdx
call quicksort
jmp L24
L21:
L11:
movq $0, %rax
movq 48(%rsp), %rcx
cmpq %rcx, %r10
movq 32(%rsp), %r10
cmpq %rcx, %r10
jl L7
L8:
L9:
movq $0, %rdx
cmpq %rdx, %rax
jne L12
L6:
movq 72(%rsp), %rax
movq -24(%rax), %rax
movq 32(%rsp), %r10
movq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq 72(%rsp), %rdx
movq -24(%rdx), %rdx
movq 48(%rsp), %rcx
movq %rcx, %rdi
imulq $8, %rdi
addq %rdi, %rdx
movq (%rdx), %rdx
movq %rdx, (%rax)
L18:
movq $0, %rax
movq 48(%rsp), %rcx
cmpq %rcx, %r10
movq 32(%rsp), %r10
cmpq %rcx, %r10
jl L14
L15:
L16:
movq $0, %rdx
cmpq %rdx, %rax
jne L19
L13:
movq 72(%rsp), %rax
movq -24(%rax), %rax
movq 48(%rsp), %rcx
movq %rcx, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq 72(%rsp), %rdx
movq -24(%rdx), %rdi
movq 32(%rsp), %r10
movq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rdi
movq (%rdi), %rdx
movq %rdx, (%rax)
jmp L20
L7:
movq 72(%rsp), %rdx
movq -24(%rdx), %rdi
movq 48(%rsp), %rcx
movq %rcx, %rdx
imulq $8, %rdx
addq %rdx, %rdi
movq (%rdi), %rdx
movq 16(%rsp), %rcx
cmpq %rdx, %rcx
jg L9
L10:
movq $1, %rax
jmp L9
L12:
movq 48(%rsp), %rcx
movq %rcx, %rax
subq $1, %rax
movq %rax, %rcx
movq %rcx, 48(%rsp)
jmp L11
L14:
movq 72(%rsp), %rdx
movq -24(%rdx), %rdi
movq 32(%rsp), %r10
movq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rdi
movq (%rdi), %rdx
movq 16(%rsp), %rcx
cmpq %rdx, %rcx
jl L16
L17:
movq $1, %rax
jmp L16
L19:
movq 32(%rsp), %r10
movq %r10, %rax
addq $1, %rax
movq %rax, %r10
movq %r10, 32(%rsp)
jmp L18
L34:


addq $80, %rsp
ret
.text
.globl init
.type init, @function
init:
subq $48, %rsp

L37:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 32(%rsp)
movq %r14, 24(%rsp)
movq %r15, 16(%rsp)
movq %rdi, 40(%rsp)
movq $0, %rbx
L3:
movq 40(%rsp), %rax
movq -16(%rax), %rax
subq $1, %rax
cmpq %rax, %rbx
jg L2
L4:
movq 40(%rsp), %rax
movq -24(%rax), %rax
movq %rbx, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq 40(%rsp), %rdx
movq -16(%rdx), %rdx
subq %rbx, %rdx
movq %rdx, (%rax)
movq 40(%rsp), %rdi
call nop
addq $1, %rbx
jmp L3
L2:
movq $0, %rax
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 32(%rsp), %r13
movq 24(%rsp), %r14
movq 16(%rsp), %r15
jmp L36
L36:


addq $48, %rsp
ret
.text
.globl nop
.type nop, @function
nop:
subq $24, %rsp

L39:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 16(%rsp)
leaq .L1(%rip), %rdi
call print
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L38
L38:


addq $24, %rsp
ret
.section .rodata
.L1:
.int 0
.string ""
