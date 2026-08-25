local ReactiveFlags = require("Vue.reactivity.reactive.ReactiveFlags")
local ReactiveTypes = require("Vue.reactivity.reactive.ReactiveTypes")
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local SET, ADD, DELETE = TriggerOpTypes.SET, TriggerOpTypes.ADD, TriggerOpTypes.DELETE
local GET, ITERATE = TrackOpTypes.GET, TrackOpTypes.ITERATE
local V_GETTER, V_SETTER, SKIP, TYPE, IS_REACTIVE, IS_SHALLOW, IS_MODEL_STATE, IS_READONLY, RAW, DEPSMAP, HOOK, SETHOOK, PROPERTIES, IS_REF, IS_COMPUTED = ReactiveFlags.V_GETTER, ReactiveFlags.V_SETTER, ReactiveFlags.SKIP, ReactiveFlags.TYPE, ReactiveFlags.IS_REACTIVE, ReactiveFlags.IS_SHALLOW, ReactiveFlags.IS_MODEL_STATE, ReactiveFlags.IS_READONLY, ReactiveFlags.RAW, ReactiveFlags.DEPSMAP, ReactiveFlags.HOOK, ReactiveFlags.SETHOOK, ReactiveFlags.PROPERTIES, ReactiveFlags.IS_REF, ReactiveFlags.IS_COMPUTED
local TYPE_READONLY, TYPE_REACTIVE, TYPE_SHALLOW, TYPE_SHALLOW_READONLY, TYPE_MODELSTATE = ReactiveTypes.TYPE_READONLY, ReactiveTypes.TYPE_REACTIVE, ReactiveTypes.TYPE_SHALLOW, ReactiveTypes.TYPE_SHALLOW_READONLY, ReactiveTypes.TYPE_MODELSTATE
local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local next, rawget, rawset, type, ipairs, pairs, tinsert, xpcall, getmetatable, setmetatable, sformat, tostring = next, rawget, rawset, type, ipairs, pairs, table.insert, xpcall, getmetatable, setmetatable, string.format, _ENV.tostring
local effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY = effect.track, effect.trigger, effect.ITERATE_KEY
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local isObject, hasChanged, extend, NOOP, EMPTY_OBJ, isFunction, traceback, getMtDepsMap, setTargetHook, removeTargetHook = reactiveUtils.isObject, reactiveUtils.hasChanged, reactiveUtils.extend, reactiveUtils.NOOP, reactiveUtils.EMPTY_OBJ, reactiveUtils.isFunction, reactiveUtils.traceback, reactiveUtils.getMtDepsMap, reactiveUtils.setTargetHook, reactiveUtils.removeTargetHook
local Reactive = {}
local computed = require("Vue.reactivity.computed")(Reactive).computed
local ref = require("Vue.reactivity.ref")(Reactive)
local isRef, toRef, triggerRef = ref.isRef, ref.toRef, ref.triggerRef
local Property = {}
local Observer = {
  [TYPE] = TYPE_REACTIVE,
  [IS_REACTIVE] = true,
  [IS_READONLY] = false,
  [IS_SHALLOW] = false,
  [IS_MODEL_STATE] = false,
  [IS_REF] = false,
  [IS_COMPUTED] = false
}
local ModelStateObserver = {
  [TYPE] = TYPE_MODELSTATE,
  [IS_REACTIVE] = true,
  [IS_READONLY] = false,
  [IS_SHALLOW] = false,
  [IS_MODEL_STATE] = true,
  [IS_REF] = false,
  [IS_COMPUTED] = false
}
local ReadonlyObserver = {
  [TYPE] = TYPE_READONLY,
  [IS_REACTIVE] = true,
  [IS_READONLY] = true,
  [IS_SHALLOW] = false,
  [IS_MODEL_STATE] = false,
  [IS_REF] = false,
  [IS_COMPUTED] = false
}
local ShallowObserver = {
  [TYPE] = TYPE_SHALLOW,
  [IS_REACTIVE] = true,
  [IS_READONLY] = false,
  [IS_SHALLOW] = true,
  [IS_MODEL_STATE] = false,
  [IS_REF] = false,
  [IS_COMPUTED] = false
}
local ShallowReadonlyObserver = {
  [TYPE] = TYPE_SHALLOW_READONLY,
  [IS_REACTIVE] = true,
  [IS_READONLY] = true,
  [IS_SHALLOW] = true,
  [IS_MODEL_STATE] = false,
  [IS_REF] = false,
  [IS_COMPUTED] = false
}

