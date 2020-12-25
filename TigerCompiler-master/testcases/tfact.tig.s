.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $24, %rsp

L5:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rsp, %rdi
addq $24, %rdi
movq $10, %rsi
call nfactor
movq %rax, %rdi
call printi
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L4
L4:


addq $24, %rsp
ret
.text
.globl nfactor
.type nfactor, @function
nfactor:
subq $48, %rsp


L7:
movq %rbx, 16(%rsp)
movq %r12, 24(%rsp)
movq %r13, 32(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 40(%rsp)
movq %rsi, %rax
movq $0, %rdx
cmpq %rdx, %rax
je L1
L2:
movq %rax, %rbx
movq 40(%rsp), %rdi
movq %rax, %rsi
subq $1, %rsi
call nfactor
movq %rax, %rdx
movq %rbx, %rax
imulq %rdx, %rax
L3:
movq 16(%rsp), %rbx
movq 24(%rsp), %r12
movq 32(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L6
L1:
movq $1, %rax
jmp L3
L6:


addq $48, %rsp
ret
