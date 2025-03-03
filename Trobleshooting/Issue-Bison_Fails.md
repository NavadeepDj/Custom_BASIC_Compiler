# Resolving "C:\\Program: cannot open Files'" Error When Running Bison on Windows

## Issue Description
When attempting to run **Bison** from GnuWin32 on Windows, users may encounter an error.
For ex: When you run bison command after lex for building interpreter or compiler:
```
bison -d syntax.y
```
Users may encounter an error similar to the following:

```
C:\Program: cannot open Files': No such file or directory
C:\Program: cannot open (x86)\GnuWin32\bin\m4.exe': No such file or directory
m4_init()
m4_define([b4_actions],
[b4_case(4, [b4_syncline(18, [["syntax.y"]])
[    { printf("Valid Assignment\n"); ;}]])

b4_case(5, [b4_syncline(19, [["syntax.y"]])
[    { printf("Valid Print Statement\n"); ;}]])

])

m4_define([b4_mergers],
[[]])

m4_define([b4_tokens],
[[[[LET]], 258],
[[[PRINT]], 259],
[[[IDENTIFIER]], 260],
[[[NUMBER]], 261]])

m4_define([b4_symbol_destructors],
[])

m4_define([b4_symbol_printers],
[])
 and so on... until it stops
```

This occurs because Bison tries to access its dependency `m4.exe` in `C:\Program Files (x86)\GnuWin32\bin`, but spaces in the path cause Windows to misinterpret it as separate arguments.

## Root Cause
The issue arises because Windows command-line tools sometimes fail to handle paths with spaces correctly, even when enclosed in quotes. (Like "C:\Program Files (x86)\GnuWin32")
Bison and M4 are affected when installed in a directory such as `C:\Program Files (x86)\GnuWin32`.

## Solution: Move GnuWin32 to a Path Without Spaces
To resolve this issue, move the **GnuWin32** folder to a location without spaces, such as `C:\GnuWin32`. Follow these steps:

### Steps to Fix
1. **Move GnuWin32:**
   - Navigate to `C:\Program Files (x86)`.
   - Copy the `GnuWin32` folder.
   - Paste it in `C:\`, so the new path is `C:\GnuWin32`.
   - ![image](https://github.com/user-attachments/assets/104da982-85a6-4ca1-81c9-151b12666288)


2. **Update Environment Variables:**
   - Open **System Properties** (Press `Win + R`, type `sysdm.cpl`, and press `Enter`).
   - Go to the **Advanced** tab and click **Environment Variables**.
   - Find `Path` under **System Variables** and click **Edit**.
   - Remove the old entry (`C:\Program Files (x86)\GnuWin32\bin`) and add `C:\GnuWin32\bin`.
   - Click **OK** and restart the terminal.

3. **Verify the Fix:**
   - Open a new **Command Prompt** or **PowerShell** window.
   - Run:
     ```sh
     bison --version
     ```
   - It should now execute without errors.


## Conclusion
The error occurs due to spaces in the installation path. The recommended solution is to move **GnuWin32** to a location without spaces, such as `C:\GnuWin32`, and update environment variables accordingly. Alternative workarounds include using short paths or WSL.

By applying this fix, Bison should now work correctly on Windows without path-related issues.

