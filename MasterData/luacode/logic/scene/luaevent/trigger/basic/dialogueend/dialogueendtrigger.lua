local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local DialogueEndTrigger = class("BattleEndTrigger", TriggerBase)

function DialogueEndTrigger:Ctor(type, id, eventid, dialogueid)
  DialogueEndTrigger.super.Ctor(self, type, id, eventid)
  self._dialogueid = dialogueid
end

function DialogueEndTrigger:OnCheck(id)
  return id == self._dialogueid or not self._dialogueid
end

function DialogueEndTrigger:Check(...)
  DialogueEndTrigger.super.Check(self, ...)
  self._active = false
end

return DialogueEndTrigger
