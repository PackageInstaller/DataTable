local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTFixedDamageKill, Super = System.NewClass("BSTFixedDamageKill", BattleStateTriggerServer)

function BSTFixedDamageKill:SetEnv()
  self.eventId = BattleLogicEvent.FixedDamageKill
  self.triggerFunc = self.FixedDamageKill
end

function BSTFixedDamageKill:FixedDamageKill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  if not castRole then
    self.battleEngine:Error("固定伤害造成击杀触发器错误：找不到施法者", self.state.stateId, eventData.castRoleUid)
    return
  end
  if eventData.damageType ~= bc.DamageType.Fixed then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    },
    associator2 = {castRole},
    triggerValue = eventData.castDamage,
    triggerValue2 = eventData.realDamage,
    triggerValue3 = eventData.overflowDamage
  }
  self:Trigger(triggerData)
end

function BSTFixedDamageKill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.FixedDamageKill, self.FixedDamageKill, self)
end

return BSTFixedDamageKill
