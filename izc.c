/*
 * izc.c
 */

#include "izc.h"

/*
 * The following function is a dummy one; replace it for
 * your C function definitions.
 */
ScmClass *CSintClass;
ScmClass *CSintArrayClass;

ScmObj test_izc(void)
{
    return SCM_MAKE_STR("izc is working");
}

static void csint_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    CSint *vint = CSINT_UNBOX(obj);
    char *vname = cs_getName(vint);
    int min, max;
    min = cs_getMin(vint);
    max = cs_getMax(vint);
    if (vname) {
        if (min == max) {
            Scm_Printf(out, "#<csint \"%s\" {%d}>", vname, min);
        } else {
            Scm_Printf(out, "#<csint \"%s\" {%d..%d}>", vname, min, max);
        }
    } else {
        if (min == max) {
            Scm_Printf(out, "#<csint {%d}>", min);
        } else {
            Scm_Printf(out, "#<csint {%d..%d}>", min, max);
        }
    }
}

static void csint_cleanup(ScmObj obj)
{
    CSint *q;
    q = CSINT_UNBOX(obj);
}

static void csint_array_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
}

static void csint_array_cleanup(ScmObj obj)
{
}

/*
 * Module initialization function.
 */
extern void Scm_Init_izclib(ScmModule*);

void Scm_Init_izc(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(izc);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("izc", TRUE));

  /* Create the foreign pointer class <mqueue-cpp>.
       The flag SCM_FOREIGN_POINTER_KEEP_IDENTITY makes Gauche to keep
       one-to-one mapping between the foreign object pointer (MQueue*)
       and its wrapping ScmObj.  With this flag, you can assume that
       when mqueue_cleanup is called, no other ScmForeignPointer object
       is pointing to the same MQueue*, thus you can delete it safely. */
    CSintClass =
        Scm_MakeForeignPointerClass(mod, "<csint>",
                                    csint_print,
                                    csint_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    CSintArrayClass =
        Scm_MakeForeignPointerClass(mod, "<csint-array>",
                                    csint_array_print,
                                    csint_array_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);
    /* Register stub-generated procedures */
    Scm_Init_izclib(mod);
}
