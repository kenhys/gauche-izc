#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

CUT_EXPORT void test_cs_Add(void)
{
    cs_init();
    CSint *vint, *vint2, *vint3;

    vint = CSINT(0);
    vint2 = CSINT(0);
    vint3 = cs_Add(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(0, cs_getValue(vint3));

    vint = CSINT(0);
    vint2 = CSINT(INT_MAX);
    vint3 = cs_Add(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(INT_MAX, cs_getMin(vint3));
    cut_assert_equal_int(INT_MAX, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(INT_MAX, cs_getValue(vint3));

    vint = CSINT(INT_MIN);
    vint2 = CSINT(0);
    vint3 = cs_Add(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint3));
    cut_assert_equal_int(INT_MIN, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(INT_MIN, cs_getValue(vint3));

    vint = CSINT(INT_MIN);
    vint2 = CSINT(INT_MAX);
    vint3 = cs_Add(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(INT_MIN+INT_MAX, cs_getMin(vint3));
    cut_assert_equal_int(INT_MIN+INT_MAX, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(-1, cs_getValue(vint3));

    vint = CSINT(1);
    vint2 = CSINT(2);
    vint3 = cs_Add(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(1+2, cs_getMin(vint3));
    cut_assert_equal_int(1+2, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(3, cs_getValue(vint3));

    vint = cs_createCSint(0, 9);
    vint2 = CSINT(1);
    vint3 = cs_Add(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(1, cs_getMin(vint3));
    cut_assert_equal_int(10, cs_getMax(vint3));
    cut_assert_equal_int(10, cs_getNbElements(vint3));
    /* error */
    cut_assert_equal_int(1, cs_getValue(vint3));
    cut_assert_equal_int(CS_ERR_GETVALUE, cs_getErr());

    
}

CUT_EXPORT void test_cs_Sub(void)
{
    cs_init();
    CSint *vint, *vint2, *vint3;

    vint = CSINT(0);
    vint2 = CSINT(0);
    vint3 = cs_Sub(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(0, cs_getValue(vint3));

    vint = CSINT(0);
    vint2 = CSINT(INT_MAX);
    vint3 = cs_Sub(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(-INT_MAX, cs_getMin(vint3));
    cut_assert_equal_int(-INT_MAX, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(-INT_MAX, cs_getValue(vint3));

    vint = CSINT(INT_MIN);
    vint2 = CSINT(0);
    vint3 = cs_Sub(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint3));
    cut_assert_equal_int(INT_MIN, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(INT_MIN, cs_getValue(vint3));

    vint = CSINT(INT_MIN);
    vint2 = CSINT(INT_MAX);
    vint3 = cs_Sub(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(INT_MIN-INT_MAX, cs_getMin(vint3));
    cut_assert_equal_int(INT_MIN-INT_MAX, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(INT_MIN-INT_MAX, cs_getValue(vint3));

    vint = CSINT(1);
    vint2 = CSINT(2);
    vint3 = cs_Sub(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(1-2, cs_getMin(vint3));
    cut_assert_equal_int(1-2, cs_getMax(vint3));
    cut_assert_equal_int(1, cs_getNbElements(vint3));
    cut_assert_equal_int(1-2, cs_getValue(vint3));

    vint = cs_createCSint(0, 9);
    vint2 = CSINT(1);
    vint3 = cs_Sub(vint, vint2);
    cut_assert_not_null(vint);
    cut_assert_not_null(vint2);
    cut_assert_not_null(vint3);
    cut_assert_equal_int(-1, cs_getMin(vint3));
    cut_assert_equal_int(8, cs_getMax(vint3));
    cut_assert_equal_int(10, cs_getNbElements(vint3));
    /* error */
    cut_assert_equal_int(-1, cs_getValue(vint3));
    cut_assert_equal_int(CS_ERR_GETVALUE, cs_getErr());
 
}

CUT_EXPORT void test_cs_get_max(void)
{
    cs_init();
    cs_getErr();
}


