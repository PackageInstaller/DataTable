-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/timer/timertrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local TimerTrigger = class("TimerTrigger", TriggerBase)
TimerTrigger.Ctor = function(self, type, id, eventid, delay, period)
  -- function num : 0_0 , upvalues : TimerTrigger, _ENV
  ((TimerTrigger.super).Ctor)(self, type, id, eventid)
  self._delay = tonumber(delay)
  self._period = tonumber(period)
end

TimerTrigger.OnCheck = function(self)
  -- function num : 0_1
  return true
end

TimerTrigger.GetDelay = function(self)
  -- function num : 0_2
  return self._delay
end

TimerTrigger.GetPeriod = function(self)
  -- function num : 0_3
  return self._period
end

return TimerTrigger

