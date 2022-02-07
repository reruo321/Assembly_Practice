# Example 01 - AnimalFunctions
The example shows simple example functions, which are the answers of [Problem 1 from the Internet](https://www.cs.cmu.edu/afs/cs/academic/class/15213-s03/www/asm_examples.pdf).
You can call these and test some cases using main.cpp I added.

**Warning: The original problem follows AT&T syntax, which has the opposite order for source and destination operands and other differences with that of Intel. You should be careful while interpreting it.**

## 1. goose()
    int goose(){ return -4; }

The first function goose() should return -4. If the assembly code is written correctly, it should be called and return the value onto the C++ main function.

    push ebp
    mov ebp, esp
    _______________
    pop ebp
    ret
    
This subroutine (function) follows callee rules.

    push ebp      ; save the old base pointer value
    mov ebp, esp  ; set the new base pointer value

First, push EBP value onto the stack so that we can restore its value after subroutine's returning. The base pointer acts as a convention on the stack, to point of reference for parameters and local variables. After that, move the stack pointer into EBP to set the reference point.

    ______________
    pop ebp
    ret

Something next happens, and before returning, restore the caller's base pointer value by popping EBP off the stack. When we finally execute ret, it will find and remove the appropriate return address from the stack.

OK, now it is the time to find an instruction for the blank. The function goose() does not take any parameters nor local variables, but only returns a constant -4. Where can we find return value from callee? It leaves the value in **EAX**. Therefore, by putting the -4 into EAX, it would return the constant.

    move eax, -4   ; This is the answer for goose().
    
If you filled the blank, let's test the output on this simple C++ program. Do not forget additional syntax to compile the assembly codes!

Assembly file:

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
	END

C++ file:

    #include <iostream>
    using namespace std;
    extern "C" { int goose(); }
    
    int main(){
	    cout << "int goose() = " << goose() << endl;  
        return 0;
    }
    
## 2. cow()
	int cow(int a, int b){ return a - b; }

The second function cow() gets two paramenters a and b, and it returns a - b.

	push ebp
	mov ebp, esp
	mov eax, DWORD PTR [ebp+8]
	__________________________
	pop ebp
	ret
	
And this is our assembly codes. Try to see line 3 and line 4 mainly, since the others are start and end of the callee rules.

	mov eax, DWORD PTR [ebp+8]
	
What should we need to do if we want to pass some parameters to the subroutine? Push them onto the stack before the call. Since **the stack grows down**, the first parameter should be stored at the lowest address, and the addresses of next ones will be higher.

The cell depicted in the stack are 32-bit wide memory locations. So to speak, each cell in the stack takes 4 bytes. At EBP+4, which is at an offset of 4 bytes from the base pointer, the return address for the call instruction lies in it. If you ascend 4 more bytes, EBP+8, now here are the storages for parameters. EBP+8 is for the first parameter, 'a', and EBP+12 is for the second parameter, 'b'. The mov instruction was trying to copy the value of the first parameter to the EAX.

We should take the second parameter and perform a subtraction with only one instruction. Let's directly subtract it from EAX.

	sub eax, DWORD PTR [ebp+12]

## 3. pig()
	int pig(int a){ return a*3; }
This seems to be quite easy if we apply what we have learned on the previous subroutine solutions...

	push ebp
	mov ebp, esp
	mov eax, DWORD PTR [ebp+8]
	lea ___________________
	pop ebp
	ret
	
The assembler codes is trying to say that this subroutine copies the first parameter to the EAX, and does something while following the callee rules.

Okay, we know the answer would multiply EAX by three. However, the problem gives us to solve it with **lea**, not mul. How about this answer?

	lea eax, [eax*2 + eax]

This type of addressing is called **Scaled Addressing Mode**, which can dynamically scale the value in the index register. It uses bit shifting so scaling of power of 2 (2, 4, or 8) is allowed. That's why the answer instruction is multiplying **'2'** to EAX, and adding the EAX value once again to finally make it EAX*3.

Although the scaled addressing is not special just for lea actually, (for example, mov can perform the similar thing such as *mov edx, \[esi+4\*ebx\]*) it is usually used for lea tricks, avoiding additional multiply instructions. Therefore it is good to remember the solution.

## 4. sheep()
	int sheep(int c){
		if(c < 0)
			return 1;
		else
			return 0;
	}
Let's move on to the fourth function. It wants to return 1 for the negative parameter, and 0 for the 0 or positive ones.

	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	________________
	pop ebp
	ret
	
Only one line for the answer! You might be expected to take some jconditions for the parameter and 0, and jump to the labels. However, to use this method it would need at least 2 lines, for the jcondition and for the jump. We may think another approach...

Gazing at numbers, negative and non-negative, 1 and 0, you might recall that negative has the uppermost bit 1 and non-negative 0. If you manage to bring this information, the problem suddenly would become a piece of cake.

	shr eax, 31
	
Let's shift EAX right by 31 to isolate the sign bit!

## 5. duck()
	int duck(int a){
		if(sheep(a))
			return -a;
		else
			return a;
	}

The last function duck() is both the callee of main(), and the caller of sheep().

		push ebp
		mov ebp, esp
		push ebx
		mov ebx, [ebp+8]
		________________
		call sheep
		mov edx, ebx
		________________
		je L6
		neg edx
	L6:
		mov eax, edx
		add esp, 4
		pop ebx
		pop ebp
		ret
		
Look at this subroutine step by step.

		push ebp
		mov ebp, esp
		push ebx
		mov ebx, [ebp+8]
		________________
		call sheep
		
While following the callee rules, it pushes EBX, and moves the parameter value to the EBX. If we want to pass it to sheep(), we should push it onto the stack before calling sheep(). If do so, it would be the parameter that is up the return address.

		push ebx
		
Next, let's see what happens after calling sheep().

		mov edx, ebx
		________________
		je L6
		neg edx
	L6:
		mov eax, edx
		add esp, 4
		pop ebx
		pop ebp
		ret
		
It says if the blank condition is satisfied, it skips two's complement negation of EDX, move EDX value to EAX, and returns EAX value as the final. What value should be compared? Since the callee sheep returns the value into EAX, the answer should compare EAX value with 0, so that the non-negative parameter can ignore the neg instruction.

		cmp eax, 0
		
