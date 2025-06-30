-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/dialogueend/dialogueendtriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local DialogueEndTriggerController = class("DialogueEndTriggerController", TriggerControllerBase)
local DialogueEndTrigger = require("logic.scene.luaevent.trigger.basic.dialogueend.dialogueendtrigger")
DialogueEndTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DialogueEndTriggerController
  ((DialogueEndTriggerController.super).Ctor)(self, ...)
end

DialogueEndTriggerController.CreateTriggerInstance = function(self, id, eventid, dialogueid)
  -- function num : 0_1 , upvalues : DialogueEndTrigger
  return (DialogueEndTrigger.Create)("dialogueend", id, eventid, dialogueid)
end

DialogueEndTriggerController.OnDialogueEnd = function(self, id)
  -- function num : 0_2
  self:CheckImpl(nil, id)
end

return DialogueEndTriggerController

