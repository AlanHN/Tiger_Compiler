.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $24, %rsp

L2:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rsp, %rdi
addq $24, %rdi
movq $2, %rsi
call a
movq %rax, %rdi
call printi
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L1
L1:


addq $24, %rsp
ret
.text
.globl a
.type a, @function
a:
subq $32, %rsp

L4:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 24(%rsp)
movq %rsi, 16(%rsp)
movq %rsp, %rdi
addq $32, %rdi
movq $3, %rsi
call b
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L3
L3:


addq $32, %rsp
ret
.text
.globl b
.type b, @function
b:
subq $8, %rsp


L6:
movq %rbx, %rax
movq %r12, %rdx
movq %r13, %rcx
movq %r14, %rbx
movq %r15, %r8
movq %rdi, 0(%rsp)
movq %rsi, %r10
movq 0(%rsp), %rdi
movq -16(%rdi), %rdi
addq %r10, %rdi
movq %rdi, %rax
movq %rax, %rbx
movq %rdx, %r12
movq %rcx, %r13
movq %rbx, %r14
movq %r8, %r15
jmp L5
L5:


addq $8, %rsp
ret
