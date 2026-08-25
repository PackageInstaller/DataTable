local config = require("Vue.reactivity.config")
local Lang = require("Vue.util.Lang")
local Util = require("Vue.util.Util")
local warn = Util.warn
local __DEBUG__ = config.__DEBUG__
local xpcall = _ENV.xpcall
local next, pairs, ipairs, tinsert, tremove, getmetatable = next, pairs, ipairs, table.insert, table.remove, _ENV.getmetatable
local EventEmitter = Lang.class("EventEmitter")

function EventEmitter:constructor()
  self.callbacks = {}
  self.callbackStates = {}
  self.pending = 0
end

function EventEmitter:pushPending()
  self.pending = self.pending + 1
end

function EventEmitter:saveStatus(status)
  status.callbackcount = #self.callbacks
  for i, v in pairs(self.callbacks) do
    local debugSource = string.replace(tostring(self.callbackStates[v]), "\n", " \\n ")
    status[debugSource] = (status[debugSource] or 0) + 1
  end
  status.pending = self.pending
  return status
end

function EventEmitter:popPending()
  self.pending = self.pending - 1
  local callbackStates = self.callbackStates
  local callbacks = self.callbacks
  if 0 == self.pending and next(callbackStates) then
    for i = #callbacks, 1, -1 do
      local item = callbacks[i]
      if not callbackStates[item] then
        callbackStates[item] = nil
        tremove(callbacks, i)
      end
    end
  end
end

function EventEmitter:removeItem(cb)
  self.callbackStates[cb] = false
end

function EventEmitter:getCount()
  return #self.callbacks
end

function EventEmitter:on(cb)
  if self.callbackStates[cb] then
    return
  end
  self.callbackStates[cb] = true
  if __DEBUG__ then
    self.callbackStates[cb] = debug.raw_traceback(coroutine.running(), nil, 5)
  end
  tinsert(self.callbacks, cb)
end

function EventEmitter:once(cb)
  local function callback(...)
    self:off(callback)
    
    cb(...)
  end
  
  self:on(callback)
end

function EventEmitter:off(value)
  self:pushPending()
  self:removeItem(value)
  self:popPending()
end

function EventEmitter:clear()
  self:pushPending()
  for i = 1, #self.callbacks do
    local item = self.callbacks[i]
    self:removeItem(item)
  end
  self:popPending()
end

function EventEmitter:emit(...)
  self:pushPending()
  for i = 1, #self.callbacks do
    local cb = self.callbacks[i]
    if self.callbackStates[cb] then
      local status, value = xpcall(cb, function(msg)
        Util.error("error when emit:" .. msg .. " stack :" .. debug.traceback())
      end, ...)
    end
  end
  self:popPending()
end

return EventEmitter
