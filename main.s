#################
# DATA          #
#################
.data

yes:
	.ascii "YES\n"

no:
	.ascii "NO\n"

#################
# TEXT          #
#################
.text

# --------------
# SUBFUNCTIONS

printYes:
	mov $yes, %rsi
	jmp exit

printNo:
	mov $no, %rsi
	jmp exit

opening:
	# update stack
	# push %r8
	# move to next letter
	inc %r8
	jmp loop

closing:
	# check stack'sum
	cmp %rbp, %rsp
	je printNo
	# pop to junk
	pop %r9
	# move to next letter
	inc %r8
	jmp loop


# --------------
# ENTRY POINT (init)

.global _start
_start:
	# save parameter in r8
	pop %rdx
	pop %rdx
	xor %r8, %r8
	pop %r8

	# empty stack
	mov %rbp, %rsp

# --------------
# LOGIC

loop:
	# move r8 value into rax
	mov (%r8), %al

	# check if it's the end
	test %al, %al
	jz printYes

	# if current letter = (
	cmp $40, %rax
	je opening

	# if current letter = )
	cmp $41, %rax
	je closing

	# loop
	jmp loop


exit:
	# print yes or no"
	# RSI MUST BE INIT
	mov $1, %rax
	xor %rdi, %rdi
	mov $1, %rdx
	syscall

	# exit(0)
	mov $60, %rax
	xor %rdi, %rdi
	syscall