local function isReadonly(value)
  local mt = getmetatable(value)
  return mt and rawget(mt, IS_READONLY)
end

local function isShallow(value)
  local mt = getmetatable(value)
  return mt and rawget(mt, IS_SHALLOW)
end

local function isReactive(value)
  local mt = getmetatable(value)
  return mt and rawget(mt, IS_REACTIVE)
end

local function isModelState(value)
  local mt = getmetatable(value)
  return mt and rawget(mt, IS_MODEL_STATE)
end

local __runningActionCount = 0
local __runningViewCount = 0

local function canModifyState()
  return __runningActionCount > 0 and 0 == __runningViewCount
end

local effect_call = no_yieldable_call or xpcall

local function createStateAction(action)
  return function(...)
    __runningActionCount = __runningActionCount + 1
    local ok, ret = effect_call(action, traceback, ...)
    __runningActionCount = __runningActionCount - 1
    return ret
  end
end

local function createStateView(view)
  return function(...)
    __runningViewCount = __runningViewCount + 1
    local ok, ret = effect_call(view, traceback, ...)
    __runningViewCount = __runningViewCount - 1
    return ret
  end
end

local createReactiveObject

local function defineReactive(target, key, val, reactiveType, hook, properties)
  if "function" == type(val) then
    val = computed(val)
  end
  properties[key] = val
  local childOb = 0 == reactiveType & TYPE_SHALLOW and "table" == type(val) and createReactiveObject(val, reactiveType, hook)
  return val
end

local function walk(obj, reactiveType, properties, hook)
  local keyOb
  local k, v = next(obj)
  while nil ~= k do
    keyOb = 0 == reactiveType & TYPE_SHALLOW and "table" == type(k) and createReactiveObject(k, reactiveType, hook)
    rawset(obj, k, nil)
    defineReactive(obj, k, v, reactiveType, hook, properties)
    k, v = next(obj)
  end
end

local function pairsFunc(self, key)
  local valueStore
  key, valueStore = next(rawget(self, PROPERTIES), key)
  if nil ~= valueStore then
    if isRef(valueStore) then
      return key, valueStore(self)
    else
      return key, valueStore
    end
  end
end

function Observer:__pairs()
  track(self, ITERATE, ITERATE_KEY)
  return pairsFunc, self, nil
end

function Observer.__next(next, self, key)
  local valueStore
  key, valueStore = next(rawget(self, PROPERTIES), key)
  track(self, ITERATE, ITERATE_KEY)
  return key, valueStore
end

ModelStateObserver.__pairs = Observer.__pairs
ModelStateObserver.__next = Observer.__next

function ReadonlyObserver:__pairs()
  return pairsFunc, self, nil
end

local function ipairsFunc(self, i)
  i = i + 1
  local valueStore = rawget(self, PROPERTIES)[i]
  if nil ~= valueStore then
    if isRef(valueStore) then
      return i, valueStore(self)
    else
      return i, valueStore
    end
  end
end

function Observer:__ipairs()
  track(self, ITERATE, ITERATE_KEY)
  return ipairsFunc, self, 0
end

ModelStateObserver.__ipairs = Observer.__ipairs

function ReadonlyObserver:__ipairs()
  return ipairsFunc, self, 0
end

function Observer:__len()
  track(self, ITERATE, ITERATE_KEY)
  return #rawget(self, PROPERTIES)
end

ModelStateObserver.__len = Observer.__len

function ReadonlyObserver:__len()
  return #rawget(self, PROPERTIES)
end

for i, v in pairs(Observer) do
  if "function" == type(v) then
    ShallowObserver[i] = v
  end
end
for i, v in pairs(ReadonlyObserver) do
  if "function" == type(v) then
    ShallowReadonlyObserver[i] = v
  end
end

function Observer:__index(key)
  track(self, GET, key)
  local property = rawget(self, PROPERTIES)[key]
  if isRef(property) then
    do return property end
    return property, self, key
  else
    return property
  end
end

ModelStateObserver.__index = Observer.__index

