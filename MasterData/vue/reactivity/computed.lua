local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local ReactiveFlags = require("Vue.reactivity.reactive.ReactiveFlags")
local Effect = require("Vue.reactivity.effect")
local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local runEffect, track, trigger, effect = Effect.runEffect, Effect.track, Effect.trigger, Effect.effect
local SET, ADD, DELETE = TriggerOpTypes.SET, TriggerOpTypes.ADD, TriggerOpTypes.DELETE
local GET, ITERATE = TrackOpTypes.GET, TrackOpTypes.ITERATE
local assert, getmetatable, setmetatable, type, ipairs, pairs, tinsert, xpcall, tremove, tunpack, rawget, rawset = assert, getmetatable, setmetatable, type, ipairs, pairs, table.insert, xpcall, table.remove, table.unpack, rawget, _ENV.rawset
local V_VALUE, V_GETTER, V_SETTER, SKIP, IS_REACTIVE, IS_SHALLOW, IS_READONLY, RAW, IS_REF, IS_COMPUTED, DEPSMAP, SETHOOK, HOOK = ReactiveFlags.V_VALUE, ReactiveFlags.V_GETTER, ReactiveFlags.V_SETTER, ReactiveFlags.SKIP, ReactiveFlags.IS_REACTIVE, ReactiveFlags.IS_SHALLOW, ReactiveFlags.IS_READONLY, ReactiveFlags.RAW, ReactiveFlags.IS_REF, ReactiveFlags.IS_COMPUTED, ReactiveFlags.DEPSMAP, ReactiveFlags.SETHOOK, ReactiveFlags.HOOK
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local isObject, hasChanged, extend, NOOP, EMPTY_OBJ, isFunction, traceback, array_includes, isCallable, clone, genId, getMtDepsMap, setTargetHook = reactiveUtils.isObject, reactiveUtils.hasChanged, reactiveUtils.extend, reactiveUtils.NOOP, reactiveUtils.EMPTY_OBJ, reactiveUtils.isFunction, reactiveUtils.traceback, reactiveUtils.array_includes, reactiveUtils.isCallable, reactiveUtils.clone, reactiveUtils.genId, reactiveUtils.getMtDepsMap, reactiveUtils.setTargetHook
local ComputedUtils
return function(Reactive)
  if ComputedUtils then
    return ComputedUtils
  end
  
  local function setHook(target, hook)
    setTargetHook(target, hook)
  end
  
  local C_SETTER = Effect.C_SETTER
  local C_DIRTY = Effect.C_DIRTY
  local C_VALUE = Effect.C_VALUE
  local ComputedMetatable = {
    [IS_REACTIVE] = true,
    [IS_READONLY] = false,
    [IS_SHALLOW] = false,
    [IS_REF] = true,
    [IS_COMPUTED] = true
  }
  local ReadonlyComputedMetatable = {
    [IS_REACTIVE] = true,
    [IS_READONLY] = true,
    [IS_SHALLOW] = false,
    [IS_REF] = true,
    [IS_COMPUTED] = true
  }
  ComputedMetatable.__call = runEffect
  ComputedMetatable[SETHOOK] = setHook
  ReadonlyComputedMetatable.__call = runEffect
  ReadonlyComputedMetatable[SETHOOK] = setHook
  
  local function isRef(r)
    local mt = getmetatable(r)
    return mt and rawget(mt, IS_REF)
  end
  
  local function ComputedGetter(self, instance)
    if rawget(self, C_DIRTY) then
      local newValue = runEffect(self, instance or self, rawget(self, C_VALUE))
      if isRef(newValue) then
        newValue = newValue()
      end
      if "table" == type(newValue) then
        newValue = Reactive.reactive(newValue, rawget(self, HOOK))
      end
      rawset(self, C_VALUE, newValue)
      rawset(self, C_DIRTY, false)
    end
    track(self, GET, "value")
    do return rawget, self end
    return rawget, self, C_VALUE, "value", false, rawget(self, HOOK)
  end
  
  local function ComputedSetter(self, value, instance)
    rawget(self, C_SETTER)(instance or self, value)
  end
  
  local function ReadonlyComputedSetter(self)
    reactiveUtils.error("Write operation failed: computed value is readonly")
  end
  
  local function ComputedIndex(self, key)
    assert("value" == key, "only access computed getter with \"value\" key")
    do return ComputedGetter end
    return ComputedGetter, self, "only access computed getter with \"value\" key"
  end
  
  local function ComputedNewIndex(self, key, newValue)
    assert("value" == key, "only access computed setter with \"value\" key")
    ComputedSetter(self, newValue)
  end
  
  ComputedMetatable[V_GETTER] = ComputedGetter
  ComputedMetatable[V_SETTER] = ComputedSetter
  ComputedMetatable.__index = ComputedIndex
  ComputedMetatable.__newindex = ComputedNewIndex
  ComputedMetatable.__call = ComputedGetter
  ReadonlyComputedMetatable[V_GETTER] = ComputedGetter
  ReadonlyComputedMetatable[V_SETTER] = ReadonlyComputedSetter
  ReadonlyComputedMetatable.__index = ComputedIndex
  ReadonlyComputedMetatable.__newindex = ReadonlyComputedSetter
  ReadonlyComputedMetatable.__call = ComputedGetter
  local computedOptions = {
    lazy = true,
    scheduler = function(effect, target, type, key, newValue, oldValue)
      if not rawget(effect, C_DIRTY) then
        rawset(effect, C_DIRTY, true)
        trigger(effect, SET, "value", newValue, oldValue)
      end
    end
  }
  
  local function computed(getter, setter)
    if __DEV__ then
      if not isCallable(getter) then
        reactiveUtils.error("computed getter is not a function or table with __call")
      end
      if nil ~= setter and not isCallable(setter) then
        reactiveUtils.error("computed setter is not a function or table with __call")
      end
    end
    local computed = effect(getter, computedOptions)
    rawset(computed, C_SETTER, setter)
    rawset(computed, C_DIRTY, true)
    setmetatable(computed, setter and ComputedMetatable or ReadonlyComputedMetatable)
    return computed
  end
  
  ComputedUtils = {computed = computed}
  return ComputedUtils
end
