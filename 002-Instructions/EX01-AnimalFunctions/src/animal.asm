.386
.MODEL FLAT, C

.CODE

goose PROC
	push ebp
	mov ebp, esp
	mov eax, -4
	pop ebp
	ret
goose ENDP

cow PROC
	push ebp
	mov ebp, esp
	mov eax, DWORD PTR [ebp+8]
	sub eax, DWORD PTR [ebp+12]
	pop ebp
	ret
cow ENDP

pig PROC
	push ebp
	mov ebp, esp
	mov eax, DWORD PTR [ebp+8]
	lea eax, [eax*2+eax]
	pop ebp
	ret
pig ENDP

sheep PROC
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	shr eax, 31
	pop ebp
	ret
sheep ENDP

duck PROC
	push ebp
	mov ebp, esp
	push ebx
	mov ebx, [ebp+8]
	push ebx
	call sheep
	mov edx, ebx
	cmp eax, 0
	je L6
	neg edx
L6:
	mov eax, edx
	add esp, 4
	pop ebx
	pop ebp
	ret
duck ENDP

END
