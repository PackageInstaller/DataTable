local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local PreTaskTrigger = require("logic.scene.luaevent.trigger.basic.pretask.pretasktrigger")
local PreTaskTriggerController = class("PreTaskTriggerController", TriggerControllerBase)

function PreTaskTriggerController:Ctor(...)
  PreTaskTriggerController.super.Ctor(self, ...)
end

function PreTaskTriggerController:CreateTriggerInstance(id, eventid, taskid)
  return PreTaskTrigger.Create(id, eventid, taskid)
end

function PreTaskTriggerController:OnTriggerAdd(trigger)
  local choice = NekoData.BehaviorManager.BM_Task:GetTaskChoice()
  trigger:Check(choice)
end

function PreTaskTriggerController:OnChooseOption(id, option)
  local choice = NekoData.BehaviorManager.BM_Task:GetTaskChoice()
  for i, trigger in ipairs(self._triggers[id]) do
    trigger:Check(choice, id, option)
  end
end

return PreTaskTriggerController
