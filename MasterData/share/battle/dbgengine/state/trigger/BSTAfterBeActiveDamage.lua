local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterBeActiveDamage, Super = System.NewClass("BSTAfterBeActiveDamage", BattleStateTriggerServer)

function BSTAfterBeActiveDamage:OnBeDamage(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if eventData.damageType ~= bc.DamageType.Active then
    return
  end
  local blockType = self.cbParams.triggerPara
  local triggerValue
  if blockType == bc.DamageTriggerType.None then
    triggerValue = eventData.castDamage
  elseif blockType == bc.DamageTriggerType.Unblocked then
    if eventData.realDamage <= 0 then
      return
    end
    triggerValue = eventData.unBlockedDamage
  elseif blockType == bc.DamageTriggerType.CritDamage then
    if not eventData.isCrit then
      return
    end
    triggerValue = eventData.realDamage
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    triggerValue = triggerValue,
    triggerValue2 = eventData.blockedDamage,
    triggerValue3 = eventData.realDamage,
    associator2 = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterBeActiveDamage:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeDamage, self.OnBeDamage, self)
end

return BSTAfterBeActiveDamage
