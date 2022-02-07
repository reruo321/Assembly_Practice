# Example 01 - AnimalFunctions
The example shows simple example functions, which are the answers of [Problem 1 from the Internet](https://www.cs.cmu.edu/afs/cs/academic/class/15213-s03/www/asm_examples.pdf).
You can call these and test some cases using main.cpp I added.

**Warning: The original problem follows AT&T syntax, which has the opposite order for source and destination operands and other differences with that of Intel. You should be careful while interpreting it.**

## 1. goose()
    int goose(){ return -4; }

The first function goose() should return -4. If the assembly code is written correctly, it should be called and return the value onto the C++ main function.

    goose PROC
    push ebp
    mov ebp, esp
    _______________
    pop ebp
    ret
    goose ENDP
    
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
    
If you filled the blank, let's test the output on this simple C++ program.

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

The cell depicted in the stack are 32-bit wide memory locations. So to speak, each cell in the stack takes 4 bytes. At ebp+4, which is at an offset of 4 bytes from the base pointer, the return address for the call instruction lies in it. If you ascend 4 more bytes, ebp+8, now here are the storages for parameters. ebp+8 is for the first parameter, 'a', and ebp+12 is for the second parameter, 'b'. The mov instruction was trying to copy the value of the first parameter to the eax.

We should take the second parameter and perform a subtraction with only one instruction. Let's directly subtract it from eax.

	sub eax, DWORD PTR [ebp+12]

## 3. pig()
