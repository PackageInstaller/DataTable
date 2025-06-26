-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/timer/timertriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local TimerTriggerController = class("TimerTriggerController", TriggerControllerBase)
local TimerTrigger = require("logic.scene.luaevent.trigger.basic.timer.timertrigger")
TimerTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TimerTriggerController
  ((TimerTriggerController.super).Ctor)(self, ...)
  self._currentTime = 0
end

TimerTriggerController.CreateTriggerInstance = function(self, id, eventid, delay, period)
  -- function num : 0_1 , upvalues : TimerTrigger
  return (TimerTrigger.Create)("timer", id, eventid, delay or 0, period or 0)
end

TimerTriggerController.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV
  self._currentTime = self._currentTime + deltaTime
  for time,v in pairs(self._triggers) do
    if time <= self._currentTime then
      for _,trigger in pairs(v) do
        trigger:Check()
        if trigger:GetPeriod() ~= 0 then
          self:AddTrigger(trigger, trigger:GetPeriod())
        end
      end
    end
    do
      do
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

        if v and (table.nums)(v) == 0 then
          (self._triggers)[time] = nil
        end
        -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

TimerTriggerController.AddTrigger = function(self, trigger, period)
  -- function num : 0_3 , upvalues : _ENV
  if not period then
    local delay = trigger:GetDelay()
  end
  if delay == 0 then
    trigger:Check()
    if trigger:GetPeriod() ~= 0 then
      delay = trigger:GetPeriod()
    else
      return 
    end
  end
  local time = delay + self._currentTime
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  if not (self._triggers)[time] then
    (self._triggers)[time] = {}
    ;
    (table.insert)((self._triggers)[time], trigger)
  end
end

TimerTriggerController.RemoveTrigger = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  local found = false
  for time,v in pairs(self._triggers) do
    for k,trigger in pairs(v) do
      if trigger:GetID() == id then
        v[k] = nil
        found = true
        break
      end
    end
    do
      do
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

        if found then
          if (table.nums)(v) == 0 then
            (self._triggers)[time] = nil
          end
          return true
        end
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return false
end

TimerTriggerController.GetTrigger = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in pairs(self._triggers) do
    for _,vv in pairs(v) do
      if vv:GetID() == id then
        return vv
      end
    end
  end
end

TimerTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_6
  if trigger:GetDelay() == 0 then
    trigger:Check()
  end
end

return TimerTriggerController

