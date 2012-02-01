static CSint* cs_findFreeVarBridge(CSint **allvars, int nbVars)
{
  ScmObj proc = SCM_OBJ(g_findFreeVarProc);
  ScmObj obj = Scm_MakeVector(nbVars, SCM_NIL);
  ScmVector *vec = SCM_VECTOR(obj);
#if defined(DEBUG) && defined(DEBUG_FUNC)
  printf("FUNC: cs_findFreeVarBridge called.\n");
#endif
  int i = 0;
  for (i = 0; i < nbVars; i++) {
    Scm_VectorSet(vec, i, CSINT_BOX(allvars[i]));
  }
  ScmObj r;
  CSint *vint = NULL;
  if (SCM_PROCEDUREP(proc) == TRUE) {
#ifdef DEBUG
    printf("callback scheme world find free var\n");
#endif
    r = Scm_ApplyRec(proc, SCM_OBJ(vec));
    vint = CSINT_UNBOX(r);
  } else if (SCM_SYMBOLP(proc)) {
    if (Scm_EqualP(SCM_OBJ(proc), SCM_OBJ(SCM_INTERN("elements"))) == TRUE) {
#ifdef DEBUG
      printf("callback cs_findFreeVarNbElements\n");
#endif
      vint = cs_findFreeVarNbElements(allvars, nbVars);
    } else if (Scm_EqualP(SCM_OBJ(proc), SCM_OBJ(SCM_INTERN("elements-min"))) == TRUE) {
#ifdef DEBUG
      printf("callback cs_findFreeVarNbElementsMin\n");
#endif
      vint = cs_findFreeVarNbElementsMin(allvars, nbVars);
            
#ifdef DEBUG
      cs_printf("cs_findFreeVarNbElementsMin, got %T 0x%p\n", vint, vint);
#endif
    } else if (Scm_EqualP(SCM_OBJ(proc), SCM_OBJ(SCM_INTERN("constrains"))) == TRUE) {
#ifdef DEBUG
      printf("callback cs_findFreeVarNbConstraints\n");
#endif
      vint = cs_findFreeVarNbConstraints(allvars, nbVars);
            
    } else {
      Scm_Error("symbol elements or elements-min or constrains required as findFreeVar callback type, but got %S", proc);
    }
  } else {
    /* call default callback. */
#ifdef DEBUG
    printf("callback default cs_findFreeVar\n");
    for (i = 0; i < nbVars; i++) {
      cs_printf("allvars[%d] %T\n", i, allvars[i]);
    }
#endif
    vint = cs_findFreeVar(allvars, nbVars);
  }
#ifdef DEBUG
  if (vint) {
    cs_printf("findFreeVar return vint: %T\n", vint);
  }
#endif
  return vint;
}

int cs_findFreeVarIntBridge(CSint **allvars, int nbVars)
{
  ScmObj proc = SCM_OBJ(g_findFreeVarProc);
  ScmObj obj = Scm_MakeVector(nbVars, SCM_NIL);
  ScmVector *vec = SCM_VECTOR(obj);
  int ret = 0;
  int i = 0;
  for (i = 0; i < nbVars; i++) {
    Scm_VectorSet(vec, i, CSINT_BOX(allvars[i]));
  }
  ScmObj r;
  if (SCM_PROCEDUREP(proc) == TRUE) {
#ifdef DEBUG
    printf("callback scheme world find free var\n");
#endif
    r = Scm_ApplyRec(proc, SCM_OBJ(vec));
  } else {
    /* call default callback. */
#ifdef DEBUG
    printf("callback default cs_findFreeVar\n");
#endif
    r = CSINT_BOX(cs_findFreeVar(allvars, nbVars));
  }
  ret = SCM_INT_VALUE(r);
#ifdef DEBUG
  cs_printf("findFreeVarInt return ret: %d\n", ret);
#endif
  return ret;
}



static int cs_criteriaBridge(int index, int val)
{
#ifdef DEBUG
  printf("callback cs_criteriaBridge()\n");
#endif
  ScmObj proc = SCM_OBJ(g_criteriaProc);
  ScmObj sindex = Scm_MakeInteger(index);
  ScmObj sval = Scm_MakeInteger(val);
  int ret;
  if (SCM_PROCEDUREP(proc) == TRUE) {
#ifdef DEBUG
    printf("callback scheme world find free var\n");
#endif
    ret = SCM_INT_VALUE(Scm_ApplyRec(proc, SCM_LIST2(sindex, sval)));
  } else {
    /* call default callback. */
#ifdef DEBUG
    printf("callback default criteria\n");
#endif
    ret = 0;
  }
  return ret;
}

