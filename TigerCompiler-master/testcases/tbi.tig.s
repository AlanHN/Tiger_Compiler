.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $32, %rsp

L15:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq $8, %rax
movq %rax, 16(%rsp)
movq %rsp, %rdi
addq $32, %rdi
call printb
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L14
L14:


addq $32, %rsp
ret
.text
.globl printb
.type printb, @function
printb:
subq $56, %rsp

L17:
movq %rbx, 0(%rsp)
movq %r12, 8(%rsp)
movq %r13, 40(%rsp)
movq %r14, 32(%rsp)
movq %r15, 16(%rsp)
movq %rdi, 48(%rsp)
movq $0, %rdx
movq %rdx, 24(%rsp)
L11:
movq 48(%rsp), %rax
movq -16(%rax), %rax
subq $1, %rax
movq 24(%rsp), %rdx
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
movq 24(%rsp), %rdx
cmpq %rbx, %rdx
jg L5
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
movq 24(%rsp), %rdx
addq $1, %rdx
movq %rdx, 24(%rsp)
jmp L11
L1:
leaq .L13(%rip), %rdi
call print
movq 0(%rsp), %rbx
movq 8(%rsp), %r12
movq 40(%rsp), %r13
movq 32(%rsp), %r14
movq 16(%rsp), %r15
jmp L16
L16:


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
.int 1
.string "\x79"
.section .rodata
.L3:
.int 1
.string "\x78"
