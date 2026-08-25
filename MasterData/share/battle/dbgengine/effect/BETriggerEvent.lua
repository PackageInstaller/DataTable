local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BETriggerEvent, Super = System.NewClass("BETriggerEvent", BattleEffectServer)

function BETriggerEvent:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BETriggerEvent:DoEffect()
  Super.DoEffect(self)
  local eventId = self.params[1]
  if eventId == BattleLogicEvent.CardRemoveDimension then
    local targets = self.params[2]
    local cardUidList = {}
    for _, target in ipairs(targets) do
      table.insert(cardUidList, target.uid)
    end
    local eventData = {
      cardUidList = cardUidList,
      castRoleUid = self.cmdServer.castRoleUid
    }
    self.battleEngine.eventMgr:SendEvent(eventId, eventData)
  elseif eventId == BattleLogicEvent.ActiveDamageKill then
    local targets = self.params[2]
    local eventData = {
      targetRoleUid = targets and targets[1].uid,
      castRoleUid = self.cmdServer.castRoleUid,
      damageType = bc.DamageType.Active,
      overflowDamage = 0
    }
    self.battleEngine.eventMgr:SendEvent(eventId, eventData)
  end
  return true
end

return BETriggerEvent
