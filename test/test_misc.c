#include <stdio.h>
#include <limits.h>
#include <cutter.h>

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

CUT_EXPORT void test_init(void)
{
    cs_init();
    cut_assert_true(TRUE);
}

CUT_EXPORT void test_end(void)
{
    cs_end();
    cut_assert_true(TRUE);
}

CUT_EXPORT void test_cs_getErr(void)
{
    cs_init();
    cut_assert_equal_int(CS_ERR_NONE, cs_getErr());
}

CUT_EXPORT void test_cs_getErr_no_init(void)
{
    cut_assert_equal_int(CS_ERR_NONE, cs_getErr());
}

CUT_EXPORT void test_cs_getNbElemnts(void)
{
    CSint *vint = NULL;
#if 0
    /* invalid */
    cut_assert_equal_int(0, cs_getNbElements(vint)); 
#endif

    vint = CSINT(0);
    cut_assert_equal_int(1, cs_getNbElements(vint));

    vint = cs_createCSint(-100, 100);
    cut_assert_equal_int(201, cs_getNbElements(vint));
}

/**/

CUT_EXPORT void test_cs_createCSint_0_TO_INT_MAX_PLUS1(void)
{
    cs_init();
    CSint *vint = cs_createCSint(0, INT_MAX+1);
    cut_assert_null(vint);
}

CUT_EXPORT void test_cs_createCSint_INT_MIN_MINUS1_TO_0(void)
{
    cs_init();
    CSint *vint = cs_createCSint(INT_MIN-1, 0);
    cut_assert_null(vint);
}

CUT_EXPORT void test_cs_createCSint_INT_MAX_TO_INT_MIN(void)
{
    cs_init();
    CSint *vint = cs_createCSint(INT_MAX, INT_MIN);
    cut_assert_null(vint);
}

CUT_EXPORT void test_cs_createCSint_SWAP(void)
{
    cs_init();
    CSint *vint = cs_createCSint(0, -1);
    cut_assert_null(vint);

    vint = cs_createCSint(1, 0);
    cut_assert_null(vint);

    vint = cs_createCSint(1, -1);
    cut_assert_null(vint);
}

CUT_EXPORT void test_cs_createCSint(void)
{
    cs_init();
    CSint *vint = cs_createCSint(0, 1);
    cut_assert_not_null(vint);

    vint = cs_createCSint(-1, 0);
    cut_assert_not_null(vint);

    vint = cs_createCSint(-1, 1);
    cut_assert_not_null(vint);

    vint = cs_createCSint(INT_MIN, INT_MAX);
    cut_assert_not_null(vint);

    vint = cs_createCSint(0, 0);
    cut_assert_not_null(vint);

    vint = cs_createCSint(INT_MIN, INT_MIN);
    cut_assert_not_null(vint);

    vint = cs_createCSint(INT_MAX, INT_MAX);
    cut_assert_not_null(vint);
}

CUT_EXPORT void test_csint(void)
{
    cs_init();
    CSint *vint = CSINT(0);
    cut_assert_not_null(vint);

    vint = CSINT(-1);
    cut_assert_not_null(vint);

    vint = CSINT(1);
    cut_assert_not_null(vint);

    vint = CSINT(INT_MIN);
    cut_assert_not_null(vint);

    vint = CSINT(INT_MAX);
    cut_assert_not_null(vint);

    /* overflow */
    vint = CSINT(INT_MAX+1);
    cut_assert_not_null(vint);

    vint = CSINT(INT_MIN-1);
    cut_assert_not_null(vint);
}

/**/


CUT_EXPORT void test_cs_createNamedCSint_0_TO_INT_MAX_PLUS1(void)
{
    /* this will cause cutter SEGV */
#if 0
    cs_init();
    CSint *vint = cs_createNamedCSint(0, INT_MAX+1, "dummy");
    cut_assert_null(vint);
    cs_end();
#endif
}

CUT_EXPORT void test_cs_createNamedCSint_INT_MIN_MINUS1_TO_0(void)
{
    /* this will cause cutter SEGV */
#if 0
    cs_init();
    CSint *vint = cs_createNamedCSint(INT_MIN-1, 0, "dummy");
    cut_assert_null(vint);
#endif

}

CUT_EXPORT void test_cs_createNamedCSint_INT_MAX_TO_INT_MIN(void)
{
    /* this will cause cutter SEGV */
#if 0
    cs_init();
    CSint *vint = cs_createNamedCSint(INT_MAX, INT_MIN, "dummy");
    cut_assert_null(vint);
#endif
}