function ReadonlyObserver:__index(key)
  local property = rawget(self, PROPERTIES)[key]
  if isRef(property) then
    do return property end
    return property, self
  else
    return property
  end
end

ShallowObserver.__index = Observer.__index
ShallowReadonlyObserver.__index = ReadonlyObserver.__index

function ReadonlyObserver:__newindex(key, newValue)
  if __DEV__ then
    if nil ~= newValue then
      reactiveUtils.warn("Set operation on key \"" .. tostring(key) .. "\" failed: target is readonly.")
    else
      reactiveUtils.warn("Delete operation on key \"" .. tostring(key) .. "\" failed: target is readonly.")
    end
  end
end

ShallowReadonlyObserver.__newindex = ReadonlyObserver.__index

local function observerSetter(self, key, newVal)
  local properties = rawget(self, PROPERTIES)
  local oldValue = properties[key]
  if isRef(oldValue) then
    if isRef(newVal) then
      properties[key] = newVal
      trigger(self, SET, key, newVal(self), oldValue(self))
    else
      rawget(getmetatable(oldValue), V_SETTER)(oldValue, newVal, self)
    end
  elseif nil ~= oldValue then
    if newVal == oldValue then
      return
    end
    if "table" == type(newVal) then
      createReactiveObject(newVal, TYPE_REACTIVE, rawget(self, HOOK))
    end
    properties[key] = newVal
    if nil == newVal then
      properties[key] = nil
      trigger(self, DELETE, key, newVal, oldValue)
    else
      trigger(self, SET, key, newVal, oldValue)
    end
  elseif nil ~= newVal then
    newVal = defineReactive(self, key, newVal, TYPE_REACTIVE, rawget(self, HOOK), properties)
    trigger(self, ADD, key, newVal)
  end
end

Observer.__newindex = observerSetter

function ModelStateObserver:__newindex(key, newVal)
  if not canModifyState() then
    if __DEV__ then
      if nil ~= newVal then
        reactiveUtils.warn(traceback("Set operation on key \"" .. tostring(key) .. "\" failed: 目标是一个ModelState, 修改值只允许在actions中操作."))
      else
        reactiveUtils.warn(traceback("Delete operation on key \"" .. tostring(key) .. "\" failed: 目标是一个ModelState, 删除值只允许在actions中操作."))
      end
    end
    return
  end
  local properties = rawget(self, PROPERTIES)
  local oldValue = properties[key]
  if isRef(oldValue) then
    if isRef(newVal) then
      properties[key] = newVal
      trigger(self, SET, key, newVal(self), oldValue(self))
    else
      rawget(getmetatable(oldValue), V_SETTER)(oldValue, newVal, self)
    end
  elseif nil ~= oldValue then
    if newVal == oldValue then
      return
    end
    if "table" == type(newVal) then
      createReactiveObject(newVal, TYPE_MODELSTATE, rawget(self, HOOK))
    end
    properties[key] = newVal
    if nil == newVal then
      properties[key] = nil
      trigger(self, DELETE, key, newVal, oldValue)
    else
      trigger(self, SET, key, newVal, oldValue)
    end
  elseif nil ~= newVal then
    newVal = defineReactive(self, key, newVal, TYPE_MODELSTATE, rawget(self, HOOK), properties)
    trigger(self, ADD, key, newVal)
  end
end

function ShallowObserver:__newindex(key, newVal)
  local properties = rawget(self, PROPERTIES)
  local oldValue = properties[key]
  if isRef(oldValue) then
    if isRef(newVal) then
      properties[key] = newVal
      trigger(self, SET, key, newVal(self), oldValue(self))
    else
      rawget(getmetatable(oldValue), V_SETTER)(oldValue, newVal, self)
    end
  elseif nil ~= oldValue then
    if newVal == oldValue then
      return
    end
    properties[key] = newVal
    if nil == newVal then
      properties[key] = nil
      trigger(self, DELETE, key, newVal, oldValue)
    else
      trigger(self, SET, key, newVal, oldValue)
    end
  elseif nil ~= newVal then
    newVal = defineReactive(self, key, newVal, TYPE_SHALLOW, rawget(self, HOOK), properties)
    trigger(self, ADD, key, newVal)
  end
end

