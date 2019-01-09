.data

msg:
	.ascii "loop\n"

.text
.global _start
_start:
	# save parameter in r8
	pop %rdx
	pop %rdx
	pop %r8
	
loop:
	mov $1, %rax
	xor %rdi, %rdi
	mov $msg, %rsi
	mov $6, %rdx
	syscall

exit:
	# exit(0)
	mov $60, %rax
	xor %rdi, %rdi
	syscall

