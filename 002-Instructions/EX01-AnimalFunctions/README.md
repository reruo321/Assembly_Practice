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
