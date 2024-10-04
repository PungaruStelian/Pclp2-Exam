; DO NOT MODIFY THIS FILE
section .text

global find
global check_string
global catch_me

extern printf
extern strlen
extern gets
extern exit

find:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; a
    mov edx, [ebp + 12] ; b
    or edx, 0xBEEF  
    xor eax, edx
    sub eax, 0xDEAD

    leave
    ret
    
check_string:
    push ebp
    mov ebp, esp

    ; preserve ebx forced by C calling convention
    push ebx

    mov esi, [ebp + 8]   ; s
    cmp byte [esi], 'a' ; buff[0]='a'
    jne invalid

    push esi
    call strlen
    add esp, 4
    dec eax
    
    mov esi, [ebp + 8]   ; s
    cmp byte [esi + eax], 'S' ; buff[n-1]='S'
    jne invalid

    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx 


counter:
    cmp byte [esi + ecx], 0
    je check ; la finalul sirului
    
    mov al, byte [esi + ecx]
    cmp al, 'A'
    jb next
    cmp al, 'Z'
    ja lower_check
    
    inc edx ; contor pentru litere mari
    jmp next


lower_check:
    cmp al, 'a'
    jb next
    cmp al, 'z'
    ja next
    inc ebx ; contor pentru litere mici

next:
    inc ecx
    jmp counter
    
check:
    cmp edx, 2 ; cel putin 2 litere mici
    jb invalid
    cmp ebx, 3 ; cel putin 3 litere mari
    jb invalid
    jmp valid
  
invalid:
    mov eax, -1
    jmp end

valid:
    mov eax, 0

end:
    ; restore ebx
    pop ebx

    leave
    ret

