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
