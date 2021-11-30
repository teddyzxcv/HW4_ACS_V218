extern PROCEDURAL
extern OBJECTORIENTED
extern FUNCTIONAL
extern programminglanguageSize
extern memcpy

global YearsDivideLetters
YearsDivideLetters:
section .text
push rbp
mov rbp, rsp

    ; В rdi адрес фигуры
    mov eax, [rdi]
    cmp eax, [FUNCTIONAL]
    je .functionalDivide
    cmp eax, [OBJECTORIENTED]
    je .objectDivide
    cmp eax, [PROCEDURAL]
    je .procedurallDivide
    xor eax, eax
    cvtsi2sd    xmm0, eax
    jmp     .return
.functionalDivide:
    add     rdi, 4
    call    YearsDivideLettersFunctional
    jmp     .return
.objectDivide:
    add     rdi, 4
    call    YearsDivideLettersObjectOriented
    jmp     .return
.procedurallDivide:
    add     rdi, 4
    call    YearsDivideLettersProcedural
.return:
leave
ret
;
;;double YearsDivideLettersFunctional(void *func) {
;;    int years = *((int *) (func + doubleSize));
;;    return (double) years / (double) 10;
;;}


global YearsDivideLettersFunctional
YearsDivideLettersFunctional:
section .text
push rbp
mov rbp, rsp

    mov eax, [rdi+8]
    mov edx, 0
    mov ecx, 10
    div ecx
    cvtsi2sd    xmm0, eax

leave
ret

global YearsDivideLettersObjectOriented
YearsDivideLettersObjectOriented:
section .text
push rbp
mov rbp, rsp

    mov eax, [rdi+8]
    mov edx, 0
    mov ecx, 14
    div ecx
    cvtsi2sd    xmm0, eax

leave
ret

global YearsDivideLettersProcedural
YearsDivideLettersProcedural:
section .text
push rbp
mov rbp, rsp

    mov eax, [rdi+8]
    mov edx, 0
    mov ecx, 10
    div ecx
    cvtsi2sd    xmm0, eax

leave
ret

; int BinarySearch(void *c, void *item, int low, int high)
; {
;     if (high <= low)
;     {
;         return (YearsDivideLetters(item) < YearsDivideLetters(c + low * programminglanguageSize)) ? (low + 1) : low;
;     }
;second_condition:
;     int mid = (low + high) / 2;
    ; if (YearsDivideLetters(item) == YearsDivideLetters(c + programminglanguageSize * mid))
    ; {
    ;     return mid + 1;
    ; }
;third_condition:
    ; if (YearsDivideLetters(item) < YearsDivideLetters(c + programminglanguageSize * mid))
    ; {
    ;     return BinarySearch(c, item, mid + 1, high);
    ; }
    ; return BinarySearch(c, item, low, mid - 1);
; }

global BinarySearch
BinarySearch:
section .text
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 56
        mov     qword [rbp-40], rdi
        mov     qword [rbp-48], rsi
        mov     dword [rbp-52], edx
        mov     dword [rbp-56], ecx
        mov     eax, dword [rbp-56]
        cmp     eax, dword [rbp-52]
        jg      .second_Condition
        mov     rax, qword [rbp-48]
        mov     rdi, rax
        call    YearsDivideLetters
        mov     ebx, eax
        mov     eax, [programminglanguageSize]
        imul    eax, dword [rbp-52]
        movsx   rdx, eax
        mov     rax, qword [rbp-40]
        add     rax, rdx
        mov     rdi, rax
        call    YearsDivideLetters
        cmp     ebx, eax
        jge     .return_low
        mov     eax, dword [rbp-52]
        add     eax, 1
        jmp     .return
.return_low:
        mov     eax, dword [rbp-52]
        jmp     .return
.second_Condition:
        mov     edx, dword [rbp-52]
        mov     eax, dword [rbp-56]
        add     eax, edx
        mov     edx, eax
        shr     edx, 31
        add     eax, edx
        mov edx, 0
        mov ecx, 2
        div ecx
        mov     dword [rbp-20], eax
        mov     rax, qword [rbp-48]
        mov     rdi, rax
        call    YearsDivideLetters
        mov     ebx, eax
        mov     eax, dword [programminglanguageSize]
        imul    eax, dword [rbp-20]
        movsx   rdx, eax
        mov     rax, qword [rbp-40]
        add     rax, rdx
        mov     rdi, rax
        call    YearsDivideLetters
        cmp     ebx, eax
        jne     .third_Condition
        mov     eax, dword [rbp-20]
        add     eax, 1
        jmp     .return
