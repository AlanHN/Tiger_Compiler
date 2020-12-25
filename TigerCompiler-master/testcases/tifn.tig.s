.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $32, %rsp

L9:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq $5, %rax
movq %rax, 16(%rsp)
movq 16(%rsp), %rdi
call printi
leaq .L7(%rip), %rdi
call print
movq %rsp, %rdi
addq $32, %rdi
movq $2, %rsi
call g
movq 16(%rsp), %rdi
call printi
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L8
L8:


addq $32, %rsp
ret
.section .rodata
.L7:
.int 1
.string "\x0A"
.text
.globl g
.type g, @function
g:
subq $48, %rsp


L11:
movq %rbx, 24(%rsp)
movq %r12, 32(%rsp)
movq %r13, 16(%rsp)
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 40(%rsp)
movq %rsi, %rax
movq $1, %rdx
movq $3, %rdi
cmpq %rdi, %rax
jg L1
L2:
movq $0, %rdx
L1:
movq $0, %rax
cmpq %rax, %rdx
jne L4
L5:
movq $4, %rdx
movq 40(%rsp), %rax
movq %rdx, -16(%rax)
movq $0, %rax
L6:
movq 24(%rsp), %rbx
movq 32(%rsp), %r12
movq 16(%rsp), %r13
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L10
L4:
leaq .L3(%rip), %rdi
call print
jmp L6
L10:


addq $48, %rsp
ret
.section .rodata
.L3:
.int 20
.string "\x68\x65\x79\x21\x20\x42\x69\x67\x67\x65\x72\x20\x74\x68\x61\x6E\x20\x33\x21\x0A"
