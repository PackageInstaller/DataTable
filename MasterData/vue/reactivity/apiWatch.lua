local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local ErrorCodes = require("Vue.reactivity.ErrorCodes")
local Effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY, stop, effect = Effect.track, Effect.trigger, Effect.ITERATE_KEY, Effect.stop, Effect.effect
local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local getmetatable, type, ipairs, pairs, tinsert = getmetatable, type, ipairs, pairs, table.insert
local scheduler = require("Vue.reactivity.scheduler")
local queueJob, queuePostFlushCb = scheduler.queueJob, scheduler.queuePostFlushCb
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local isCallable, isObject, hasChanged, extend, callWithErrorHandling, callWithAsyncErrorHandling, NOOP, traverse = reactiveUtils.isCallable, reactiveUtils.isObject, reactiveUtils.hasChanged, reactiveUtils.extend, reactiveUtils.callWithErrorHandling, reactiveUtils.callWithAsyncErrorHandling, reactiveUtils.NOOP, reactiveUtils.traverse
local reactive = require("Vue.reactivity.reactive")
local ref = require("Vue.reactivity.ref")(reactive)
local isReactive = reactive.isReactive
local isRef = ref.isRef
local INITIAL_WATCHER_VALUE = {}

local function invoke(fn)
  fn()
end

local function doWatch(source, cb, options)
  local immediate, deep, flush, onTrack, onTrigger, instance
  if options then
    immediate, deep, flush, onTrack, onTrigger, instance = options.immediate, options.deep, options.flush, options.onTrack, options.onTrigger, options.instance
  end
  if __DEV__ and not cb then
    if nil ~= immediate then
      reactiveUtils.warn([[
`watch() "immediate" option is only respected when using the ` +
            `watch(source, callback, options?) signature.`]])
    end
    if nil ~= deep then
      reactiveUtils.warn([[
`watch() "deep" option is only respected when using the ` +
            `watch(source, callback, options?) signature.`]])
    end
  end
  
  local function warnInvalidSource(s)
    reactiveUtils.warn([[
`Invalid watch source: `,
      s,
      `A watch source can only be a getter/effect function, a ref, ` +
        `a reactive object, or an array of these types.`]])
  end
  
  local cleanup = NOOP
  local onInvalidate, runner, getter
  local multiSource = "table" == type(source) and nil == getmetatable(source)
  if multiSource then
    function getter()
      local result = {}
      
      for _, s in ipairs(source) do
        if isRef(s) then
          tinsert(result, s.value)
        elseif isReactive(s) then
          tinsert(result, traverse(s))
        elseif isCallable(s) then
          tinsert(result, callWithErrorHandling(s, instance, ErrorCodes.WATCH_GETTER))
        elseif __DEV__ then
          warnInvalidSource(s)
        end
      end
      return result
    end
  elseif isRef(source) then
    function getter()
      return source.value
    end
  elseif isCallable(source) then
    if cb then
      function getter()
        do return callWithErrorHandling, source, instance end
        
        return callWithErrorHandling, source, instance, ErrorCodes.WATCH_GETTER
      end
    else
      function getter()
        if instance and instance.isUnmounted then
          return
        end
        if cleanup then
          cleanup()
        end
        do return callWithErrorHandling, source, instance, ErrorCodes.WATCH_CALLBACK end
        return callWithErrorHandling, source, instance, ErrorCodes.WATCH_CALLBACK, onInvalidate
      end
    end
  elseif isReactive(source) then
    function getter()
      return source
    end
    
    deep = true
  else
    getter = NOOP
    if __DEV__ then
      warnInvalidSource(source)
    end
  end
  if cb and deep then
    local baseGetter = getter
    
    function getter()
      do return traverse, baseGetter() end
      return traverse, baseGetter()
    end
  end
  
  function onInvalidate(fn)
    rawset(runner, Effect.E_ON_STOP, function()
      callWithErrorHandling(fn, instance, ErrorCodes.WATCH_CLEANUP)
    end)
    cleanup = rawget(runner, Effect.E_ON_STOP)
  end
  
  local oldValue = multiSource and {} or INITIAL_WATCHER_VALUE
  local applyCb = cb and function()
    if instance and instance.isUnmounted then
      return
    end
    local newValue = runner()
    if deep or hasChanged(newValue, oldValue) then
      if cleanup then
        cleanup()
      end
      callWithAsyncErrorHandling(cb, instance, ErrorCodes.WATCH_CALLBACK, newValue, oldValue ~= INITIAL_WATCHER_VALUE and oldValue or nil, onInvalidate)
      oldValue = newValue
    end
  end or nil
  local scheduler
  if "sync" == flush then
    scheduler = invoke
  else
    function scheduler(job)
      queuePostFlushCb(job, instance and instance.suspense)
    end
  end
  runner = effect(getter, {
    lazy = true,
    computed = true,
    onTrack = onTrack,
    onTrigger = onTrigger,
    scheduler = applyCb and function()
      scheduler(applyCb)
    end or scheduler
  })
  if applyCb then
    if immediate then
      applyCb()
    else
      oldValue = runner()
    end
  else
    runner()
  end
  return function()
    stop(runner)
  end
end

local function watchEffect(effect, options)
  do return doWatch, effect, nil end
  return doWatch, effect, nil, options
end

local function watch(source, cb, options)
  if __DEV__ and not isCallable(cb) then
    reactiveUtils.warn([[
`\`watch(fn, options?)\` signature has been moved to a separate API. ` +
        `Use \`watchEffect(fn, options?)\` instead. \`watch\` now only ` +
        `supports \`watch(source, cb, options?) signature.`]])
  end
  do return doWatch, source, cb end
  return doWatch, source, cb, options
end

local function instanceWatch(this, source, cb, options)
  local publicThis = self.proxy
  local getter = "string" == type(source) and function()
    return publicThis[source]
  end or source:bind(publicThis)
  local stop = watch(getter, cb:bind(publicThis), options)
  onBeforeUnmount(stop, self)
  return stop
end

return {
  watch = watch,
  watchEffect = watchEffect,
  instanceWatch = instanceWatch
}
