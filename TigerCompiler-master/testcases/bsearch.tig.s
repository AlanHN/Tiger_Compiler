.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $64, %rsp

L13:
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
call try
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 32(%rsp), %r13
movq 24(%rsp), %r14
movq 16(%rsp), %r15
jmp L12
L12:


addq $64, %rsp
ret
.text
.globl try
.type try, @function
try:
subq $24, %rsp

L15:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 16(%rsp)
movq 16(%rsp), %rdi
call init
movq 16(%rsp), %rdi
movq $0, %rsi
movq 16(%rsp), %rax
movq -16(%rax), %rdx
subq $1, %rdx
movq $7, %rcx
call bsearch
movq %rax, %rdi
call printi
leaq .L11(%rip), %rdi
call print
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L14
L14:


addq $24, %rsp
ret
.section .rodata
.L11:
.int 1
.string "\x0A"
.text
.globl bsearch
.type bsearch, @function
bsearch:
subq $72, %rsp

movq 24(%rsp), %rax

movq 56(%rsp), %r10

movq 32(%rsp), %rax


L17:
movq %rbx, 40(%rsp)
movq %r12, 48(%rsp)
movq %r13, 16(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 64(%rsp)
movq %rsi, %rax
movq %rax, 24(%rsp)
movq %rdx, %r10
movq %r10, 56(%rsp)
movq %rcx, %rax
movq %rax, 32(%rsp)
movq 56(%rsp), %r10
movq 24(%rsp), %rax
cmpq %r10, %rax
je L8
L9:
movq 24(%rsp), %rax
movq 56(%rsp), %r10
addq %r10, %rax
movq $2, %rdi
xorq %rdx, %rdx
idivq %rdi
movq %rax, %r11
movq 64(%rsp), %rax
movq -24(%rax), %rdx
movq %r11, %rax
imulq $8, %rax
addq %rax, %rdx
movq (%rdx), %rdx
movq 32(%rsp), %rax
cmpq %rax, %rdx
jl L5
L6:
movq 64(%rsp), %rdi
movq 24(%rsp), %rax
movq %rax, %rsi
movq %r11, %rdx
movq 32(%rsp), %rax
movq %rax, %rcx
call bsearch
L7:
L10:
movq 40(%rsp), %rbx
movq 48(%rsp), %r12
movq 16(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L16
L8:
movq 24(%rsp), %rax
jmp L10
L5:
movq 64(%rsp), %rdi
movq %r11, %rsi
addq $1, %rsi
movq 56(%rsp), %r10
movq %r10, %rdx
movq 32(%rsp), %rax
movq %rax, %rcx
call bsearch
jmp L7
L16:


addq $72, %rsp
ret
.text
.globl init
.type init, @function
init:
subq $48, %rsp

L19:
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
movq %rbx, %rdx
imulq $2, %rdx
addq $1, %rdx
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
jmp L18
L18:


addq $48, %rsp
ret
.text
.globl nop
.type nop, @function
nop:
subq $24, %rsp

L21:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 16(%rsp)
leaq .L1(%rip), %rdi
call print
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L20
L20:


addq $24, %rsp
ret
.section .rodata
.L1:
.int 0
.string ""
