local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local StartChatEffect = class("StartChatEffect", EffectBase)

function StartChatEffect:Ctor(chatId)
  self._chatId = chatId
end

function StartChatEffect:Run()
  if not self._callback then
    DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(self._chatId)
  end
end

function StartChatEffect:Then(callback)
  self._callback = callback
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("dialogueend", event:GetID(), self._chatId)
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    callback()
    self._callback = nil
  end)
  event:AddEffect(effect)
  EventManager.AddEvent(event)
end

return StartChatEffect
