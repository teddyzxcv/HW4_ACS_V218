//------------------------------------------------------------------------------
// inrnd.c - единица компиляции, вбирающая функции генерации случайных данных
//------------------------------------------------------------------------------

#include <stdlib.h>

#include "extdata.h"

// rnd.c - содержит генератор случайных чисел в диапазоне от 0 до x
int Random(int x) {
    x++;
    return rand() % x;
}

// Случайный ввод параметров прямоугольника
void InRndFunctional(void *func) {
    double x = Random(100);
    *((double *) func) = x;
    int y = Random(2021);
    *((int *) (func + doubleSize)) = y;
    int z = Random(1) + 1;
    *((int *) (func + doubleSize + intSize)) = z;
    int w = Random(1);
    *((int *) (func + doubleSize + 2 * intSize)) = w;
//     printf("    Rectangle %d %d\n", *((int*)func), *((int*)func+1));
}

// Случайный ввод параметров треугольника
void InRndObjectOriented(void *ob) {
    double x = Random(100);
    *((double *) ob) = x;
    int y = Random(2021);
    *((int *) (ob + doubleSize)) = y;
    int z = Random(2) + 1;
    *((int *) (ob + doubleSize + intSize)) = z;
//     printf("    Triangle %d %d %d\n", *((int*)t), *((int*)t+1), *((int*)t+2));
}

// Случайный ввод параметров треугольника
void InRndProcedural(void *p) {
    double x = Random(100);
    *((double *) p) = x;
    int y = Random(2021);
    *((int *) (p + doubleSize)) = y;
    int z = Random(1);
    *((int *) (p + doubleSize + intSize)) = z;
//     printf("    Triangle %d %d %d\n", *((int*)t), *((int*)t+1), *((int*)t+2));
}

// Случайный ввод обобщенной фигуры
int InRndProgrammingLanguages(void *s) {
    int k = Random(2) + 1;
    switch (k) {
        case 1:
            *((int *) s) = FUNCTIONAL;
            InRndFunctional(s + intSize);
//              printf("Shape %d %d %d %d\n",
//                     *((int*)s), *((int*)s+1),
//                     *((int*)s+2), *((int*)s+3));
            return 1;
        case 2:
            *((int *) s) = OBJECTORIENTED;
            InRndObjectOriented(s + intSize);
//              printf("Shape %d %d %d %d\n",
//                     *((int*)s), *((int*)s+1),
//                     *((int*)s+2), *((int*)s+3));
            return 1;
        case 3:
            *((int *) s) = PROCEDURAL;
            InRndProcedural(s + intSize);
            return 1;
        default:
            return 0;
    }
}

// Случайный ввод содержимого контейнера
void InRndContainer(void *c, int *len, int size) {
    void *tmp = c;
    while (*len < size) {
        if (InRndProgrammingLanguages(tmp)) {
            tmp = tmp + programminglanguageSize;
            (*len)++;
        }
    }
}
