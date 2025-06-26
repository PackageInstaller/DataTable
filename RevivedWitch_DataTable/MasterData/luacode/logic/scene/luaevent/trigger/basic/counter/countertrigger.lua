-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/counter/countertrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local CounterTrigger = class("CounterTrigger", TriggerBase)
CounterTrigger.Ctor = function(self, type, id, eventid, tag, value)
  -- function num : 0_0 , upvalues : CounterTrigger
  ((CounterTrigger.super).Ctor)(self, type, id, eventid)
  self._tag = tag
  self._value = value
end

CounterTrigger.OnCheck = function(self, tag, value)
  -- function num : 0_1
  do return self._tag == tag and self._value == value end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CounterTrigger.GetTag = function(self)
  -- function num : 0_2
  return self._tag
end

CounterTrigger.GetValue = function(self)
  -- function num : 0_3
  return self._value
end

return CounterTrigger

