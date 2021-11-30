extern PROCEDURAL
extern OBJECTORIENTED
extern FUNCTIONAL

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

    ; В rdi адрес прямоугольника
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

    ; В rdi адрес прямоугольника
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

    ; В rdi адрес прямоугольника
    mov eax, [rdi+8]
    mov edx, 0
    mov ecx, 14
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
;     int mid = (low + high) / 2;
;     if (YearsDivideLetters(item) == YearsDivideLetters(c + programminglanguageSize * mid))
;     {
;         return mid + 1;
;     }
;     if (YearsDivideLetters(item) < YearsDivideLetters(c + programminglanguageSize * mid))
;     {
;         return BinarySearch(c, item, mid + 1, high);
;     }
;     return BinarySearch(c, item, low, mid - 1);
; }

; global BinarySearch
; BinarySearch:
; section .text
; push rbp
; mov rbp, rsp

;     ; В rdi адрес прямоугольника
;     mov eax, [rdi+8]
;     mov edx, 0
;     mov ecx, 14
;     div ecx
;     cvtsi2sd    xmm0, eax

; leave
; ret

; double YearsDivideLetters(void *s)
; {
;     int k = *((int *)s);
;     if (k == FUNCTIONAL)
;     {
;         return YearsDivideLettersFunctional(s + intSize);
;     }
;     else if (k == OBJECTORIENTED)
;     {
;         return YearsDivideLettersObjectOriented(s + intSize);
;     }
;     else if (k == PROCEDURAL)
;     {
;         return YearsDivideLettersProcedural(s + intSize);
;     }
;     return -1;
; }

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