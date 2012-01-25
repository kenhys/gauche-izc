

#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

CUT_EXPORT void test_init(void)
{
    cs_init();
    cs_getErr();
}

CUT_EXPORT void test_cs_getMin(void)
{
    cs_init();
    CSint *vint = NULL;

    vint = CSINT(0);
    cut_assert_equal_int(0, cs_getMin(vint));

    vint = CSINT(INT_MIN);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint));

    vint = CSINT(INT_MAX);
    cut_assert_equal_int(INT_MAX, cs_getMin(vint));

    /* overflow */
    vint = CSINT(INT_MIN-1);
    cut_assert_equal_int(INT_MAX, cs_getMin(vint));

    /* overflow */
    vint = CSINT(INT_MAX+1);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint));

}

CUT_EXPORT void test_cs_getMax(void)
{
    cs_init();
    CSint *vint = NULL;

    vint = CSINT(0);
    cut_assert_equal_int(0, cs_getMax(vint));

    vint = CSINT(INT_MIN);
    cut_assert_equal_int(INT_MIN, cs_getMax(vint));

    vint = CSINT(INT_MAX);
    cut_assert_equal_int(INT_MAX, cs_getMax(vint));

    /* overflow */
    vint = CSINT(INT_MIN-1);
    cut_assert_equal_int(INT_MAX, cs_getMax(vint));

    /* overflow */
    vint = CSINT(INT_MAX+1);
    cut_assert_equal_int(INT_MIN, cs_getMax(vint));
}

