local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local ReactiveFlags = require("Vue.reactivity.reactive.ReactiveFlags")
local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local SET, ADD, DELETE = TriggerOpTypes.SET, TriggerOpTypes.ADD, TriggerOpTypes.DELETE
local GET, ITERATE = TrackOpTypes.GET, TrackOpTypes.ITERATE
local assert, getmetatable, setmetatable, type, ipairs, pairs, tinsert, xpcall, tremove, next, rawget, rawset = assert, getmetatable, setmetatable, type, ipairs, pairs, table.insert, xpcall, table.remove, next, rawget, _ENV.rawset
local V_VALUE, V_GETTER, V_SETTER, SKIP, IS_REACTIVE, IS_SHALLOW, IS_READONLY, RAW, IS_REF, IS_COMPUTED, DEPSMAP, SETHOOK, HOOK = ReactiveFlags.V_VALUE, ReactiveFlags.V_GETTER, ReactiveFlags.V_SETTER, ReactiveFlags.SKIP, ReactiveFlags.IS_REACTIVE, ReactiveFlags.IS_SHALLOW, ReactiveFlags.IS_READONLY, ReactiveFlags.RAW, ReactiveFlags.IS_REF, ReactiveFlags.IS_COMPUTED, ReactiveFlags.DEPSMAP, ReactiveFlags.SETHOOK, ReactiveFlags.HOOK
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local isObject, hasChanged, extend, NOOP, EMPTY_OBJ, isFunction, traceback, array_includes, isCallable, clone, genId, getMtDepsMap, setTargetHook = reactiveUtils.isObject, reactiveUtils.hasChanged, reactiveUtils.extend, reactiveUtils.NOOP, reactiveUtils.EMPTY_OBJ, reactiveUtils.isFunction, reactiveUtils.traceback, reactiveUtils.array_includes, reactiveUtils.isCallable, reactiveUtils.clone, reactiveUtils.genId, reactiveUtils.getMtDepsMap, reactiveUtils.setTargetHook
local effectStack = {}
local activeEffect
local ITERATE_KEY = "iterate"
local shouldTrack = true
local trackStack = {}
local _forcePaused = false

local function pauseTracking()
  tinsert(trackStack, shouldTrack)
  shouldTrack = false
end

local function enableTracking()
  tinsert(trackStack, shouldTrack)
  if not _forcePaused then
    shouldTrack = true
  end
end

local function resetTracking()
  local last = tremove(trackStack)
  shouldTrack = nil == last and true or last
end

local function forcePauseTracking()
  tinsert(trackStack, shouldTrack)
  shouldTrack = false
  _forcePaused = true
end

local function forceResetTracking()
  _forcePaused = false
  local last = tremove(trackStack)
  shouldTrack = nil == last and true or last
end

local E_FUNC = 1
local E_DESTROYED = 2
local E_ON_SCHEDULER = 3
local E_ON_STOP = 4
local E_ON_TRACK = 5
local E_ON_TRIGGER = 6
local E_DEPS = 7
local C_SETTER = 8
local C_DIRTY = 9
local C_VALUE = 10

local function cleanup(effect)
  local deps = rawget(effect, E_DEPS)
  if deps then
    for dep in pairs(deps) do
      dep[effect] = nil
      deps[dep] = nil
    end
  end
end

local effect_call = no_yieldable_call or xpcall

