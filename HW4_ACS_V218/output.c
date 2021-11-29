//------------------------------------------------------------------------------
// output.c - единица компиляции, вбирающая в себя все функции вывода данных
//------------------------------------------------------------------------------

#include <stdio.h>

#include "extdata.h"

//------------------------------------------------------------------------------
// Вычисление частное от деления года создания на количество символов в названии в функциональный язык
double YearsDivideLettersFunctional(void *func);


// Вывод параметров функциональный язык в файл
void OutFunctional(void *func, FILE *f) {
    int types = *((int *) (func + doubleSize + intSize));
    int isLazySupport = *((int *) (func + doubleSize + intSize * 2));
    fprintf(f, "It is a functional language: TIOBI = %f. "
               "Year of creation = %d . Years divide count letters in the name = %f. Type = %s. Is lazy calculation support = %s\n",
            *((double *) func), *((int *) (func + doubleSize)),
            YearsDivideLettersFunctional(func), types == 1 ? "Dynamic" : "Static", isLazySupport ? "Yes" : "No");
}

//------------------------------------------------------------------------------
// Вычисление частное от деления года создания на количество символов в названии в объект-ориентированный язык
double YearsDivideLettersObjectOriented(void *ob);

// Вывод параметров объект-ориентированный язык в файл
void OutObjectOriented(void *ob, FILE *f) {
    int inher = *((int *) (ob + doubleSize + intSize));
    fprintf(f, "It is a object oriented language: TIOBI = %f. "
               "Year of creation = %d . Years divide count letters in the name = %f. Inheritance = %s\n",
            *((double *) ob), *((int *) (ob + doubleSize)),
            YearsDivideLettersObjectOriented(ob), inher == 1 ? "Single" : (inher == 2 ? "Multiple" : "Interface"));
}

//------------------------------------------------------------------------------
// Вычисление частное от деления года создания на количество символов в названии в процедурный язык
double YearsDivideLettersProcedural(void *p);

// Вывод параметров процедурный язык в файл
void OutProcedural(void *p, FILE *f) {
    int isAbstract = *((int *) (p + doubleSize + intSize));
    fprintf(f, "It is a procedural language: TIOBI = %f. "
               "Year of creation = %d . Years divide count letters in the name = %f. Is abstract type exist = %s\n",
            *((double *) p), *((int *) (p + doubleSize)),
            YearsDivideLettersProcedural(p), isAbstract ? "Yes" : "No");
}

// Вывод параметров текущей фигуры в поток
void OutProgrammingLanguages(void *s, FILE *f) {
    int k = *((int *) s);
    if (k == FUNCTIONAL) {
        OutFunctional(s + intSize, f);
    } else if (k == OBJECTORIENTED) {
        OutObjectOriented(s + intSize, f);
    } else if (k == PROCEDURAL) {
        OutProcedural(s + intSize, f);
    } else {
        fprintf(f, "Incorrect figure!\n");
    }
}

// Вывод содержимого контейнера в файл
void OutContainer(void *c, int len, FILE *f) {
    void *tmp = c;
    fprintf(f, "Container contains %d elements.\n", len);
    for (int i = 0; i < len; i++) {
        fprintf(f, "%d: ", i);
        OutProgrammingLanguages(tmp, f);
        tmp = tmp + programminglanguageSize;
    }
}
