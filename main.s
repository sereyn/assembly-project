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

# on opening/closing parenthese
opening:
	inc %r9
	inc %r8
	jmp loop
closing:
	inc %r10
	inc %r8
	jmp loop

# set message
setyes:
	mov $yes, %rsi
	jmp exit
setno:
	mov $no, %rsi
	jmp exit

# --------------
# ENTRY POINT (init)

.global _start
_start:
	# save parameter in r8
	pop %rdx
	pop %rdx
	xor %r8, %r8
	pop %r8

	# r9 is nbr of (
	xor %r9, %r9
	# r10 is nbr of )
	xor %r10, %r10

# --------------
# LOGIC

loop:
	# move r8 value into rax
	mov (%r8), %al

	# check if it's the end
	test %al, %al
	jz calc

	# if current letter = (
	cmp $40, %rax
	je opening

	# if current letter = )
	cmp $41, %rax
	je closing

	# move to next letter
	inc %r8

	# loop
	jmp loop

calc:
	cmp %r9, %r10
	je setyes
	jmp setno

exit:
	# print if "nb of (" = "nb of )"
	# RSI MUST BE INIT
	mov $1, %rax
	xor %rdi, %rdi
	mov $1, %rdx
	syscall

	# exit(0)
	mov $60, %rax
	xor %rdi, %rdi
	syscall