local function runEffect(self, ...)
  if rawget(self, E_DESTROYED) then
    if rawget(self, E_ON_SCHEDULER) then
      return nil
    else
      do return rawget(self, E_FUNC), ... end
      return rawget(self, E_FUNC), ...
    end
  end
  if not array_includes(effectStack, self) then
    cleanup(self)
    enableTracking()
    tinsert(effectStack, self)
    activeEffect = self
    local result, ret = effect_call(rawget(self, E_FUNC), traceback, ...)
    tremove(effectStack)
    resetTracking()
    activeEffect = effectStack[#effectStack]
    return ret
  end
  return nil
end

local EffectMetatable = {}
EffectMetatable.__call = runEffect

local function isEffect(fn)
  return getmetatable(fn) == EffectMetatable
end

local function createReactiveEffect(fn, options)
  local effect = {
    id = genId(),
    [E_FUNC] = fn,
    [E_ON_SCHEDULER] = options.scheduler,
    [E_ON_STOP] = options.onStop,
    [E_ON_TRACK] = options.onTrack,
    [E_ON_TRIGGER] = options.onTrigger
  }
  setmetatable(effect, EffectMetatable)
  return effect
end

local function effect(fn, options)
  if nil == options then
    options = EMPTY_OBJ
  end
  if isEffect(fn) then
    fn = rawget(fn, E_FUNC)
  end
  local effect = createReactiveEffect(fn, options)
  if not options.lazy then
    effect()
  end
  return effect
end

local function stop(self)
  if not rawget(self, E_DESTROYED) then
    cleanup(self)
    local onStop = rawget(self, E_ON_STOP)
    if onStop then
      onStop(self)
    end
    rawset(self, E_DESTROYED, true)
  end
end

local weakMt = {__mode = "k"}

local function track(target, trackType, key)
  if not shouldTrack or nil == activeEffect or "table" ~= type(target) then
    return
  end
  local mt = getmetatable(target)
  assert(mt, "必须是响应式对象才能track，请调用reactive(target)")
  if not rawget(mt, IS_REACTIVE) then
    return
  end
  local depsMap = getMtDepsMap(target)
  local dep = depsMap[key]
  if not dep then
    dep = {}
    setmetatable(dep, weakMt)
    depsMap[key] = dep
  end
  if not dep[activeEffect] then
    dep[activeEffect] = true
    local deps = rawget(activeEffect, E_DEPS)
    if not deps then
      deps = {}
      rawset(activeEffect, E_DEPS, deps)
    end
    deps[dep] = true
    if __DEV__ and rawget(activeEffect, E_ON_TRACK) then
      rawget(activeEffect, E_ON_TRACK)(activeEffect, target, trackType, key)
    end
  end
end

local function triggerEffects(effectsToAdd, target, triggerType, key, newValue, oldValue)
  if effectsToAdd and next(effectsToAdd) then
    for effect in pairs(clone(effectsToAdd)) do
      if effect ~= activeEffect or not shouldTrack then
        if __DEV__ and rawget(effect, E_ON_TRIGGER) then
          rawget(effect, E_ON_TRIGGER)(effect, target, triggerType, key, newValue, oldValue)
        end
        if rawget(effect, E_ON_SCHEDULER) then
          rawget(effect, E_ON_SCHEDULER)(effect, target, triggerType, key, newValue, oldValue)
        else
          effect(effect, target, triggerType, key, newValue, oldValue)
        end
      end
    end
  end
end

local function trigger(target, triggerType, key, newValue, oldValue)
  local mt = getmetatable(target)
  assert(mt)
  local depsMap = rawget(target, DEPSMAP)
  if not depsMap then
    return
  end
  if nil ~= key then
    triggerEffects(depsMap[key], target, triggerType, key, newValue, oldValue)
  end
  triggerEffects(depsMap[ITERATE_KEY], target, triggerType, key, newValue, oldValue)
end

local function hasActiveEffect()
  return nil ~= activeEffect
end

return {
  trigger = trigger,
  track = track,
  stop = stop,
  effect = effect,
  getMtDepsMap = getMtDepsMap,
  ITERATE_KEY = ITERATE_KEY,
  pauseTracking = pauseTracking,
  resetTracking = resetTracking,
  enableTracking = enableTracking,
  forcePauseTracking = forcePauseTracking,
  forceResetTracking = forceResetTracking,
  hasActiveEffect = hasActiveEffect,
  genId = genId,
  runEffect = runEffect,
  E_FUNC = E_FUNC,
  E_DESTROYED = E_DESTROYED,
  E_ON_SCHEDULER = E_ON_SCHEDULER,
  E_ON_STOP = E_ON_STOP,
  E_ON_TRACK = E_ON_TRACK,
  E_ON_TRIGGER = E_ON_TRIGGER,
  E_DEPS = E_DEPS,
  C_SETTER = C_SETTER,
  C_DIRTY = C_DIRTY,
  C_VALUE = C_VALUE
}
