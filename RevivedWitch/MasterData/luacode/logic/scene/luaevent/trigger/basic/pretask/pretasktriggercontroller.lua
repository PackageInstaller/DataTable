-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/pretask/pretasktriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local PreTaskTrigger = require("logic.scene.luaevent.trigger.basic.pretask.pretasktrigger")
local PreTaskTriggerController = class("PreTaskTriggerController", TriggerControllerBase)
PreTaskTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PreTaskTriggerController
  ((PreTaskTriggerController.super).Ctor)(self, ...)
end

PreTaskTriggerController.CreateTriggerInstance = function(self, id, eventid, taskid)
  -- function num : 0_1 , upvalues : PreTaskTrigger
  return (PreTaskTrigger.Create)(id, eventid, taskid)
end

PreTaskTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_2 , upvalues : _ENV
  local choice = ((NekoData.BehaviorManager).BM_Task):GetTaskChoice()
  trigger:Check(choice)
end

PreTaskTriggerController.OnChooseOption = function(self, id, option)
  -- function num : 0_3 , upvalues : _ENV
  local choice = ((NekoData.BehaviorManager).BM_Task):GetTaskChoice()
  for i,trigger in ipairs((self._triggers)[id]) do
    trigger:Check(choice, id, option)
  end
end

return PreTaskTriggerController

