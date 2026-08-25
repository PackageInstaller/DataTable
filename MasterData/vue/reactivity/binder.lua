local Lang = require("Vue.util.Lang")
local Util = require("Vue.util.Util")
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local EventEmitter = require("Vue.util.EventEmitter")
local newEventEmitter = EventEmitter.new
local config = require("Vue.reactivity.config")
local __DEBUG__ = config.__DEBUG__
local __PROFILER__ = config.__PROFILER__
local __DEV__ = config.__DEV__
local EMPTY_OBJ = reactiveUtils.EMPTY_OBJ
local Reactive = require("Vue.reactivity.reactive")
local Scheduler = require("Vue.reactivity.scheduler")
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local ITERATE = TrackOpTypes.ITERATE
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local SET, ADD, DELETE = TriggerOpTypes.SET, TriggerOpTypes.ADD, TriggerOpTypes.DELETE
local queueJob, invalidateJob, queuePostFlushCb = Scheduler.queueJob, Scheduler.invalidateJob, Scheduler.queuePostFlushCb
local Effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY, effect, stop, pauseTracking, resetTracking, E_DESTROYED = Effect.track, Effect.trigger, Effect.ITERATE_KEY, Effect.effect, Effect.stop, Effect.pauseTracking, Effect.resetTracking, Effect.E_DESTROYED
local reactive = Reactive.reactive
local createGetter, createSetter = Lang.createGetter, Lang.createSetter
local type = _ENV.type
local tostring = _ENV.tostring
local xpcall = _ENV.xpcall
local array_includes = Util.array_includes
local tinsert, tpop, setmetatable, pairs, coroutine, assert, tunpack, rawget, next = table.insert, table.remove, setmetatable, pairs, coroutine, assert, table.unpack, rawget, _ENV.next
local binderStack = {}
local Binder, Super = Lang.class("Binder")

local function CreateGetSourceFunction(source, self)
  local sourceType = type(source)
  if "string" == sourceType then
    assert(self.parent)
    local parentSourceFunction = CreateGetSourceFunction(self.parent.source, self.parent)
    do return createGetter, source end
    return createGetter, source, parentSourceFunction
  elseif nil == source and self.parent ~= nil then
    return self.parent.source
  elseif "table" == sourceType then
    do return reactive end
    return reactive, source, source, parentSourceFunction
  else
    return source
  end
end

function Binder:constructor(source, parent)
  self.parent = parent
  self.source = CreateGetSourceFunction(source, self)
end

local HookIds = {destroy = 1, errorCaptured = 2}
Binder.HookIds = HookIds
local HookIdToName = {}
for i, v in pairs(HookIds) do
  HookIdToName[v] = i
end
local target
local targetStack = {}

local function pushContext(context)
  tinsert(targetStack, context)
  target = context
end

