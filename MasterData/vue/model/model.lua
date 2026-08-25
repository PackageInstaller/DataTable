local Lang = require("Vue.util.Lang")
local Reactive = require("Vue.reactivity.reactive")
local next, rawget, rawset, type, ipairs, pairs, tinsert, xpcall, getmetatable, setmetatable, sformat, tostring = next, rawget, rawset, type, ipairs, pairs, table.insert, xpcall, getmetatable, setmetatable, string.format, _ENV.tostring
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local isObject, hasChanged, extend, NOOP, EMPTY_OBJ, isFunction, traceback = reactiveUtils.isObject, reactiveUtils.hasChanged, reactiveUtils.extend, reactiveUtils.NOOP, reactiveUtils.EMPTY_OBJ, reactiveUtils.isFunction, reactiveUtils.traceback
local createStateAction, createStateView = Reactive.createStateAction, Reactive.createStateView
local VueModel, Super = Lang.class("VueModel")

function VueModel:constructor(stateName, stateFunction)
  self.stateName = stateName
  self.stateFunction = stateFunction
end

function VueModel:views(fn)
  if not self.viewFunctions then
    self.viewFunctions = {}
  end
  tinsert(self.viewFunctions, fn)
  return self
end

function VueModel:actions(fn)
  if not self.actionFunctions then
    self.actionFunctions = {}
  end
  tinsert(self.actionFunctions, fn)
  return self
end

function VueModel:setup(fn)
  self.setup = createStateAction(fn)
  return self
end

function VueModel:create(...)
  local state = self.stateFunction(...)
  if "table" ~= type(state) or nil ~= getmetatable(state) then
    reactiveUtils.warn("VueModel必须传入raw table或VueModel实例, stateName:" .. self.stateName)
    return
  end
  local instance = Reactive.modelState(state)
  rawset(instance, "__model", self)
  if self.viewFunctions then
    for i, v in ipairs(self.viewFunctions) do
      local viewsInstance = v(instance)
      for ii, vv in pairs(viewsInstance) do
        rawset(instance, ii, createStateView(vv))
      end
    end
  end
  if self.actionFunctions then
    for i, v in ipairs(self.actionFunctions) do
      local viewsInstance = v(instance)
      for ii, vv in pairs(viewsInstance) do
        rawset(instance, ii, createStateAction(vv))
      end
    end
  end
  return instance
end

return VueModel
