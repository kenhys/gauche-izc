/* -*- coding: utf-8-unix -*- */

#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

void found(CSint **allvars, int nbVars)
{
    static int NbSolutions = 0;
    printf("Solution %d\n", ++NbSolutions);
    cs_printf("%A\n", allvars, nbVars);
}

#define ELEMENTS 8

CUT_EXPORT void test_send_more_money(void)
{
    cs_init();
    CSint **vint = cs_createCSintArray(ELEMENTS, 0, 9);

    CSint *S = vint[0];
    CSint *E = vint[1];
    CSint *N = vint[2];
    CSint *D = vint[3];
    CSint *M = vint[4];
    CSint *O = vint[5];
    CSint *R = vint[6];
    CSint *Y = vint[7];

    for (int i = 0; i < ELEMENTS; i++) {
        cut_assert_not_null(vint[i]);
    }

    /* S != E != N != D != M != O != R != Y */
    IZBOOL ret = cs_AllNeq(vint, ELEMENTS);

    /* B = A + C */
    CSint *L1 = cs_VScalProd(4, S, E, N, D, 1000, 100, 10, 1);
    CSint *L2 = cs_VScalProd(4, M, O, R, E, 1000, 100, 10, 1);
    CSint *L3 = cs_VScalProd(5, M, O, N, E, Y, 10000, 1000, 100, 10, 1);

    cs_Eq(L3, cs_Add(L1, L2));
    cs_Neq(S, CSINT(0));
    cs_Neq(M, CSINT(0));
    
    /* cs_findAll(vint, ELEMENTS, cs_findFreeVar, found); */
    cs_search(vint, ELEMENTS, cs_findFreeVarNbElements);

    int answer[] = {9,5,6,7,1,0,8,2};
    for (int i = 0; i < ELEMENTS; i++) {
        cut_assert_equal_int(answer[i], cs_getValue(vint[i]));
    }
}

