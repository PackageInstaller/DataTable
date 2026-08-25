local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterFixedDamage, Super = System.NewClass("BSTAfterFixedDamage", BattleStateTriggerServer)

function BSTAfterFixedDamage:OnBeDamage(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if eventData.damageType ~= bc.DamageType.Fixed then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    triggerValue = eventData.castDamage,
    triggerValue2 = eventData.realDamage,
    associator2 = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterFixedDamage:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeDamage, self.OnBeDamage, self)
end

return BSTAfterFixedDamage
