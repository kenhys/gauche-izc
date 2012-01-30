#include <stdio.h>
#include <limits.h>
#include <cutter.h>
#include <glib.h>

#include "iz.h"

CUT_EXPORT void cut_startup(void)
{
#if DEBUG
    g_print("cut_startup\n");
#endif
    cut_message("cut_startup");
}
CUT_EXPORT void cut_shutdown(void)
{
#if DEBUG
    g_print("cut_shutdown\n");
#endif
    cut_message("cut_shutdown");
}

CUT_EXPORT void cut_setup(void)
{
#if DEBUG
    g_print("cut_setup\n");
#endif
    cut_message("cut_setup");
    cs_init();
}
CUT_EXPORT void cut_teardown(void)
{
#if DEBUG
    g_print("cut_teardown\n");
#endif
    cut_message("cut_teardown");
    cs_end();
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