CUT_EXPORT void test_cs_createNamedCSint_SWAP(void)
{
    /* this will cause cutter SEGV */
#if 0
    cs_init();
    CSint *vint = cs_createNamedCSint(0, -1, "dummy");
    cut_assert_null(vint);

    vint = cs_createNamedCSint(1, 0, "dummy");
    cut_assert_null(vint);

    vint = cs_createNamedCSint(1, -1, "dummy");
    cut_assert_null(vint);
#endif
}

CUT_EXPORT void test_cs_createNamedCSint(void)
{
    cs_init();
    CSint *vint = cs_createNamedCSint(0, 1, "dummy");
    cut_assert_not_null(vint);

    vint = cs_createNamedCSint(-1, 0, "dummy");
    cut_assert_not_null(vint);

    vint = cs_createNamedCSint(-1, 1, "dummy");
    cut_assert_not_null(vint);

    vint = cs_createNamedCSint(INT_MIN, INT_MAX, "dummy");
    cut_assert_not_null(vint);

    vint = cs_createNamedCSint(0, 0, "dummy");
    cut_assert_not_null(vint);

    vint = cs_createNamedCSint(INT_MIN, INT_MIN, "dummy");
    cut_assert_not_null(vint);

    vint = cs_createNamedCSint(INT_MAX, INT_MAX, "dummy");
    cut_assert_not_null(vint);
}

CUT_EXPORT void test_cs_createCSintFromDomain(void)
{
    cs_init();
    CSint *vint = NULL;

    int array[] = {1};
    vint = cs_createCSintFromDomain(array, 1);
    cut_assert_not_null(vint);

#if 0
    /* this will cause cutter SEGV */
    vint = cs_createCSintFromDomain(NULL, 0);
    cut_assert_null(vint);

    vint = cs_createCSintFromDomain(array, -1);
    cut_assert_null(vint);

    vint = cs_createCSintFromDomain(array, 0);
    cut_assert_null(vint);
#endif
}

CUT_EXPORT void test_cs_createCSintArray(void)
{
    cs_init();
    CSint **avint = NULL;

    avint = cs_createCSintArray(INT_MAX+1, 0, INT_MAX);
    cut_assert_not_null(avint);

    avint = cs_createCSintArray(-1, 0, 0);
    cut_assert_null(avint);

    avint = cs_createCSintArray(0, 0, 0);
    cut_assert_not_null(avint);

    avint = cs_createCSintArray(0, 0, INT_MAX+1);
    cut_assert_not_null(avint);

    avint = cs_createCSintArray(0, INT_MIN-1, 0);
    cut_assert_not_null(avint);
}


CUT_EXPORT void test_cs_getName(void)
{
    CSint *vint = CSINT(1);

    char *name = cs_getName(vint);
    cut_assert_null_string(name);

    cs_setName(vint, "dummy");
    name = cs_getName(vint);
    cut_assert_equal_string("dummy", name);
}

CUT_EXPORT void test_cs_getValue(void)
{
    CSint *vint = NULL;

    cut_assert_equal_int(0, cs_getValue(CSINT(0)));
    cut_assert_equal_int(INT_MIN, cs_getValue(CSINT(INT_MIN)));
    cut_assert_equal_int(INT_MAX, cs_getValue(CSINT(INT_MAX)));

    /* error */
    cut_assert_equal_int(0, cs_getValue(cs_createCSint(0, 10)));
    cut_assert_equal_int(CS_ERR_GETVALUE, cs_getErr());

    cut_assert_equal_int(INT_MIN, cs_getValue(cs_createCSint(INT_MIN, INT_MAX)));
    cut_assert_equal_int(CS_ERR_GETVALUE, cs_getErr());
}

CUT_EXPORT void test_cs_isFree(void)
{
    CSint *vint = NULL;
    CSint *vint2 = NULL;

    cut_assert_true(cs_isFree(cs_createCSint(0, 10)));

    vint = cs_createCSint(INT_MIN, INT_MAX);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint));
    cut_assert_equal_int(INT_MAX, cs_getMax(vint));
    /* may be iz-c bug? expect true, but false */
    cut_assert_true(cs_isFree(vint), "may be iz-c bug?");

    cut_assert_false(cs_isFree(CSINT(0)));
    cut_assert_false(cs_isFree(CSINT(INT_MIN)));
    cut_assert_false(cs_isFree(CSINT(INT_MAX)));

}

CUT_EXPORT void test_cs_isInstantiated(void)
{
    cut_assert_true(cs_isInstantiated(CSINT(0)));
    cut_assert_true(cs_isInstantiated(CSINT(INT_MIN)));
    cut_assert_true(cs_isInstantiated(CSINT(INT_MAX)));

    cut_assert_false(cs_isInstantiated(cs_createCSint(0, 10)));
    cut_assert_false(cs_isInstantiated(cs_createCSint(INT_MIN, INT_MAX)));
}

