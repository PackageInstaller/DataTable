local ReactiveFlags = require("Vue.reactivity.reactive.ReactiveFlags")
local type, ipairs, pairs, ltraceback, xpcall, tinsert, getmetatable, setmetatable, rawget, rawset = type, ipairs, pairs, debug.traceback, xpcall, table.tinsert, getmetatable, setmetatable, rawget, _ENV.rawset

local function isObject(obj)
  return "table" == type(obj)
end

local function isFunction(obj)
  return "function" == type(obj)
end

local function isCallable(obj)
  local t = type(obj)
  if "function" == t then
    return true
  elseif "table" == t then
    local mt = getmetatable(obj)
    if mt then
      return mt.__call ~= nil
    end
  end
  return false
end

local function hasChanged(value, oldValue)
  return value ~= oldValue and (value == value or oldValue == oldValue)
end

local function extend(to, _from)
  for key, value in pairs(_from) do
    to[key] = value
  end
  return to
end

local function NOOP()
end

local EMPTY_OBJ = {}

local function array_includes(t, value)
  for i, v in ipairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

local function clone(self)
  local ret = {}
  for k, v in pairs(self) do
    ret[k] = v
  end
  return ret
end

local function deepcopy(o, seen)
  if "table" == type(o) then
    seen = seen or {}
    if seen[o] then
      return seen[o]
    end
    if _ENABLE_CTABLE then
      local _ = o._ctd
    end
    local mt = getmetatable(o)
    if not mt or rawget(mt, ReactiveFlags.IS_REACTIVE) then
      local no = {}
      seen[o] = no
      for k, v in pairs(o) do
        no[deepcopy(k, seen)] = deepcopy(v, seen)
      end
      return no
    end
  else
    return o
  end
end

local function traverse(value, seen)
  if nil == seen then
    seen = {}
  end
  if not isObject(value) or seen[value] then
    return value
  end
  seen[value] = true
  for key in pairs(value) do
    traverse(value[key], seen)
  end
  return value
end

local function deepset(target, source)
  local ot = type(target)
  local nt = type(source)
  if "table" == ot and ot == nt then
    for k, v in pairs(target) do
      local newv = source[k]
      if nil ~= newv then
        target[k] = deepset(v, newv)
      else
        target[k] = nil
      end
    end
    for k, v in pairs(source) do
      local oldv = target[k]
      if nil == oldv then
        target[k] = v
      end
    end
    return target
  else
    return source
  end
end

local function deepmerge(target, source)
  local ot = type(target)
  local nt = type(source)
  if "table" == ot and ot == nt then
    for k, v in pairs(target) do
      local newv = source[k]
      if nil ~= newv then
        target[k] = deepmerge(v, newv)
      end
    end
    for k, v in pairs(source) do
      local oldv = target[k]
      if nil == oldv then
        target[k] = v
      end
    end
    return target
  else
    return source
  end
end

local reactiveUtils = {
  isObject = isObject,
  isFunction = isFunction,
  isCallable = isCallable,
  hasChanged = hasChanged,
  extend = extend,
  error = Logger.Error,
  warn = Logger.Warn,
  NOOP = NOOP,
  EMPTY_OBJ = EMPTY_OBJ,
  array_includes = array_includes,
  deepcopy = deepcopy,
  deepset = deepset,
  deepmerge = deepmerge,
  traverse = traverse,
  clone = clone
}

function reactiveUtils.traceback(msg)
  reactiveUtils.error(ltraceback(msg))
end

function reactiveUtils.callWithErrorHandling(fn, instance, type, ...)
  local result, ret = xpcall(fn, function(err)
    reactiveUtils.error(ltraceback(err, instance, type))
  end, instance, ...)
  return ret
end

function reactiveUtils.callWithAsyncErrorHandling(fn, instance, type, ...)
  if isCallable(fn) then
    local res = reactiveUtils.callWithErrorHandling(fn, instance, type, ...)
    return res
  end
  local values = {}
  for i = 1, #fn do
    tinsert(values, reactiveUtils.callWithAsyncErrorHandling(fn[i], instance, type, ...))
  end
  return values
end

local uid = 0

function reactiveUtils.genId()
  uid = uid + 1
  return uid
end

function reactiveUtils.getMtDepsMap(target)
  local depsMap = rawget(target, ReactiveFlags.DEPSMAP)
  if not depsMap then
    depsMap = {}
    rawset(target, ReactiveFlags.DEPSMAP, depsMap)
  end
  return depsMap
end

local ITERATE_KEY = "iterate"
local weakMt = {__mode = "k"}

function reactiveUtils.setTargetHook(target, hook)
  local oldHook = rawget(target, ReactiveFlags.HOOK)
  if oldHook == hook then
    return false
  end
  if nil ~= oldHook and oldHook ~= hook then
    error("hook is exists")
    return false
  end
  local hookEffect = {
    id = reactiveUtils.genId(),
    __call = function(_, ...)
      do return hook, ... end
      return hook, ...
    end,
    hook = hook,
    options = EMPTY_OBJ
  }
  setmetatable(hookEffect, hookEffect)
  local depsMap = reactiveUtils.getMtDepsMap(target)
  local dep = depsMap[ITERATE_KEY]
  if not dep then
    dep = {}
    setmetatable(dep, weakMt)
    depsMap[ITERATE_KEY] = dep
  end
  dep[hookEffect] = true
  rawset(target, ReactiveFlags.HOOK, hook)
  rawset(target, ReactiveFlags.HOOK_EFFECT, hookEffect)
  return true
end

function reactiveUtils.removeTargetHook(target)
  local hookEffect = rawget(target, ReactiveFlags.HOOK_EFFECT)
  if nil == hookEffect then
    return false
  end
  rawset(target, ReactiveFlags.HOOK, nil)
  rawset(target, ReactiveFlags.HOOK_EFFECT, nil)
  hookEffect.hook = NOOP
  local depsMap = rawget(target, ReactiveFlags.DEPSMAP)
  if depsMap then
    local dep = depsMap[ITERATE_KEY]
    if dep then
      dep[hookEffect] = nil
    end
  end
  return true
end

return reactiveUtils
