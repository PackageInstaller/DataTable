-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/battleend/battleendtrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local BattleEndTrigger = class("BattleEndTrigger", TriggerBase)
local status = {Success = 1, Fail = 0}
BattleEndTrigger.Ctor = function(self, type, id, eventid, battleid, expected, instant)
  -- function num : 0_0 , upvalues : BattleEndTrigger
  ((BattleEndTrigger.super).Ctor)(self, type, id, eventid)
  self._battleid = battleid
  self._instant = instant
  self._expected = expected
end

BattleEndTrigger.OnCheck = function(self, info)
  -- function num : 0_1 , upvalues : status
  do return (info.battleId == self._battleid or info.id == self._battleid or not self._battleid) and not self._expected or status[self._expected] == info.battleResult end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattleEndTrigger.IsInstant = function(self)
  -- function num : 0_2
  return self._instant
end

BattleEndTrigger.Check = function(self, ...)
  -- function num : 0_3 , upvalues : BattleEndTrigger
  ((BattleEndTrigger.super).Check)(self, ...)
  self._active = false
end

return BattleEndTrigger

