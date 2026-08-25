local ReactiveFlags = require("Vue.reactivity.reactive.ReactiveFlags")
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local SET, ADD, DELETE = TriggerOpTypes.SET, TriggerOpTypes.ADD, TriggerOpTypes.DELETE
local GET, ITERATE = TrackOpTypes.GET, TrackOpTypes.ITERATE
local effect = require("Vue.reactivity.effect")
local track, trigger, IPAIR_KEY, PAIR_KEY = effect.track, effect.trigger, effect.IPAIR_KEY, effect.PAIR_KEY
local V_VALUE, V_GETTER, V_SETTER, SKIP, IS_REACTIVE, IS_SHALLOW, IS_READONLY, RAW, IS_REF, IS_COMPUTED, SETHOOK, HOOK = ReactiveFlags.V_VALUE, ReactiveFlags.V_GETTER, ReactiveFlags.V_SETTER, ReactiveFlags.SKIP, ReactiveFlags.IS_REACTIVE, ReactiveFlags.IS_SHALLOW, ReactiveFlags.IS_READONLY, ReactiveFlags.RAW, ReactiveFlags.IS_REF, ReactiveFlags.IS_COMPUTED, ReactiveFlags.SETHOOK, ReactiveFlags.HOOK
local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local type, ipairs, pairs, setmetatable, assert, rawget, getmetatable, rawset = type, ipairs, pairs, setmetatable, assert, rawget, getmetatable, _ENV.rawset
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local isObject, hasChanged, extend, NOOP, setTargetHook = reactiveUtils.isObject, reactiveUtils.hasChanged, reactiveUtils.extend, reactiveUtils.NOOP, reactiveUtils.setTargetHook
local RefUtils
return function(Reactive)
  if RefUtils then
    return RefUtils
  end
  
  local function isRef(r)
    local mt = getmetatable(r)
    local rr = mt and rawget(mt, IS_REF)
    return rr
  end
  
  local Observer = {
    [IS_REACTIVE] = true,
    [IS_READONLY] = false,
    [IS_SHALLOW] = false,
    [IS_REF] = true,
    [IS_COMPUTED] = false
  }
  local ReadonlyObserver = {
    [IS_REACTIVE] = true,
    [IS_READONLY] = true,
    [IS_SHALLOW] = false,
    [IS_REF] = true,
    [IS_COMPUTED] = false
  }
  local ShallowObserver = {
    [IS_REACTIVE] = true,
    [IS_READONLY] = false,
    [IS_SHALLOW] = true,
    [IS_REF] = true,
    [IS_COMPUTED] = false
  }
  local ShallowReadonlyObserver = {
    [IS_REACTIVE] = true,
    [IS_READONLY] = true,
    [IS_SHALLOW] = true,
    [IS_REF] = true,
    [IS_COMPUTED] = false
  }
  
  local function ObserverGetter(self)
    track(self, GET, "value")
    do return rawget, self end
    return rawget, self, V_VALUE, "value"
  end
  
  local function ObserverSetter(self, newValue)
    local oldValue = rawget(self, V_VALUE)
    if newValue == oldValue then
      return
    end
    if isRef(newValue) then
      newValue = newValue()
    end
    if "table" == type(newValue) then
      newValue = Reactive.reactive(newValue, rawget(self, HOOK))
    end
    rawset(self, V_VALUE, newValue)
    trigger(self, SET, "value", newValue, oldValue)
  end
  
  local function ReadonlySetter(self)
    reactiveUtils.error("readonly ref value")
  end
  
  local function ShallowSetter(self, newValue)
    local oldValue = rawget(self, V_VALUE)
    if newValue == oldValue then
      return
    end
    if isRef(newValue) then
      newValue = newValue()
    end
    rawset(self, V_VALUE, newValue)
    trigger(self, SET, "value", newValue, oldValue)
  end
  
  local function ObserverIndex(self, key)
    assert("value" == key, "only access Ref getter with \"value\" key")
    do return ObserverGetter end
    return ObserverGetter, self, "only access Ref getter with \"value\" key"
  end
  
  local function ObserverNewIndex(self, key, newValue)
    assert("value" == key, "only access Ref setter with \"value\" key")
    ObserverSetter(self, newValue)
  end
  
  local function ShallowObserverNewIndex(self, key, newValue)
    assert("value" == key, "only access Ref setter with \"value\" key")
    ShallowSetter(self, newValue)
  end
  
  Observer[V_GETTER] = ObserverGetter
  Observer[V_SETTER] = ObserverSetter
  Observer[SETHOOK] = setTargetHook
  Observer.__index = ObserverIndex
  Observer.__call = ObserverGetter
  Observer.__newindex = ObserverNewIndex
  ReadonlyObserver[V_GETTER] = ObserverGetter
  ReadonlyObserver[V_SETTER] = ReadonlySetter
  ReadonlyObserver[SETHOOK] = setTargetHook
  ReadonlyObserver.__index = ObserverIndex
  ReadonlyObserver.__call = ObserverGetter
  ReadonlyObserver.__newindex = ReadonlySetter
  ShallowObserver[V_GETTER] = ObserverGetter
  ShallowObserver[V_SETTER] = ShallowSetter
  ShallowObserver[SETHOOK] = setTargetHook
  ShallowObserver.__index = ObserverIndex
  ShallowObserver.__call = ObserverGetter
  ShallowObserver.__newindex = ShallowObserverNewIndex
  ShallowReadonlyObserver[V_GETTER] = ObserverGetter
  ShallowReadonlyObserver[V_SETTER] = ReadonlySetter
  ShallowReadonlyObserver[SETHOOK] = setTargetHook
  ShallowReadonlyObserver.__index = ObserverIndex
  ShallowReadonlyObserver.__call = ObserverGetter
  ShallowReadonlyObserver.__newindex = ReadonlySetter
  
  local function createRef(value, isReadonly, shallow)
    if isRef(value) then
      return value
    end
    if not shallow and "table" == type(value) then
      value = Reactive.reactive(value)
    end
    local ob = shallow and (isReadonly and ShallowReadonlyObserver or ShallowObserver) or isReadonly and ReadonlyObserver or Observer
    local refObject = {
      [V_VALUE] = value
    }
    setmetatable(refObject, ob)
    return refObject
  end
  
  local function ref(value)
    do return createRef, value, false end
    return createRef, value, false, false
  end
  
  local function shallowRef(value)
    do return createRef, value, false end
    return createRef, value, false, true
  end
  
  local function readonlyShallowRef(value)
    do return createRef, value, true end
    return createRef, value, true, true
  end
  
  local function readonlyRef(value)
    do return createRef, value end
    return createRef, value, true
  end
  
  local function triggerRef(ref)
    local value = ref.value
    trigger(ref, SET, "value", value, value)
  end
  
  local function unref(ref)
    if isRef(ref) then
      return ref.value
    else
      return ref
    end
  end
  
  RefUtils = {
    isRef = isRef,
    ref = ref,
    shallowRef = shallowRef,
    readonlyRef = readonlyRef,
    readonlyShallowRef = readonlyShallowRef,
    triggerRef = triggerRef,
    unref = unref
  }
  return RefUtils
end
