.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $56, %rsp

movq 16(%rsp), %rax

L8:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 40(%rsp)
movq %r14, 32(%rsp)
movq %r15, 24(%rsp)
movq $4, %rax
movq %rax, 16(%rsp)
movq $0, %rbx
L5:
movq 16(%rsp), %rax
cmpq %rax, %rbx
jg L1
L6:
movq %rbx, %rdi
call printi
movq $3, %rax
cmpq %rax, %rbx
je L2
L3:
movq $0, %rax
L4:
addq $1, %rbx
jmp L5
L2:
L1:
movq $0, %rax
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 40(%rsp), %r13
movq 32(%rsp), %r14
movq 24(%rsp), %r15
jmp L7
L9:
movq $0, %rax
jmp L4
L7:


addq $56, %rsp
ret
