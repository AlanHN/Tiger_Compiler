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
movq $9, %rsi
movq $4, %rdx
call g
movq %rax, %rdi
call printi
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L4
L4:


addq $24, %rsp
ret
.text
.globl g
.type g, @function
g:
subq $8, %rsp



L7:
movq %rbx, %r9
movq %r12, %r8
movq %r13, %rbx
movq %r14, %rcx
movq %r15, %rax
movq %rdi, 0(%rsp)
movq %rsi, %r11
movq %rdx, %r10
cmpq %r10, %r11
jg L1
L2:
movq %r10, %rdx
L3:
movq %rdx, %rax
movq %r9, %rbx
movq %r8, %r12
movq %rbx, %r13
movq %rcx, %r14
movq %rax, %r15
jmp L6
L1:
movq %r11, %rdx
jmp L3
L6:


addq $8, %rsp
ret
