/*
 * izc.h
 */

/* Prologue */
#ifndef GAUCHE_IZC_H
#define GAUCHE_IZC_H

#include <gauche.h>
#include <gauche/extend.h>

SCM_DECL_BEGIN

#include "iz.h"

/*
 * The following entry is a dummy one.
 * Replace it for your declarations.
 */

extern ScmObj test_izc(void);

extern ScmClass *CSintClass;
extern ScmClass *CSintArrayClass;

#define CSINT_P(obj)      SCM_XTYPEP(obj, CSintClass)
#define CSINT_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(CSint*, obj)
#define CSINT_BOX(ptr)    Scm_MakeForeignPointer(CSintClass, ptr)

#define CSINTARRAY_P(obj)      SCM_XTYPEP(obj, CSintArrayClass)
#define CSINTARRAY_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(CSint**, obj)
#define CSINTARRAY_BOX(ptr)    Scm_MakeForeignPointer(CSintArrayClass, ptr)

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_IZC_H */
