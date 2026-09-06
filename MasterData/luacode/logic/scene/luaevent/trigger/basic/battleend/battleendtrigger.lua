local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local BattleEndTrigger = class("BattleEndTrigger", TriggerBase)
local status = {Success = 1, Fail = 0}

function BattleEndTrigger:Ctor(type, id, eventid, battleid, expected, instant)
  BattleEndTrigger.super.Ctor(self, type, id, eventid)
  self._battleid = battleid
  self._instant = instant
  self._expected = expected
end

function BattleEndTrigger:OnCheck(info)
  return (info.battleId == self._battleid or info.id == self._battleid or not self._battleid) and (not self._expected or status[self._expected] == info.battleResult)
end

function BattleEndTrigger:IsInstant()
  return self._instant
end

function BattleEndTrigger:Check(...)
  BattleEndTrigger.super.Check(self, ...)
  self._active = false
end

return BattleEndTrigger
