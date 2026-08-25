local Util = require("Vue.util.Util")
local Lang = require("Vue.util.Lang")
local Reactive = require("Vue.reactivity.reactive")
local Effect = require("Vue.reactivity.effect")
local devtool = require("Vue.vuex.plugins.devtool")
local DispatchProxy = require("Vue.vuex.DispatchProxy")
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local traverse = reactiveUtils.traverse
local mergeObjects = Util.mergeObjects
local getNestedState = Util.getNestedState
local tableConcat = Util.tableConcat
local tinsert = table.insert
local tremove = table.remove
local type, ipairs, pairs = type, ipairs, _ENV.pairs
local Store = Lang.class("Store")
local _
local configSilent = false

function Store:constructor(rootModule, plugins, strict, hook)
  local state = rootModule.state or {}
  local mutations = rootModule.mutations or {}
  local modules = rootModule.modules or {}
  plugins = plugins or {}
  strict = strict or false
  self._dispatching = false
  self._mutations = mutations
  self._rootMutations = mutations
  self._modules = modules
  self._subscribers = {}
  local silent = configSilent
  configSilent = true
  self._vm = Reactive.reactive({state = state}, hook)
  configSilent = silent
  self:_setupModuleState(state, modules)
  self:_setupModuleMutations(modules)
  if strict then
    self:_setupMutationCheck()
  else
    function self.unsafeMutate(fn)
      fn()
    end
  end
  devtool.devtoolPlugin(self)
  for i, plugin in ipairs(plugins) do
    plugin(self)
  end
end

function Store:createDispatchProxy(mutations)
  do return DispatchProxy.new, self end
  return DispatchProxy.new, self, mutations
end

function Store:getState()
  return self._vm.state
end

function Store:setState(v)
  error("[vuex] Use store.replaceState() to explicit replace store state.")
end

function Store:replaceState(state)
  self._dispatching = true
  self._vm.state = state
  self._dispatching = false
end

local function patchTable(target, new)
  local ot = type(target)
  local nt = type(new)
  if "table" == ot and ot == nt then
    for k, v in pairs(target) do
      local newv = new[k]
      if nil ~= newv then
        target[k] = patchTable(v, newv)
      else
        target[k] = nil
      end
    end
    for k, v in pairs(new) do
      local oldv = target[k]
      if nil == oldv then
        target[k] = v
      end
    end
    return target
  else
    return new
  end
end

function Store:patchState(state)
  self._dispatching = true
  self._vm.state = patchTable(self._vm.state, state)
  self._dispatching = false
end

function Store:dispatch(mutationName, ...)
  local payload = {
    ...
  }
  local silent = configSilent
  local handler = self._mutations[mutationName]
  local state = self._vm.state
  if handler then
    if not silent then
      for i, sub in ipairs(self._subscribers) do
        sub(mutationName, payload, state)
      end
    end
    self._dispatching = true
    if "table" == type(handler) then
      for i, h in ipairs(handler) do
        h(state, ...)
      end
    else
      handler(state, ...)
    end
    self._dispatching = false
  else
    error(string.format("[vuex] Unknown mutation: %s", mutationName))
  end
end

function Store:subscribe(fn)
  local subs = self._subscribers
  if 0 == Util.indexOf(subs, fn) then
    tinsert(subs, fn)
  end
  return function()
    local i = Util.indexOf(subs, fn)
    if i > 0 then
      tremove(subs, i)
    end
  end
end

function Store:hotUpdate(mutations, modules)
  self._mutations = mutations or self._rootMutations
  self._rootMutations = self._mutations
  self:_setupModuleMutations(modules or self._modules)
end

function Store:_setupModuleState(state, modules)
  if not Util.isObject(modules) then
    return
  end
  for key, module in pairs(modules) do
    state[key] = module.state or {}
    self:_setupModuleState(state[key], module.modules)
  end
end

function Store:_setupModuleMutations(updatedModules)
  local modules = self._modules
  for key, module in pairs(updatedModules) do
    modules[key] = module
  end
  local updatedMutations = self:_createModuleMutations(modules, {})
  self._mutations = mergeObjects({
    self._rootMutations,
    updatedMutations
  })
end

function Store:_createModuleMutations(modules, nestedKeys)
  if not Util.isObject(modules) then
    return {}
  end
  local mutations = {}
  for key, module in pairs(modules) do
    local newNestedKeys = tableConcat(nestedKeys, {key})
    local nestedMutations = self:_createModuleMutations(module.modules, newNestedKeys)
    if not module or not module.mutations then
      return mergeObjects(nestedMutations)
    end
    for name, original in pairs(module.mutations) do
      mutations[name] = function(state, ...)
        original(getNestedState(state, newNestedKeys), ...)
      end
    end
    mutations = mergeObjects({mutations, nestedMutations})
  end
  return mutations
end

function Store:_setupMutationCheck()
  self.mutationWatcher = Effect.effect(function()
    local vm = self._vm
    traverse(vm.state)
    if not self._dispatching then
      error("[vuex] Do not mutate vuex store state outside mutation handlers.")
    end
  end)
end

return Store
