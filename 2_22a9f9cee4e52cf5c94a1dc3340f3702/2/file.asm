extern printf

section .rodata
    fmt db "%d ", 0
    nwln db 10, 0
    newline_fmt: db 0xd, 0xa, 0x0


section .data
    val dd -10
    ; val dd 0
    ; val dd -9
    arr dd -10, 20, 30, -40, -50, 60, 70, 80, -90, -100
    ;arr dd  0, 0, 0, -40, -50, -60, 70, 80, 90, 100
    len equ 10

section .bss
    res resd 10

section .text
global main

print_arr:
    push ebp
    mov ebp, esp

    ;TODO b: Implement function void print_array(int *arr, int n)

    mov esi, 0
loop:
    mov eax, [ebp+8]
    mov ebx, dword [eax+esi*4]
    push ebx
    push fmt
    call printf
    add esp, 8
    inc esi
    cmp esi, dword [ebp+12]
    je end
    jmp loop
end:
    push nwln
    call printf
    add esp, 4

    leave
    ret

sign:
    push ebp
    mov ebp, esp

    ;TODO a: Implement int sign(int val); to return the sign of an integer
    ; function should return 1 if the number is positive, -1 if the number is negative or 0 if the number is 0

    mov ebx, [ebp + 8]
    xor eax, eax
    cmp ebx, 0
    jl putin
    jg mult
    jmp fein

putin:
    mov eax, -1
    jmp fein

mult:
    mov eax, 1

fein:

    leave
    ret

compute_sign:
    push ebp
    mov ebp, esp

    ;TODO c: Implement function void compute_sign(int *arr, int n, int *res)
    ; function will compute the sign for each element of arr and fill the result in the array res
    ; thus res[i] = sign(arr[i])

    mov eax, [ebp + 8] ; arr
    mov ebx, [ebp + 12] ; n
    mov edx, [ebp + 16] ; res

    xor ecx, ecx
loop_c:
    mov esi, [eax + 4 * ecx]
    
    pusha
    push esi
    call sign
    add esp, 4
    mov [res + 4 * ecx], eax
    popa

    inc ecx
    cmp ecx, ebx
    jnz loop_c

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: test sign function
    push dword [val]
    call sign
    add esp, 4

    push eax
    push fmt
    call printf
    add esp, 8
    
    pusha
    push newline_fmt
    call printf
    add esp, 4
    popa

    ; TODO b: print arr elements separated by a space
    push dword len
    push arr
    call print_arr
    add esp, 8

    ; TODO c: compute sign for each element of arr and store the result in res array
    push res
    push dword len
    push arr
    call compute_sign
    add esp, 12

    ; print the result
    push dword len
    push res
    call print_arr
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret


