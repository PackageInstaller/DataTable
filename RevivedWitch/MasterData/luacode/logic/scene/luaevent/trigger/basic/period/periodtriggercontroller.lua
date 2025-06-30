-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/period/periodtriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local PeriodTrigger = require("logic.scene.luaevent.trigger.basic.period.periodtrigger")
local PeriodTriggerController = class("PeriodTriggerController", TriggerControllerBase)
PeriodTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PeriodTriggerController
  ((PeriodTriggerController.super).Ctor)(self, ...)
end

PeriodTriggerController.CreateTriggerInstance = function(self, id, eventid, stratTime, endTime)
  -- function num : 0_1 , upvalues : PeriodTrigger
  return (PeriodTrigger.Create)("period", id, eventid, stratTime, endTime)
end

PeriodTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_2 , upvalues : _ENV
  local serverTime = (ServerGameTimer.GetServerTime)()
  local stime = (os.date)("*t", serverTime // 1000)
  trigger:Check(stime)
end

PeriodTriggerController.OnPeriodArrival = function(self, currentTime)
  -- function num : 0_3 , upvalues : _ENV
  for _,trigger in pairs(self._triggers) do
    trigger:Check(currentTime)
  end
end

return PeriodTriggerController

