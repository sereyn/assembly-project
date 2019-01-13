#################
# DATA          #
#################
.data

yes:
	.string "YES\n"

no:
	.string "NO\n"

#################
# TEXT          #
#################
.text

# --------------
# SUBFUNCTIONS

printYes:
	mov $yes, %rsi
	mov $5, %rdx
	jmp exit

printNo:
	mov $no, %rsi
	mov $4, %rdx
	jmp exit

opening:
	# update stack
	push %r8
	inc %r10
	# move to next letter
	inc %r8
	jmp loop

closing:
	# is stack empty?
	test %r10, %r10
	jz printNo
	# pop to junk
	pop %r9
	dec %r10
	# move to next letter
	inc %r8
	jmp loop

check:
	test %r10, %r10
	jz printYes
	jmp printNo


# --------------
# ENTRY POINT (init)

.global _start
_start:
	# save text in r8
	pop %rdx
	pop %rdx
	xor %r8, %r8
	pop %r8

	# empty stack
	movq %rsp, %rbp
	# use r10 as stack length
	xor %r10, %r10

# --------------
# LOGIC

loop:
	# move r8 value into rax
	mov (%r8), %al

	# check if it's the end
	test %al, %al
	jz check

	# if current letter = (
	cmp $40, %rax
	je opening

	# if current letter = )
	cmp $41, %rax
	je closing

	# move to the next letter
	inc %r8

	# loop
	jmp loop


exit:
	# print yes or no"
	# RSI AND RDX MUST BE INIT
	mov $1, %rax
	xor %rdi, %rdi
	syscall

	# exit(0)
	mov $60, %rax
	xor %rdi, %rdi
	syscall
