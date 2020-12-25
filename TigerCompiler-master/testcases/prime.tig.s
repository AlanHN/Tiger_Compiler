.text
.globl tigermain
.type tigermain, @function
tigermain:
subq $24, %rsp

L19:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rsp, %rdi
addq $24, %rdi
call try
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L18
L18:


addq $24, %rsp
ret
.text
.globl try
.type try, @function
try:
subq $24, %rsp

L21:
movq %r14, 8(%rsp)
movq %r15, 0(%rsp)
movq %rdi, 16(%rsp)
movq 16(%rsp), %rdi
movq $56, %rsi
call check
movq %rax, %rdi
call printi
leaq .L7(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $23, %rsi
call check
movq %rax, %rdi
call printi
leaq .L8(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $71, %rsi
call check
movq %rax, %rdi
call printi
leaq .L9(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $72, %rsi
call check
movq %rax, %rdi
call printi
leaq .L10(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $173, %rsi
call check
movq %rax, %rdi
call printi
leaq .L11(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $181, %rsi
call check
movq %rax, %rdi
call printi
leaq .L12(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $281, %rsi
call check
movq %rax, %rdi
call printi
leaq .L13(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $659, %rsi
call check
movq %rax, %rdi
call printi
leaq .L14(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $729, %rsi
call check
movq %rax, %rdi
call printi
leaq .L15(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $947, %rsi
call check
movq %rax, %rdi
call printi
leaq .L16(%rip), %rdi
call print
movq 16(%rsp), %rdi
movq $945, %rsi
call check
movq %rax, %rdi
call printi
leaq .L17(%rip), %rdi
call print
movq 8(%rsp), %r14
movq 0(%rsp), %r15
jmp L20
L20:


addq $24, %rsp
ret
.section .rodata
.L17:
.int 1
.string "\x0A"
.section .rodata
.L16:
.int 1
.string "\x0A"
.section .rodata
.L15:
.int 1
.string "\x0A"
.section .rodata
.L14:
.int 1
.string "\x0A"
.section .rodata
.L13:
.int 1
.string "\x0A"
.section .rodata
.L12:
.int 1
.string "\x0A"
.section .rodata
.L11:
.int 1
.string "\x0A"
.section .rodata
.L10:
.int 1
.string "\x0A"
.section .rodata
.L9:
.int 1
.string "\x0A"
.section .rodata
.L8:
.int 1
.string "\x0A"
.section .rodata
.L7:
.int 1
.string "\x0A"
.text
.globl check
.type check, @function
check:
subq $24, %rsp

movq 8(%rsp), %r11

movq 0(%rsp), %rax

L23:
movq %rbx, %rcx
movq %r12, %rbx
movq %r13, %r8
movq %r14, %r9
movq %r15, %r10
movq %rdi, 16(%rsp)
movq %rsi, %r11
movq %r11, 8(%rsp)
movq $1, %rax
movq %rax, 0(%rsp)
movq $2, %rsi
L5:
movq $2, %rdi
movq 8(%rsp), %r11
movq %r11, %rax
xorq %rdx, %rdx
idivq %rdi
cmpq %rax, %rsi
jg L1
L6:
movq 8(%rsp), %r11
movq %r11, %rax
xorq %rdx, %rdx
idivq %rsi
imulq %rsi, %rax
movq 8(%rsp), %r11
cmpq %r11, %rax
je L2
L3:
movq $0, %rax
L4:
addq $1, %rsi
jmp L5
L2:
movq $0, %rax
movq %rax, 0(%rsp)
L1:
movq 0(%rsp), %rax
movq %rcx, %rbx
movq %rbx, %r12
movq %r8, %r13
movq %r9, %r14
movq %r10, %r15
jmp L22
L24:
movq $0, %rax
jmp L4
L22:


addq $24, %rsp
ret
