#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

void found(CSint **allvars, int nbVars)
{
    static NbSolutions = 0;
    printf("Solution %d\n", ++NbSolutions);
    cs_printf("%A\n", allvars, nbVars);
}

#define ELEMENTS 3

CUT_EXPORT void test_renkan_2(void)
{
    cs_init();
    CSint **vint = cs_createCSintArray(ELEMENTS, 1, 3);

    /* vint[0] -> A  */
    /* vint[1] -> B  */
    /* vint[2] -> C  */
    cut_assert_not_null(vint[0]);
    cut_assert_not_null(vint[1]);
    cut_assert_not_null(vint[2]);

    /* A != B != C */
    IZBOOL ret = cs_AllNeq(vint, ELEMENTS);

    /* B = A + C */
    cs_Eq(vint[1], cs_Add(vint[0], vint[2]));
    
    /*cs_findAll(vint, 3, cs_findFreeVar, found);*/
    cs_search(vint, ELEMENTS, cs_findFreeVarNbElements);

    /* A:1 B:3 C:2 */
    cut_assert_equal_int(1, cs_getValue(vint[0]));
    cut_assert_equal_int(3, cs_getValue(vint[1]));
    cut_assert_equal_int(2, cs_getValue(vint[2]));
}


