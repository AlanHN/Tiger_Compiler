.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $48, %rsp


movq 0(%rsp), %rax

L2:
movq %r14, 16(%rsp)
movq %r15, 8(%rsp)
movq $16, %rdi
call allocRecord
movq $4, %rdx
movq %rdx, 0(%rax)
movq $3, %rdx
movq %rdx, 8(%rax)
movq %rax, 0(%rsp)
movq 0(%rsp), %rax
movq 8(%rax), %rdi
call printi
movq 0(%rsp), %rax
movq 0(%rax), %rdi
call printi
movq 16(%rsp), %r14
movq 8(%rsp), %r15
jmp L1
L1:


addq $48, %rsp
ret
