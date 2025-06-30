-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/counter/countertriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local CounterTriggerController = class("CounterTriggerController", TriggerControllerBase)
local CounterTrigger = require("logic.scene.luaevent.trigger.basic.counter.countertrigger")
CounterTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CounterTriggerController
  ((CounterTriggerController.super).Ctor)(self, ...)
end

CounterTriggerController.CreateTriggerInstance = function(self, id, eventid, tag, value)
  -- function num : 0_1 , upvalues : CounterTrigger
  return (CounterTrigger.Create)("counter", id, eventid, tag, value)
end

CounterTriggerController.OnCounterChange = function(self, tag, value)
  -- function num : 0_2 , upvalues : _ENV
  if not (self._triggers)[tag] then
    print(tag, value, (debug.traceback)())
    return 
  end
  for _,trigger in pairs((self._triggers)[tag]) do
    trigger:Check(tag, value)
  end
end

CounterTriggerController.AddTrigger = function(self, trigger, period)
  -- function num : 0_3 , upvalues : _ENV
  local tag = trigger:GetTag()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if not (self._triggers)[tag] then
    (self._triggers)[tag] = {}
    ;
    (table.insert)((self._triggers)[tag], trigger)
    print("counter trigger added", tag)
  end
end

CounterTriggerController.RemoveTrigger = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  local found = false
  for tag,v in pairs(self._triggers) do
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
            (self._triggers)[tag] = nil
          end
          return true
        end
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return false
end

CounterTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_5 , upvalues : _ENV
  trigger:Check(trigger:GetTag(), ((NekoData.BehaviorManager).BM_Counter):GetCounterValue(trigger:GetTag()))
end

CounterTriggerController.GetTrigger = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in pairs(self._triggers) do
    for _,vv in pairs(v) do
      if vv:GetID() == id then
        return vv
      end
    end
  end
end

return CounterTriggerController