local function popContext()
  tpop(targetStack)
  target = targetStack[#targetStack]
end

function Binder:emit(eventName, ...)
  local eventEmitter = rawget(self, eventName)
  if not eventEmitter then
    return
  end
  eventEmitter:emit(...)
end

function Binder:on(eventName, cb)
  if __DEV__ and array_includes(binderStack, self) then
    reactiveUtils.warn("不要在binder绑定过程中嵌套重复绑定")
  end
  local eventEmitter = rawget(self, eventName)
  if not eventEmitter then
    eventEmitter = newEventEmitter()
    rawset(self, eventName, eventEmitter)
  end
  eventEmitter:on(cb)
end

function Binder:off(eventName, cb)
  local eventEmitter = rawget(self, eventName)
  if eventEmitter then
    eventEmitter:off(cb)
  end
end

function Binder:once(eventName, cb)
  if __DEV__ and array_includes(binderStack, self) then
    reactiveUtils.warn("不要在binder绑定过程中嵌套重复绑定")
  end
  local eventEmitter = rawget(self, eventName)
  if not eventEmitter then
    eventEmitter = newEventEmitter()
    rawset(self, eventName, eventEmitter)
  end
  eventEmitter:once(cb)
end

function Binder:bindEvent(targetBinder, event, cb)
  targetBinder:on(event, cb)
  self:onDestroy(function()
    targetBinder:off(event, cb)
  end)
end

local function checkDestroyed(self)
  reactiveUtils.error("binder已销毁，不允许继续使用，如确有需要继续使用，请使用clearChildren代替teardown，否则会造成内存泄露: ", debug.traceback())
end

function Binder:getName()
  return self.name or self.debugSource or tostring(self)
end

function Binder:saveStatus(status)
  status.events = {}
  for i, v in pairs(self) do
    if getmetatable(v) == EventEmitter then
      local name = HookIdToName[i] or i
      status.events[name] = v:saveStatus({})
    end
  end
  if self.__children then
    for i, v in pairs(self.__children) do
      status[i:getName()] = i:saveStatus({})
    end
  end
  return status
end

function Binder:teardown()
  if self.__isTeardown then
    return
  end
  self.__isTeardown = true
  self:clearChildren()
  if self.parent then
    if __PROFILER__ and self.parent.__children then
      self.parent.__children[self] = nil
      if not next(self.parent.__children) then
        self.parent.__children = nil
      end
    end
    self.parent:off(HookIds.destroy, self.__onDestroy)
    self.parent = nil
    self.__onDestroy = nil
  end
  self.onDestroy = checkDestroyed
  self.offDestroy = checkDestroyed
  self.emit = checkDestroyed
end

function Binder:isDestroyed()
  return self.onDestroy == checkDestroyed
end

function Binder:clearChildren()
  if self.__isClearingChildren then
    return
  end
  self.__isClearingChildren = true
  local eventEmitter = rawget(self, HookIds.destroy)
  if eventEmitter then
    rawset(self, HookIds.destroy, nil)
    eventEmitter:emit()
  end
  self.__isClearingChildren = nil
end

local mt__mode__kv = {__mode = "kv"}

function Binder:createChild(source, sourceStackLevel)
  if __DEV__ and array_includes(binderStack, self) then
    reactiveUtils.warn("不要在binder绑定过程中嵌套创建子元素")
  end
  local child = Binder.new(source, self)
  if __DEV__ then
    local info = debug.getinfo(sourceStackLevel or 2, "Sl")
    child.debugSource = string.format("(%s:%s)", info.source, info.currentline)
  end
  if __PROFILER__ then
    if not self.__children then
      self.__children = {}
    end
    self.__children[child] = child
  end
  
  local function onDestroy()
    child:teardown()
  end
  
  child.__onDestroy = onDestroy
  self:onDestroy(onDestroy)
  return child
end

function Binder:onDestroy(cb)
  self:on(HookIds.destroy, cb)
end

function Binder:offDestroy(cb)
  self:off(HookIds.destroy, cb)
end

function Binder:onErrorCaptured(cb)
  self:on(HookIds.errorCaptured, cb)
end

function Binder:createGetter(expOrFn)
  local getter
  if "function" == type(expOrFn) then
    function getter()
      do return expOrFn end
      
      return expOrFn, self.source
    end
  else
    getter = createGetter(expOrFn, self.source)
    print(debug.traceback("cannot use string property to bind"))
  end
  return getter
end

function Binder:newFunction(fn, source, sync)
  local parent
  if self then
    parent = self
  else
    parent = Binder.new()
  end
  local binder = parent:createChild(source)
  local runner
  local jobs = {}
  
  local function apply(self)
    jobs[self] = nil
    if rawget(runner, E_DESTROYED) then
      return
    end
    for i, v in pairs(jobs) do
      invalidateJob(i)
      jobs[i] = nil
    end
    do return end
    return runner, pairs(jobs)
  end
  
  local options = {}
  if sync then
    function options.scheduler(...)
      apply({
        ...
      })
    end
  else
    function options.scheduler(...)
      local jobNewFunction = setmetatable({
        id = runner.id,
        
        ...
      }, {__call = apply})
      jobs[jobNewFunction] = jobNewFunction
      queueJob(jobNewFunction)
    end
  end
  runner = effect(function()
    binder:clearChildren()
    pushContext(binder)
    local status, value = xpcall(fn, function(msg)
      binder:emit(HookIds.errorCaptured, msg)
      reactiveUtils.error("error when new:" .. msg .. " stack :" .. debug.traceback())
    end, binder)
    popContext(binder)
  end, options)
  parent:onDestroy(function()
    stop(runner)
  end)
  return binder
end

function Binder:watch(expOrFn, cb, immediate, sync)
  if __DEV__ then
    if array_includes(binderStack, self) then
      reactiveUtils.warn("不要在binder绑定过程中嵌套重复绑定")
    end
    tinsert(binderStack, self)
  end
  local getter = self:createGetter(expOrFn)
  local value, runner
  
  local function apply()
    if rawget(runner, E_DESTROYED) then
      return
    end
    local newValue = runner()
    if value ~= newValue then
      local oldValue = value
      value = newValue
      xpcall(cb, function(msg)
        reactiveUtils.error("error when first watch callback:" .. debug.traceback(coroutine.running(), msg))
      end, self, value, oldValue)
    end
  end
  
  local jobWatch
  local options = {lazy = true}
  if sync then
    function options.scheduler(...)
      apply()
    end
  else
    function options.scheduler(...)
      queueJob(jobWatch)
    end
  end
  runner = effect(getter, options)
  jobWatch = setmetatable({
    id = runner.id
  }, {__call = apply})
  if immediate then
    value = runner()
    cb(self, value, nil)
  else
    value = runner()
  end
  if __DEV__ then
    tpop(binderStack)
  end
  self:onDestroy(function()
    stop(runner)
  end)
end

Binder.Watch = Binder.watch
Binder.CreateChild = Binder.createChild
Binder.Unbind = Binder.teardown

function Binder:BindToRaw(onValueChange, bintTo, sync)
  local ownBinder = self:createChild(nil, 3)
  
  local function onChange(_, ...)
    ownBinder:clearChildren()
    do return onValueChange, ownBinder, ... end
    return onValueChange, ownBinder, ...
  end
  
  do return self.SimpleBindToRaw, self, onChange, bintTo end
  return self.SimpleBindToRaw, self, onChange, bintTo, sync
end

function Binder:SimpleBindToRaw(onValueChange, bintTo, sync)
  if __DEV__ then
    local onChange = onValueChange
    
    function onValueChange(binder, ...)
      do return onChange, binder, ... end
      return onChange, binder, ...
    end
  end
  do return self.Watch, self, bintTo, onValueChange, true end
  return self.Watch, self, bintTo, onValueChange, true, sync
end

Binder.BindToRawEx = Binder.BindToRaw
Binder.ReactiveFunction = Binder.newFunction

function Binder:BindToProperty(owner, fnSetterName, bindTo)
  local fnSetter = owner["set_" .. fnSetterName]
  if "function" ~= type(fnSetter) then
    error("找不到属性函数：" .. fnSetterName)
  end
  self:SimpleBindToRaw(function(data, v, o)
    fnSetter(owner, v)
  end, bindTo)
end

function Binder:BindToRawProperty(owner, propertyName, bindTo)
  self:SimpleBindToRaw(function(data, v, o)
    owner[propertyName] = v
  end, bindTo)
end

function Binder:BindFrom(setOnValueChange, bindTo)
  assert(bindTo, "invalid BindFrom:" .. tostring(bindTo))
  local set = createSetter(bindTo, self.source)
  setOnValueChange(function(value)
    set(value)
  end)
  self:onDestroy(function()
    setOnValueChange(nil)
  end)
end

function Binder:BindAction(setOnAction, action)
  setOnAction(action)
  self:onDestroy(function()
    setOnAction(nil)
  end)
end

function Binder:BindCallback(onBind, onUnbind)
  self:onDestroy(function()
    onUnbind()
  end)
  do return end
  return onBind, self, function()
    onUnbind()
  end
end

function Binder:BindEvent(event, callback)
  self:BindAction(function(onAction)
    if onAction then
      event:RegisterEvent(callback)
    else
      event:RemoveEvent(callback)
    end
  end, callback)
end

function Binder:BindConditionEvent(event, callback, expOrFn)
  local binded = false
  self:onDestroy(function()
    if binded then
      event:RemoveEvent(callback)
      binded = false
    end
  end)
  self:SimpleBindToRaw(function(binder, value, old)
    if value then
      event:RegisterEvent(callback)
    elseif binded then
      event:RemoveEvent(callback)
    end
    binded = value
  end, expOrFn)
end

function Binder:BindOnceEvent(event, callback)
  local onceCallback
  
  function onceCallback(...)
    if onceCallback then
      event:RemoveEvent(onceCallback)
      onceCallback = nil
    end
    callback(...)
  end
  
  self:BindCallback(function()
    event:RegisterEvent(onceCallback)
  end, function()
    if onceCallback then
      event:RemoveEvent(onceCallback)
      onceCallback = nil
    end
  end)
end

function Binder:BindSet(expOrFn, fnUpdate, sync)
  local refs = {}
  do return self.BindRawTable, self, expOrFn, function(valueBinder, value, old)
    if old and refs[old] then
      refs[old] = refs[old] - 1
      if refs[old] <= 0 then
        refs[old] = nil
        fnUpdate(valueBinder, nil, old)
      end
    end
    if value then
      if not refs[value] then
        refs[value] = 1
        fnUpdate(valueBinder, value, nil)
      else
        refs[value] = refs[value] + 1
      end
    end
  end end
  return self.BindRawTable, self, expOrFn, function(valueBinder, value, old)
    if old and refs[old] then
      refs[old] = refs[old] - 1
      if refs[old] <= 0 then
        refs[old] = nil
        fnUpdate(valueBinder, nil, old)
      end
    end
    if value then
      if not refs[value] then
        refs[value] = 1
        fnUpdate(valueBinder, value, nil)
      else
        refs[value] = refs[value] + 1
      end
    end
  end, sync
end

function Binder:BindRawTable(expOrFn, fnUpdate, sync, finishCall)
  local ownerBinder = self:createChild(nil, 3)
  local IBINDER = 1
  local IVALUE = 2
  local oldChildren
  local newChildren = {}
  
  local function cb(...)
    xpcall(fnUpdate, function(msg)
      reactiveUtils.error("BindRawTable error: " .. debug.traceback(msg))
    end, ...)
  end
  
  local function finishCb(...)
    if finishCall then
      xpcall(finishCall, function(msg)
        reactiveUtils.error("BindRawTable finishCall error: " .. debug.traceback(msg))
      end, ...)
    end
  end
  
  local function rebind(newList)
    oldChildren = newChildren
    newChildren = {}
    for i, v in pairs(newList) do
      local oldValue = oldChildren[i]
      if oldValue then
        if oldValue[IVALUE] ~= v then
          local valueBinder = oldValue[IBINDER]
          valueBinder:clearChildren()
          newChildren[i] = oldValue
          local old = oldValue[IVALUE]
          oldValue[IVALUE] = v
          cb(valueBinder, v, old, i)
        else
          newChildren[i] = oldValue
        end
      else
        local valueBinder = ownerBinder:createChild(v)
        newChildren[i] = {valueBinder, v}
        cb(valueBinder, v, nil, i)
      end
    end
    local resetNil = false
    if (nil == newList or #newList <= 0) and finishCall then
      resetNil = true
    end
    for i, oldValue in pairs(oldChildren) do
      local newValue = newList[i]
      if nil == newValue then
        local valueBinder = oldValue[IBINDER]
        valueBinder:teardown()
        if not resetNil then
          cb(nil, nil, oldValue[IVALUE], i)
        end
      end
    end
    finishCb(resetNil)
  end
  
  local value, runner
  local jobs = {}
  
  local function apply(self)
    jobs[self] = nil
    if rawget(runner, E_DESTROYED) then
      return
    end
    local newValue = runner()
    if value ~= newValue then
      value = newValue
      for i, v in pairs(jobs) do
        invalidateJob(i)
        jobs[i] = nil
      end
      rebind(value or EMPTY_OBJ)
    else
      local effect, target, type, key, newValue, oldValue = tunpack(self)
      if type == ADD then
        local valueBinder = ownerBinder:createChild(newValue)
        newChildren[key] = {valueBinder, newValue}
        cb(valueBinder, newValue, nil, key, value)
      elseif type == DELETE then
        local oldItem = newChildren[key]
        if oldItem then
          local valueBinder = oldItem[IBINDER]
          valueBinder:teardown()
          newChildren[key] = nil
          cb(nil, nil, oldItem[IVALUE], key, value)
        end
      elseif type == SET then
        local oldItem = newChildren[key]
        if oldItem then
          local valueBinder = oldItem[IBINDER]
          valueBinder:clearChildren()
          oldItem[IVALUE] = newValue
          cb(valueBinder, newValue, oldValue, key, value)
        end
      end
      finishCb()
    end
  end
  
  local getter = self:createGetter(expOrFn)
  
  local function reactiveFunc()
    local tableValue = getter(self)
    if "table" == type(tableValue) then
      tableValue = Reactive.reactive(tableValue)
      track(tableValue, ITERATE, ITERATE_KEY)
    end
    return tableValue
  end
  
  local options = {lazy = true}
  if sync then
    function options.scheduler(...)
      apply({
        ...
      })
    end
  else
    function options.scheduler(...)
      local jobRawTable = setmetatable({
        id = runner.id,
        
        ...
      }, {__call = apply})
      jobs[jobRawTable] = jobRawTable
      queueJob(jobRawTable)
    end
  end
  runner = effect(reactiveFunc, options)
  apply(EMPTY_OBJ)
  self:onDestroy(function()
    stop(runner)
  end)
  return function()
    ownerBinder:teardown()
  end
end

function Binder:BindComponent(component, sourceStackLevel)
  local binder = self:createChild(component, sourceStackLevel or 3)
  component:Setup(binder)
  return binder
end

function Binder.apiNewBinder(source, name)
  local binder = target and target:createChild(source) or Binder.new(source)
  if __DEV__ then
    local info = debug.getinfo(2, "Sl")
    binder.debugSource = string.format("(%s:%s)", info.source, info.currentline)
  end
  return binder
end

function Binder.apiNew(fn)
  do return Binder.newFunction, target end
  return Binder.newFunction, target, fn
end

function Binder:createModel(Model, ...)
  local model = Model:create(...)
  local binder = self:createChild(model, 3)
  if Model.setup then
    Model.setup(binder, model)
  end
  return model
end

return Binder
