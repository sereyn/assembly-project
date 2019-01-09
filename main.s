.text
.global _start
_start:
	mov $1, %rax
	xor %rsi, %rsi
	syscall
