-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/dialogueend/dialogueendtrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local DialogueEndTrigger = class("BattleEndTrigger", TriggerBase)
DialogueEndTrigger.Ctor = function(self, type, id, eventid, dialogueid)
  -- function num : 0_0 , upvalues : DialogueEndTrigger
  ((DialogueEndTrigger.super).Ctor)(self, type, id, eventid)
  self._dialogueid = dialogueid
end

DialogueEndTrigger.OnCheck = function(self, id)
  -- function num : 0_1
  do return id ~= self._dialogueid and not self._dialogueid end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DialogueEndTrigger.Check = function(self, ...)
  -- function num : 0_2 , upvalues : DialogueEndTrigger
  ((DialogueEndTrigger.super).Check)(self, ...)
  self._active = false
end

return DialogueEndTrigger

