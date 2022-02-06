# 001. Setting
I would do my assembly projects on Visual Studio 2019.
## Project Creation
I referred to [this tutorial](https://programminghaven.home.blog/2020/02/16/setup-an-assembly-project-on-visual-studio-2019/).

1. Create a new C++ project.
2. Right click your project, and select Build Dependencies (빌드 종속성) > Build Customizations... (사용자 지정 빌드).
3. Choose **masm**.
4. Add your .asm file into the project.
5. Right click your .asm file, open Properties, and choose Item Type as "Microsoft Macro Assembler".

## Load Assembly Codes from C
    extern void myfunction();
    
    int main(){
      myfunction();
      return 0;
    }

## Load Assembly Codes from C++
    extern "C" { void myfunction(); }

    int main(){
      myfunction();
      return 0;
    }

If you get an error from C++ compiler while loading assembly codes, (such as LNK2019) check the configurations above again. Also, check your Active Solution Platform to choose x86 or x64. You can find it on the upper side of the Visual Studio 2019.

![001platform](https://user-images.githubusercontent.com/48712088/152682990-88b68176-f08c-436a-8327-73a2dcc1a5e9.png)

## Disassembly
To enable Disassembly window, go to Tools > Options > Debugging, and check Enable address-level debugging. While live or dump debugging, you can open Disassembly by selecting Windows > Disassembly (Ctrl+K), or right-clicking on your source codes to select "Go To Disassemly".
