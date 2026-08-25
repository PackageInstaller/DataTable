local ReactiveFlags = {
  SKIP = {"__v_skip"},
  TYPE = "__v_type",
  IS_REACTIVE = "__v_isReactive",
  IS_READONLY = "__v_isReadonly",
  IS_SHALLOW = "__v_isShallow",
  IS_MODEL_STATE = "__v_isModelState",
  IS_REF = "__v_isRef",
  IS_COMPUTED = "__v_isComputed",
  DEPSMAP = "__v_depsMap",
  HOOK = "__v_hook",
  HOOK_EFFECT = "__v_hook_effect",
  SETHOOK = "__set_hook",
  PROPERTIES = "__v__properties",
  IS_RUNNING_ACTION = "__v__isRunningAction",
  V_GETTER = 1,
  V_SETTER = 2,
  V_VALUE = 3
}
return ReactiveFlags