static void cs_foundBridge(CSint **allvars, int nbVars)
{
#if defined(DEBUG) && defined(DEBUG_FUNC)
  printf("callback cs_foundBridge()\n");
#endif
  ScmObj proc = SCM_OBJ(g_foundProc);
  ScmObj obj = Scm_MakeVector(nbVars, SCM_NIL);
  ScmVector *vec = SCM_VECTOR(obj);
  int i = 0;
  for (i = 0; i < nbVars; i++) {
#ifdef DEBUG
    cs_printf("found allvars[%d] %T\n", i, allvars[i]);
#endif
    Scm_VectorSet(vec, i, CSINT_BOX(allvars[i]));
  }
  ScmObj r;
  if (SCM_PROCEDUREP(proc) == TRUE) {
#ifdef DEBUG
    printf("callback scheme world (found allvars::<vector>)\n");
    printf("vector size %d\n", SCM_VECTOR_SIZE(vec));
    CSint *vint;
    for (i = 0; i < nbVars; i++) {
      vint = CSINT_UNBOX(Scm_VectorRef(vec, i, SCM_NIL));
      printf("%d\n", cs_getValue(vint));
      printf("min: %d max: %d value: %d\n",
             cs_getMin(vint),
             cs_getMax(vint),
             cs_getValue(vint));
    }
#endif
    r = Scm_ApplyRec(proc, SCM_LIST1(obj));
  } else {
    /* call default callback. */
#ifdef DEBUG
    printf("no callback for (found allvars::<vector>\n");
#endif
    cs_printf("found %A\n", allvars);
  }
  return;
}

static void cs_foundWithCostBridge(CSint **allvars, int nbVars, CSint *vint)
{
  ScmObj proc = SCM_OBJ(g_findFreeVarProc);
  ScmObj obj = Scm_MakeVector(nbVars, SCM_NIL);
  ScmVector *vec = SCM_VECTOR(obj);
#if defined(DEBUG) && defined(DEBUG_FUNC)
  printf("FUNC: cs_findFreeVarBridge called.\n");
#endif
  int i = 0;
  for (i = 0; i < nbVars; i++) {
    Scm_VectorSet(vec, i, CSINT_BOX(allvars[i]));
  }
  ScmObj r;
  if (SCM_PROCEDUREP(proc) == TRUE) {
#ifdef DEBUG
    printf("callback scheme world find free var\n");
#endif
    r = Scm_ApplyRec(proc, SCM_OBJ(vec));
    vint = CSINT_UNBOX(r);
  } else if (SCM_SYMBOLP(proc)) {
    if (Scm_EqualP(SCM_OBJ(proc), SCM_OBJ(SCM_INTERN("elements"))) == TRUE) {
#ifdef DEBUG
      printf("callback cs_findFreeVarNbElements\n");
#endif
      vint = cs_findFreeVarNbElements(allvars, nbVars);
    } else if (Scm_EqualP(SCM_OBJ(proc), SCM_OBJ(SCM_INTERN("elements-min"))) == TRUE) {
#ifdef DEBUG
      printf("callback cs_findFreeVarNbElementsMin\n");
#endif
      vint = cs_findFreeVarNbElementsMin(allvars, nbVars);
      
    } else if (Scm_EqualP(SCM_OBJ(proc), SCM_OBJ(SCM_INTERN("constrains"))) == TRUE) {
#ifdef DEBUG
      printf("callback cs_findFreeVarNbConstraints\n");
#endif
      vint = cs_findFreeVarNbConstraints(allvars, nbVars);
      
    } else {
      Scm_Error("symbol elements or elements-min or constrains required as findFreeVar callback type, but got %S", proc);
    }
  } else {
    /* call default callback. */
#ifdef DEBUG
    printf("callback default cs_findFreeVar\n");
    for (i = 0; i < nbVars; i++) {
      cs_printf("allvars[%d] %T\n", i, allvars[i]);
    }
#endif
    vint = cs_findFreeVar(allvars, nbVars);
  }
#ifdef DEBUG
  if (vint) {
    cs_printf("findFreeVar return vint: %T\n", vint);
  }
#endif
}
    
