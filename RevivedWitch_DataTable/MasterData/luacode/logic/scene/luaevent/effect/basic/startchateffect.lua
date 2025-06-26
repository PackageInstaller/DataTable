-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/startchateffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local StartChatEffect = class("StartChatEffect", EffectBase)
StartChatEffect.Ctor = function(self, chatId)
  -- function num : 0_0
  self._chatId = chatId
end

StartChatEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if not self._callback then
    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(self._chatId)
  end
end

StartChatEffect.Then = function(self, callback)
  -- function num : 0_2 , upvalues : _ENV
  self._callback = callback
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("dialogueend", event:GetID(), self._chatId)
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : callback, self
    callback()
    self._callback = nil
  end
)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
end

return StartChatEffect