local reactiveTypeMetatables = {
  [TYPE_READONLY] = ReadonlyObserver,
  [TYPE_REACTIVE] = Observer,
  [TYPE_SHALLOW] = ShallowObserver,
  [TYPE_SHALLOW_READONLY] = ShallowReadonlyObserver,
  [TYPE_MODELSTATE] = ModelStateObserver
}
local weakMt = {__mode = "k"}
for reactiveType, reactiveMetatable in pairs(reactiveTypeMetatables) do
  reactiveMetatable[SETHOOK] = function(target, hook)
    if setTargetHook(target, hook) then
      local properties = rawget(target, PROPERTIES)
      local k, v = next(properties)
      while nil ~= k do
        if "table" == type(k) then
          createReactiveObject(k, reactiveType, hook)
        end
        if "table" == type(v) then
          createReactiveObject(v, reactiveType, hook)
        end
        k, v = next(properties, k)
      end
    end
  end
end

function createReactiveObject(target, reactiveType, hook)
  local observed = getmetatable(target)
  if nil == observed then
    setmetatable(target, reactiveTypeMetatables[reactiveType])
    local properties = {}
    walk(target, reactiveType, properties, hook)
    rawset(target, PROPERTIES, properties)
    if hook then
      setTargetHook(target, hook)
    end
  else
    if __DEV__ and 0 ~= (observed[TYPE] or 0) & (TYPE_READONLY | TYPE_SHALLOW) then
      reactiveUtils.warn("cannot change readonly or shallow on a reactive object")
    end
    if hook and rawget(observed, IS_REACTIVE) then
      local setHook = rawget(observed, SETHOOK)
      setHook(target, hook)
    end
  end
  return target
end

local function reactive(target, hook)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made reactive: ", tostring(target))
    end
    return target
  end
  do return createReactiveObject, target, TYPE_REACTIVE end
  return createReactiveObject, target, TYPE_REACTIVE, hook
end

local function shallowReactive(target)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made shallow reactive: ", tostring(target))
    end
    return target
  end
  do return createReactiveObject, target end
  return createReactiveObject, target, TYPE_SHALLOW, tostring(target)
end

local function readonly(target)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made readonly reactive: ", tostring(target))
    end
    return target
  end
  do return createReactiveObject, target end
  return createReactiveObject, target, TYPE_READONLY, tostring(target)
end

local function shallowReadonly(target)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made shallow readonly reactive: ", tostring(target))
    end
    return target
  end
  do return createReactiveObject, target end
  return createReactiveObject, target, TYPE_SHALLOW_READONLY, tostring(target)
end

local function modelState(target)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made model state reactive: ", tostring(target))
    end
    return target
  end
  do return createReactiveObject, target end
  return createReactiveObject, target, TYPE_MODELSTATE, tostring(target)
end

local function markRaw(target)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made raw: ", tostring(target))
    end
    return target
  end
  if nil == getmetatable(target) then
    do return setmetatable, target end
    return setmetatable, target, SKIP, tostring(target)
  else
    if __DEV__ then
      reactiveUtils.warn("target with metatable cannot be made raw: ", tostring(target))
    end
    return target
  end
end

local function removeHook(target)
  if "table" ~= type(target) then
    if __DEV__ then
      reactiveUtils.warn("target cannot be made removeHook: ", tostring(target))
    end
    return target
  end
  local observed = getmetatable(target)
  if nil ~= observed and rawget(observed, IS_REACTIVE) then
    removeTargetHook(target)
  end
end

local function withoutTracking(fn)
  effect.forcePauseTracking()
  local ok, result = xpcall(fn, traceback)
  effect.forceResetTracking()
  if not ok then
    error(result)
  end
  return result
end

Reactive.modelState = modelState
Reactive.reactive = reactive
Reactive.readonly = readonly
Reactive.shallowReadonly = shallowReadonly
Reactive.shallowReactive = shallowReactive
Reactive.isReadonly = isReadonly
Reactive.isReactive = isReactive
Reactive.isShallow = isShallow
Reactive.isModelState = isModelState
Reactive.markRaw = markRaw
Reactive.withoutTracking = withoutTracking
Reactive.createStateAction = createStateAction
Reactive.createStateView = createStateView
Reactive.removeHook = removeHook
return Reactive
