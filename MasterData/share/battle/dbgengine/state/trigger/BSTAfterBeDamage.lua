local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterBeDamage, _ = System.NewClass("BSTAfterBeDamage", BattleStateTriggerServer)

function BSTAfterBeDamage:OnBeDamage(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local isimmue = eventData.immueDamage and 1 or 0
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    associator2 = {targetRole},
    triggerValue = eventData.castDamage,
    triggerValue2 = eventData.blockedDamage,
    triggerValue3 = eventData.realDamage,
    triggerValue4 = isimmue
  }
  self:Trigger(triggerData)
end

function BSTAfterBeDamage:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeDamage, self.OnBeDamage, self)
end

return BSTAfterBeDamage
