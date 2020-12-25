.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $56, %rsp

movq 24(%rsp), %rdi

L8:
movq %rbx, 32(%rsp)
movq %r12, 40(%rsp)
movq %r13, 16(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq $10, %rdi
movq %rdi, 24(%rsp)
L5:
movq $0, %rax
movq 24(%rsp), %rdi
cmpq %rax, %rdi
jge L6
L1:
movq $0, %rax
movq 32(%rsp), %rbx
movq 40(%rsp), %r12
movq 16(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L7
L6:
movq 24(%rsp), %rdi
call printi
movq 24(%rsp), %rdi
subq $1, %rdi
movq %rdi, 24(%rsp)
movq $2, %rax
movq 24(%rsp), %rdi
cmpq %rax, %rdi
je L2
L3:
movq $0, %rax
L4:
jmp L5
L2:
jmp L1
L9:
movq $0, %rax
jmp L4
L7:


addq $56, %rsp
ret
