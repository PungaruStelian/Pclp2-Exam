%include "printf32.asm"

section .data
    M: dd 69
    k: dd 32 
    arr dd 1, 32, 9, 11, 69  
    len equ ($-arr)/4
    

section .bss
    res_arr resd 32

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Find out if M has the form 2*k + 5 and
    ; output the correponding messages on a separate line

    ;PRINTF32 `%d\n\x0`, ecx
    mov eax, [M]
    mov ebx, [k]
    shl ebx, 1
    add ebx, 5
    cmp ebx, eax
    jz merge
    PRINTF32 `No luck!\n\x0`
    jmp skip_a
merge:
    PRINTF32 `Format Succesful!\n\x0`
skip_a:

    ; TODO b: Given arr find out which of its values has the form 2*i + 5, 
    ;         where i is the current index in arr.
    ;         Print the index i for these values and store them at 
    ;         succesive indexes j of res_arr. 

    xor ecx, ecx
    dec ecx
    xor edx, edx
loop_b:
    mov eax, [arr + 4 * ecx]
    mov ebx, ecx
    shl ebx, 1
    add ebx, 5
    cmp ebx, eax
    jnz skip_b
    mov [res_arr + 4 * edx], eax
    inc edx
skip_b:
    inc ecx
    cmp ecx, len
    jnz loop_b
    mov ecx, edx
    dec ecx
loop_b1:
    mov eax, [res_arr + 4 * ecx]
    sub eax, 5
    shr eax, 1
    PRINTF32 `%d \x0`, eax
    dec ecx
    cmp ecx, 0
    jge loop_b1
    PRINTF32 `\n\x0`

    ; TODO c: Print (only) stored values from the res_arr array 
    ; on single line separated by spaces in order 

    xor ecx, ecx
loop_c:
    mov eax, [res_arr + 4 * ecx]
    PRINTF32 `%d \x0`, eax
    inc ecx
    cmp ecx, edx
    jnz loop_c
    PRINTF32 `\n\x0`

    leave
    ret
