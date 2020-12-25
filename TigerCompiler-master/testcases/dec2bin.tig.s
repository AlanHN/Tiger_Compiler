.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $24, %rsp

L13:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rsp, %rdi
addq $24, %rdi
call try
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L12
L12:


addq $24, %rsp
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
movq $100, %rdi
call printi
leaq .L4(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $100, %rsi
call dec2bin
leaq .L5(%rip), %rdi
call print
movq $200, %rdi
call printi
leaq .L6(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $200, %rsi
call dec2bin
leaq .L7(%rip), %rdi
call print
movq $789, %rdi
call printi
leaq .L8(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $789, %rsi
call dec2bin
leaq .L9(%rip), %rdi
call print
movq $567, %rdi
call printi
leaq .L10(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $567, %rsi
call dec2bin
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
.section .rodata
.L10:
.int 4
.string "\x09\x2D\x3E\x09"
.section .rodata
.L9:
.int 1
.string "\x0A"
.section .rodata
.L8:
.int 4
.string "\x09\x2D\x3E\x09"
.section .rodata
.L7:
.int 1
.string "\x0A"
.section .rodata
.L6:
.int 4
.string "\x09\x2D\x3E\x09"
.section .rodata
.L5:
.int 1
.string "\x0A"
.section .rodata
.L4:
.int 4
.string "\x09\x2D\x3E\x09"
.text
.globl dec2bin
.type dec2bin, @function
dec2bin:
subq $56, %rsp

movq 24(%rsp), %rax

L17:
movq %rbx, 32(%rsp)
movq %r12, 40(%rsp)
movq %r13, 16(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 48(%rsp)
movq %rsi, %rax
movq %rax, 24(%rsp)
movq $0, %rdi
movq 24(%rsp), %rax
cmpq %rdi, %rax
jg L1
L2:
movq $0, %rax
L3:
movq 32(%rsp), %rbx
movq 40(%rsp), %r12
movq 16(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L16
L1:
movq 48(%rsp), %rdi
movq $2, %rsi
movq 24(%rsp), %rax
xorq %rdx, %rdx
idivq %rsi
movq %rax, %rsi
call dec2bin
movq 24(%rsp), %rax
movq %rax, %rdi
movq $2, %rsi
movq 24(%rsp), %rax
xorq %rdx, %rdx
idivq %rsi
imulq $2, %rax
subq %rax, %rdi
call printi
jmp L3
L16:


addq $56, %rsp
ret
