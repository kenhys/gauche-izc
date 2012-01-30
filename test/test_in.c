#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

CUT_EXPORT void cut_startup(void)
{
    cut_message("cut_startup");
}
CUT_EXPORT void cut_shutdown(void)
{
    cut_message("cut_shutdown");
}

CUT_EXPORT void cut_setup(void)
{
    cut_message("cut_setup");
    cs_init();
}
CUT_EXPORT void cut_teardown(void)
{
    cut_message("cut_teardown");
    cs_end();
}
CUT_EXPORT void test_cs_Le(void)
{
    cut_assert_true(cs_Le(CSINT(0), CSINT(0)));
    cut_assert_true(cs_Le(CSINT(INT_MAX), CSINT(INT_MAX)));
    cut_assert_true(cs_Le(CSINT(INT_MIN), CSINT(INT_MIN)));

    cut_assert_true(cs_Le(CSINT(0), CSINT(1)));
    cut_assert_true(cs_Le(CSINT(-1), CSINT(0)));
    cut_assert_true(cs_Le(CSINT(INT_MIN), CSINT(-1)));
    cut_assert_true(cs_Le(CSINT(1), CSINT(INT_MAX)));
    cut_assert_true(cs_Le(CSINT(INT_MIN), CSINT(INT_MAX)));

    /**/
    CSint* vint = cs_createCSint(1, 10);
    cut_assert_true(cs_Le(vint, CSINT(INT_MAX)));
}

CUT_EXPORT void test_cs_Ge(void)
{
    cs_init();

    cut_assert_true(cs_Ge(CSINT(0), CSINT(0)));
    cut_assert_true(cs_Ge(CSINT(INT_MAX), CSINT(INT_MAX)));
    cut_assert_true(cs_Ge(CSINT(INT_MIN), CSINT(INT_MIN)));

    cut_assert_true(cs_Ge(CSINT(1), CSINT(0)));
    cut_assert_true(cs_Ge(CSINT(0), CSINT(-1)));
    cut_assert_true(cs_Ge(CSINT(-1), CSINT(INT_MIN)));
    cut_assert_true(cs_Ge(CSINT(INT_MAX), CSINT(1)));
    cut_assert_true(cs_Ge(CSINT(INT_MAX), CSINT(INT_MIN)));
}

CUT_EXPORT void test_cs_Lt(void)
{
    cs_init();

    cut_assert_true(cs_Lt(CSINT(0), CSINT(INT_MAX)));
    cut_assert_true(cs_Lt(CSINT(INT_MIN), CSINT(0)));
    cut_assert_true(cs_Lt(CSINT(INT_MIN), CSINT(INT_MAX)));

    cut_assert_true(cs_Lt(CSINT(0), CSINT(1)));
    cut_assert_true(cs_Lt(CSINT(-1), CSINT(0)));
    cut_assert_true(cs_Lt(CSINT(INT_MIN), CSINT(-1)));
    cut_assert_true(cs_Lt(CSINT(1), CSINT(INT_MAX)));
}

CUT_EXPORT void test_cs_Gt(void)
{
    cs_init();

    cut_assert_true(cs_Gt(CSINT(INT_MAX), CSINT(0)));
    cut_assert_true(cs_Gt(CSINT(0), CSINT(INT_MIN)));
    cut_assert_true(cs_Gt(CSINT(INT_MAX), CSINT(INT_MIN)));

    cut_assert_true(cs_Gt(CSINT(1), CSINT(0)));
    cut_assert_true(cs_Gt(CSINT(0), CSINT(-1)));
    cut_assert_true(cs_Gt(CSINT(-1), CSINT(INT_MIN)));
    cut_assert_true(cs_Gt(CSINT(INT_MAX), CSINT(1)));
}

CUT_EXPORT void test_cs_Eq(void)
{
    cs_init();
}

CUT_EXPORT void test_cs_Neq(void)
{
    cs_init();
}

#define SIZE0TO9 10

CUT_EXPORT void test_cs_InArray(void)
{
    cs_init();

    int array0to9[] = {0,1,2,3,4,5,6,7,8,9};

    /* instantiated to i */
    for (int i=0; i < 10; i++) {
        CSint *vint = CSINT(i);
        cut_assert_true(cs_InArray(vint, array0to9, SIZE0TO9));
        cut_assert_equal_int(i, cs_getMin(vint));
        cut_assert_equal_int(i, cs_getMax(vint));
    }

    /* instantiated to i */
    for (int i=0; i < 10; i++) {
        CSint *vint = cs_createCSint(0, 10);
        cut_assert_true(cs_InArray(vint, &array0to9[i], 1));
        cut_assert_equal_int(i, cs_getMin(vint));
        cut_assert_equal_int(i, cs_getMax(vint));
    }
    
    cut_assert_true(cs_InArray(cs_createCSint(-1, 0), array0to9, SIZE0TO9));
    cut_assert_true(cs_InArray(cs_createCSint(9, 10), array0to9, SIZE0TO9));

    cut_assert_false(cs_InArray(CSINT(-1), array0to9, SIZE0TO9));
    cut_assert_false(cs_InArray(CSINT(INT_MIN), array0to9, SIZE0TO9));
    cut_assert_false(cs_InArray(CSINT(INT_MAX), array0to9, SIZE0TO9));
    cut_assert_false(cs_InArray(CSINT(10), array0to9, SIZE0TO9));
}

CUT_EXPORT void test_cs_NotInArray(void)
{
    cs_init();
}

CUT_EXPORT void test_cs_InInterval(void)
{
    cs_init();
}

CUT_EXPORT void test_cs_NotInInterval(void)
{
    cs_init();
}


