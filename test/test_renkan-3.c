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

#define ELEMENTS 5

CUT_EXPORT void test_renkan_3(void)
{
    cs_init();
    CSint **vint = cs_createCSintArray(ELEMENTS, 1, 5);

    /* vint[0] -> A  */
    /* vint[1] -> B  */
    /* vint[2] -> C  */
    /* vint[3] -> D  */
    /* vint[4] -> E  */
    cut_assert_not_null(vint[0]);
    cut_assert_not_null(vint[1]);
    cut_assert_not_null(vint[2]);
    cut_assert_not_null(vint[3]);
    cut_assert_not_null(vint[4]);

    /* A != B != C != D != E */
    IZBOOL ret = cs_AllNeq(vint, ELEMENTS);

    /* B = A + C */
    cs_Eq(vint[1], cs_Add(vint[0], vint[2]));
    /* D = C + E */
    cs_Eq(vint[3], cs_Add(vint[2], vint[4]));
    
    /* cs_findAll(vint, ELEMENTS, cs_findFreeVar, found); */
    cs_search(vint, ELEMENTS, cs_findFreeVarNbElements);
    
    /* A:1 B:4 C:3 D:5 E:2 */
    cut_assert_equal_int(1, cs_getValue(vint[0]));
    cut_assert_equal_int(4, cs_getValue(vint[1]));
    cut_assert_equal_int(3, cs_getValue(vint[2]));
    cut_assert_equal_int(5, cs_getValue(vint[3]));
    cut_assert_equal_int(2, cs_getValue(vint[4]));
}