.third_Condition:
        mov     rax, qword [rbp-48]
        mov     rdi, rax
        call    YearsDivideLetters
        mov     ebx, eax
        mov     eax, dword [programminglanguageSize]
        imul    eax, dword [rbp-20]
        movsx   rdx, eax
        mov     rax, qword [rbp-40]
        add     rax, rdx
        mov     rdi, rax
        call    YearsDivideLetters
        cmp     ebx, eax
        jge     .return_low_mid_1
        mov     eax, dword [rbp-20]
        lea     edi, [rax+1]
        mov     edx, dword [rbp-56]
        mov     rsi, qword [rbp-48]
        mov     rax, qword [rbp-40]
        mov     ecx, edx
        mov     edx, edi
        mov     rdi, rax
        call    BinarySearch
        jmp     .return
.return_low_mid_1:
        mov     eax, dword [rbp-20]
        lea     ecx, [rax-1]
        mov     edx, dword [rbp-52]
        mov     rsi, qword [rbp-48]
        mov     rax, qword [rbp-40]
        mov     rdi, rax
        call    BinarySearch
.return:
        mov     rbx, qword [rbp-8]
        leave
        ret

global BinaryInsertion
BinaryInsertion:
section .text
        push    rbp
        mov     rbp, rsp
        sub     rsp, 64
        mov     qword [rbp-56], rdi
        mov     dword [rbp-60], esi
        lea     rax, [rbp-48]
        mov     qword [rbp-16], rax
        mov     dword [rbp-4], 1
        jmp     .for_end
.for_start:
        mov     eax, dword [rbp-4]
        sub     eax, 1
        mov     dword [rbp-8], eax
        mov     eax, [programminglanguageSize]
        movsx   rdx, eax
        mov     eax, [programminglanguageSize]
        imul    eax, dword [rbp-4]
        movsx   rcx, eax
        mov     rax, qword [rbp-56]
        add     rcx, rax
        lea     rax, [rbp-48]
        mov     rsi, rcx
        mov     rdi, rax
        call    memcpy
        mov     edx, dword [rbp-8]
        lea     rsi, [rbp-48]
        mov     rax, qword [rbp-56]
        mov     ecx, edx
        mov     edx, 0
        mov     rdi, rax
        call    BinarySearch
        mov     dword [rbp-20], eax
        mov     eax, dword [rbp-8]
        cmp     eax, dword [rbp-20]
        jge     .mainLoop
        mov     eax, [programminglanguageSize]
        movsx   rdx, eax
        mov     eax, dword [rbp-8]
        lea     ecx, [rax+1]
        mov     eax, [programminglanguageSize]
        imul    eax, ecx
        movsx   rcx, eax
        mov     rax, qword [rbp-56]
        add     rcx, rax
        lea     rax, [rbp-48]
        mov     rsi, rax
        mov     rdi, rcx
        call    memcpy
        add     dword [rbp-4], 1
        jmp     .for_end
.mainLoop:
        mov     eax, [programminglanguageSize]
        cdqe
        mov     edx, [programminglanguageSize]
        imul    edx, dword [rbp-8]
        movsx   rcx, edx
        mov     rdx, qword [rbp-56]
        lea     rsi, [rcx+rdx]
        mov     edx, dword [rbp-8]
        lea     ecx, [rdx+1]
        mov     edx, [programminglanguageSize]
        imul    edx, ecx
        movsx   rcx, edx
        mov     rdx, qword [rbp-56]
        add     rcx, rdx
        mov     rdx, rax
        mov     rdi, rcx
        call    memcpy
        sub     dword [rbp-8], 1
        mov     eax, dword [rbp-8]
        cmp     eax, dword [rbp-20]
        jge     .mainLoop
        mov     eax, [programminglanguageSize]
        movsx   rdx, eax
        mov     eax, dword [rbp-8]
        lea     ecx, [rax+1]
        mov     eax, [programminglanguageSize]
        imul    eax, ecx
        movsx   rcx, eax
        mov     rax, qword [rbp-56]
        add     rcx, rax
        lea     rax, [rbp-48]
        mov     rsi, rax
        mov     rdi, rcx
        call    memcpy
        add     dword [rbp-4], 1
        jmp     .for_end
.for_end:
        mov     eax, dword [rbp-4]
        cmp     eax, dword [rbp-60]
        jl      .for_start
        jmp     .return
.return:
        leave
        ret