//------------------------------------------------------------------------------
// input.c - единица компиляции, вбирающая в себя все функции ввода данных
//------------------------------------------------------------------------------

#include <stdio.h>

#include "extdata.h"


//------------------------------------------------------------------------------
// Ввод параметров функцианальный язык из потока
void InFunctional(void *func, FILE *f) {
    fscanf(f, "%lf%d%d%d", (double *) func, (int *) (func + doubleSize), (int *) (func + 3 * intSize),
           (int *) (func + 4 * intSize));
}

//------------------------------------------------------------------------------
// Ввод параметров объектно-ориентированный язык из потока
void InObjectOriented(void *ob, FILE *f) {
    fscanf(f, "%lf%d%d", (double *) ob, (int *) (ob + doubleSize), (int *) (ob + 3 * intSize));
}

//------------------------------------------------------------------------------
// Ввод параметров процедурный язык из потока
void InProcedural(void *p, FILE *f) {
    int isAbstract = 0;
    fscanf(f, "%lf%d%d", (double *) p, (int *) (p + doubleSize), (int *) (p + 3 * intSize));
}

// Ввод параметров обобщенной фигуры из файла
int InProgrammingLanguages(void *s, FILE *f) {
    int k;
    fscanf(f, "%d", &k);
    switch (k) {
        case 1:
            *((int *) s) = FUNCTIONAL;
            InFunctional(s + intSize, f);
            return 1;
        case 2:
            *((int *) s) = OBJECTORIENTED;
            InObjectOriented(s + intSize, f);
            return 1;
        case 3:
            *((int *) s) = PROCEDURAL;
            InProcedural(s + intSize, f);
            return 1;
        default:
            return 0;
    }
}

// Ввод содержимого контейнера из указанного файла
void InContainer(void *c, int *len, FILE *f) {
    void *tmp = c;
    while (!feof(f)) {
        if (InProgrammingLanguages(tmp, f)) {
            tmp = tmp + programminglanguageSize;
            (*len)++;
        }
    }
}
