//------------------------------------------------------------------------------
// main.cpp - содержит главную функцию,
// обеспечивающую простое тестирование
//------------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h> // для функций rand() и srand()
#include <time.h>   // для функции time()
#include <string.h>

#include "data.h"

// #include "input.c"
// #include "inrnd.c"
// #include "perimeter.c"
// #include "output.c"
const char testroot[100] = "./../TestInput/", resroot[100] = "./../TestOutput/";

void errMessage1() {
    printf("incorrect command line!\n"
           "  Waited:\n"
           "     command -f infile outfile01 outfile02\n"
           "  Or:\n"
           "     command -n number outfile01 outfile02\n");
}

void errMessage2() {
    printf("incorrect qualifier value!\n"
           "  Waited:\n"
           "     command -f infile outfile01 outfile02\n"
           "  Or:\n"
           "     command -n number outfile01 outfile02\n");
}

//------------------------------------------------------------------------------
int main(int argc, char *argv[]) {
    clock_t start = clock();
    // Массив используемый для хранения данных
    //unsigned int cont[maxSize / intSize];
    //int cont[maxSize / intSize];
    unsigned char cont[maxSize];
    // Количество элементов в массиве
    int len = 0;

    printf("intSize = %d\n", intSize);
    printf("functionalSize = %d\n", functionalSize);
    printf("objectorientedSize = %d\n", objectorientedSize);
    printf("proceduralSize = %d\n", proceduraltSize);
    printf("programminglanguageSize = %d\n", programminglanguageSize);
    printf("maxSize = %d\n", maxSize);
    printf("FUNCTIONAL = %d\n", FUNCTIONAL);
    printf("OBJECTORIENTED = %d\n", OBJECTORIENTED);
    printf("PROCEDURAL = %d\n", PROCEDURAL);
    printf("Size of container = %lu\n", sizeof(cont));

    // Собираем адреса файлов.
    char testPath[200], resPath1[200], resPath2[200];
    strcpy(testPath, testroot);
    strcpy(resPath1, resroot);
    strcpy(resPath2, resroot);
    strcat(testPath, argv[2]);
    strcat(resPath1, argv[3]);
    strcat(resPath2, argv[4]);

    if (argc != 5) {
        errMessage1();
        return 1;
    }

    printf("Start\n");
    //InitContainer(&cont);

    if (!strcmp(argv[1], "-f")) {
        FILE *ifst = fopen(testPath, "r");
        InContainer(cont, &len, ifst);
    } else if (!strcmp(argv[1], "-n")) {
        int size = atoi(argv[2]);
        if ((size < 1) || (size > 10000)) {
            printf("incorrect numer of figures = %d. Set 0 < number <= 10000\n",
                   size);
            return 3;
        }
        // системные часы в качестве инициализатора
        srand((unsigned int) (time(0)));
        // Заполнение контейнера генератором случайных чисел
        InRndContainer(cont, &len, size);
    } else {
        errMessage2();
        return 2;
    }

    // Вывод содержимого контейнера в файл
    fprintf(stdout, "Filled container:\n");
    OutContainer(cont, len, stdout);
    FILE *ofst1 = fopen(resPath1, "w");
    fprintf(ofst1, "Filled container:\n");
    OutContainer(cont, len, ofst1);
    fclose(ofst1);


    clock_t end = clock();
    double calcTime = ((double) (end - start)) / (CLOCKS_PER_SEC + 1.0);
    fprintf(stdout, "Calculaton time = %g\n", calcTime);
//    // The 2nd part of task
//    FILE *ofst2 = fopen(resPath1, "w");
//    double sum = PerimeterSumContainer(cont, len);
//    double calcTime = ((double) (end - start)) / (CLOCKS_PER_SEC + 1.0);
//
//    fprintf(stdout, "Perimeter sum = %g\nCalculaton time = %g\n", sum, calcTime);
//
//    fclose(ofst2);
    //ClearContainer(&c);
    printf("Stop\n");
    return 0;
}
