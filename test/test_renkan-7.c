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

#define ELEMENTS 13

CUT_EXPORT void test_renkan_7(void)
{
    cs_init();
    CSint **vint = cs_createCSintArray(ELEMENTS, 1, 13);

    /* vint[0] -> A  */
    /* vint[1] -> B  */
    /* vint[2] -> C  */
    /* vint[3] -> D  */
    /* vint[4] -> E  */
    /* vint[5] -> F  */
    /* vint[6] -> G  */
    /* vint[7] -> H  */
    /* vint[8] -> I  */
    /* vint[9] -> J  */
    /* vint[10] -> K  */
    /* vint[11] -> L  */
    /* vint[12] -> M  */
    for (int i = 0; i < ELEMENTS; i++) {
        cut_assert_not_null(vint[i]);
    }

    /* A != B != C != D != E != F != G != H != I != J != K != L != M */
    IZBOOL ret = cs_AllNeq(vint, ELEMENTS);

    /* B = A + C */
    cs_Eq(vint[1], cs_Add(vint[0], vint[2]));
    cs_Eq(vint[3], cs_Add(vint[2], vint[4]));
    cs_Eq(vint[5], cs_Add(vint[4], vint[6]));
    cs_Eq(vint[7], cs_Add(vint[6], vint[8]));
    cs_Eq(vint[9], cs_Add(vint[8], vint[10]));
    cs_Eq(vint[11], cs_Add(vint[10], vint[12]));
    
    /* cs_findAll(vint, ELEMENTS, cs_findFreeVar, found);*/
    cs_search(vint, ELEMENTS, cs_findFreeVarNbElements);

    /* A:1 B:3 C:2 */
    int answer[] = {1,3,2,10,8,12,4,9,5,11,6,13,7};
    for (int i = 0; i < ELEMENTS; i++) {
        cut_assert_equal_int(answer[i], cs_getValue(vint[i]));
    }
}

