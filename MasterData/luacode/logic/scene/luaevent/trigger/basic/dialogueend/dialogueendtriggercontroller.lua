local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local DialogueEndTriggerController = class("DialogueEndTriggerController", TriggerControllerBase)
local DialogueEndTrigger = require("logic.scene.luaevent.trigger.basic.dialogueend.dialogueendtrigger")

function DialogueEndTriggerController:Ctor(...)
  DialogueEndTriggerController.super.Ctor(self, ...)
end

function DialogueEndTriggerController:CreateTriggerInstance(id, eventid, dialogueid)
  return DialogueEndTrigger.Create("dialogueend", id, eventid, dialogueid)
end

function DialogueEndTriggerController:OnDialogueEnd(id)
  self:CheckImpl(nil, id)
end

return DialogueEndTriggerController
