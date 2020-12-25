.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $88, %rsp

L32:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 32(%rsp)
movq %r14, 24(%rsp)
movq %r15, 16(%rsp)
movq $8, %rax
movq %rax, 72(%rsp)
movq %rsp, %rbx
addq $88, %rbx
addq $-24, %rbx
movq 72(%rsp), %rdi
movq $0, %rsi
call initArray
movq %rax, (%rbx)
movq %rsp, %rbx
addq $88, %rbx
addq $-32, %rbx
movq 72(%rsp), %rdi
movq $0, %rsi
call initArray
movq %rax, (%rbx)
movq %rsp, %rbx
addq $88, %rbx
addq $-40, %rbx
movq 72(%rsp), %rdi
movq 72(%rsp), %rax
addq %rax, %rdi
subq $1, %rdi
movq $0, %rsi
call initArray
movq %rax, (%rbx)
movq %rsp, %rbx
addq $88, %rbx
addq $-48, %rbx
movq 72(%rsp), %rdi
movq 72(%rsp), %rax
addq %rax, %rdi
subq $1, %rdi
movq $0, %rsi
call initArray
movq %rax, (%rbx)
movq %rsp, %rdi
addq $88, %rdi
movq $0, %rsi
call try
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 32(%rsp), %r13
movq 24(%rsp), %r14
movq 16(%rsp), %r15
jmp L31
L31:


addq $88, %rsp
ret
.text
.globl try
.type try, @function
try:
subq $64, %rsp

movq 24(%rsp), %r10

L34:
movq %rbx, 40(%rsp)
movq %r12, 48(%rsp)
movq %r13, 16(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 56(%rsp)
movq %rsi, %r10
movq %r10, 24(%rsp)
movq 56(%rsp), %rax
movq -16(%rax), %rax
movq 24(%rsp), %r10
cmpq %rax, %r10
je L28
L29:
movq $0, %rdx
movq %rdx, 32(%rsp)
L26:
movq 56(%rsp), %rax
movq -16(%rax), %rax
subq $1, %rax
movq 32(%rsp), %rdx
cmpq %rax, %rdx
jg L14
L27:
movq $0, %rsi
movq $0, %rdi
movq 56(%rsp), %rax
movq -24(%rax), %rax
movq 32(%rsp), %rdx
imulq $8, %rdx
addq %rdx, %rax
movq (%rax), %rdx
movq $0, %rax
cmpq %rax, %rdx
je L15
L16:
L17:
movq $0, %rax
cmpq %rax, %rdi
jne L19
L20:
L21:
movq $0, %rax
cmpq %rax, %rsi
jne L23
L24:
movq $0, %rax
L25:
movq 32(%rsp), %rdx
addq $1, %rdx
movq %rdx, 32(%rsp)
jmp L26
L28:
movq 56(%rsp), %rdi
call printboard
L30:
movq 40(%rsp), %rbx
movq 48(%rsp), %r12
movq 16(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L33
L15:
movq 56(%rsp), %rax
movq -40(%rax), %rax
movq 32(%rsp), %rdx
movq 24(%rsp), %r10
addq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq (%rax), %rdx
movq $0, %rax
cmpq %rax, %rdx
jne L17
L18:
movq $1, %rdi
jmp L17
L19:
movq 56(%rsp), %rax
movq -48(%rax), %rax
movq 32(%rsp), %rdx
addq $7, %rdx
movq 24(%rsp), %r10
subq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq (%rax), %rdx
movq $0, %rax
cmpq %rax, %rdx
jne L21
L22:
movq $1, %rsi
jmp L21
L23:
movq 56(%rsp), %rax
movq -24(%rax), %rax
movq 32(%rsp), %rdx
imulq $8, %rdx
addq %rdx, %rax
movq $1, %rdx
movq %rdx, (%rax)
movq 56(%rsp), %rax
movq -40(%rax), %rax
movq 32(%rsp), %rdx
movq 24(%rsp), %r10
addq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq $1, %rdx
movq %rdx, (%rax)
movq 56(%rsp), %rax
movq -48(%rax), %rax
movq 32(%rsp), %rdx
addq $7, %rdx
movq 24(%rsp), %r10
subq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq $1, %rdx
movq %rdx, (%rax)
movq 56(%rsp), %rax
movq -32(%rax), %rdi
movq 24(%rsp), %r10
movq %r10, %rax
imulq $8, %rax
addq %rax, %rdi
movq 32(%rsp), %rdx
movq %rdx, (%rdi)
movq 56(%rsp), %rdi
movq 24(%rsp), %r10
movq %r10, %rsi
addq $1, %rsi
call try
movq 56(%rsp), %rax
movq -24(%rax), %rax
movq 32(%rsp), %rdx
imulq $8, %rdx
addq %rdx, %rax
movq $0, %rdx
movq %rdx, (%rax)
movq 56(%rsp), %rax
movq -40(%rax), %rax
movq 32(%rsp), %rdx
movq 24(%rsp), %r10
addq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq $0, %rdx
movq %rdx, (%rax)
movq 56(%rsp), %rax
movq -48(%rax), %rax
movq 32(%rsp), %rdx
addq $7, %rdx
movq 24(%rsp), %r10
subq %r10, %rdx
imulq $8, %rdx
addq %rdx, %rax
movq $0, %rdx
movq %rdx, (%rax)
movq $0, %rax
jmp L25
L14:
movq $0, %rax
jmp L30
L33:


addq $64, %rsp
ret
.text
.globl printboard
.type printboard, @function
printboard:
subq $56, %rsp

L36:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 40(%rsp)
movq %r14, 32(%rsp)
movq %r15, 24(%rsp)
movq %rdi, 48(%rsp)
movq $0, %rdx
movq %rdx, 16(%rsp)
L11:
movq 48(%rsp), %rax
movq -16(%rax), %rax
subq $1, %rax
movq 16(%rsp), %rdx
cmpq %rax, %rdx
jg L1
L12:
movq $0, %rbx
L8:
movq 48(%rsp), %rax
movq -16(%rax), %rax
subq $1, %rax
cmpq %rax, %rbx
jg L2
L9:
movq 48(%rsp), %rax
movq -32(%rax), %rax
movq 16(%rsp), %rdx
imulq $8, %rdx
addq %rdx, %rax
movq (%rax), %rax
cmpq %rbx, %rax
je L5
L6:
leaq .L4(%rip), %rdi
L7:
call print
addq $1, %rbx
jmp L8
L5:
leaq .L3(%rip), %rdi
jmp L7
L2:
leaq .L10(%rip), %rdi
call print
movq 16(%rsp), %rdx
addq $1, %rdx
movq %rdx, 16(%rsp)
jmp L11
L1:
leaq .L13(%rip), %rdi
call print
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 40(%rsp), %r13
movq 32(%rsp), %r14
movq 24(%rsp), %r15
jmp L35
L35:


addq $56, %rsp
ret
.section .rodata
.L13:
.int 1
.string "\x0A"
.section .rodata
.L10:
.int 1
.string "\x0A"
.section .rodata
.L4:
.int 2
.string "\x20\x2E"
.section .rodata
.L3:
.int 2
.string "\x20\x4F"
