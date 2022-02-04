# 001. Setting
I would do my assembly projects on Visual Studio 2019.
## Project Creation
I referred to [this tutorial](https://programminghaven.home.blog/2020/02/16/setup-an-assembly-project-on-visual-studio-2019/).

1. Create a new C++ project.
2. Right click your project, and select Build Dependencies (빌드 종속성) > Build Customizations... (사용자 지정 빌드).
3. Choose **masm**.
4. Add your .asm file into the project.

## Disassembly
To enable Disassembly window, go to Tools > Options > Debugging, and check Enable address-level debugging. While live or dump debugging, you can open Disassembly by selecting Windows > Disassembly (Ctrl+K), or right-clicking on your source codes to select "Go To Disassemly".
