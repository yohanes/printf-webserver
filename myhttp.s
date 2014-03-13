	.file	"min.c"
	.text
	.globl	main
	.type	main, @function
main:

	jmp .L0
.msg:
        .ascii "HTTP/1.0 200\r\nContent-type:text/html\r\n\r\n<h1>Hello World!</h1>"
.L0:
	lea .msg(%rip), %r13
.LFB0:
// used for parameter passing:  %rdi, %rsi, %rdx, %rcx, %r8 and %r9 is used
//    create this data on stack
//    0x02,0x00,0x1f,0x90, 0x00,0x00,0x00,0x00,
//    0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00
// 	---	
	
	movq %rsp, %rbx
	sub $16, %rbx
	xorq %rax, %rax
	pushq %rax	
//movq $0x901f0002, %rax
	movw $0x901f, %ax
	shl $16, %eax
	movb $2, %al
	pushq %rax
	xorl %edx, %edx
	xorl %esi, %esi 
//set esi to 1
	inc %esi
	mov %esi, %edi 
//set edi to 2
	inc %edi
	xorl %eax, %eax
	movb $0x29, %al
        syscall 
	mov %rax, %r10
//call bind
        //movl    $16, %edx
	xorl %edx, %edx
	movb $16, %dl
        movq    %rbx, %rsi
        movl    %eax, %edi
	xorl %eax, %eax
	movb $0x31, %al
        syscall 
//call listen
	xorl %eax, %eax
	movb $5, %al
        movl    %eax, %esi
	mov %r10, %rax
        movl    %eax, %edi
	xorl %eax, %eax
	movb $0x32, %al
        syscall 
.L1:
//call accept
        xorl    %edx, %edx
        xorl    %esi, %esi
	mov %r10, %rax
        movl    %eax, %edi
	xorl %eax, %eax
	movb $0x2b, %al
        syscall 
	mov %rax, %r12
//r12 is the client fd
//fork
//	xorl %eax, %eax
//	movb $0x39, %al
 //       syscall 
//	testl   %eax, %eax
//	jne .L1
//write
	xorq %rdx, %rdx
	//is string length
	mov $61,%dl
	mov %r13, %rsi 
	mov %r12, %rdi	
//eax was 0 because of fork
	xorl %eax, %eax
	inc %eax
	syscall
//shutdown
	xorl %esi, %esi
	inc %esi
	inc %esi
//	movl $2, %esi
	movq %r12, %rdi	
	xorl %eax, %eax
	movb $0x30, %al
	syscall
//close
	movq %r12, %rdi	
	xorl %eax, %eax
	movb $0x3, %al
	syscall

	jmp .L1
	ret

.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 4.8.2-16) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
