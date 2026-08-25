local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTPreventActiveDamage, Super = System.NewClass("BSTPreventActiveDamage", BattleStateTriggerServer)

function BSTPreventActiveDamage:OnPreventActiveDamage(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  if not castRole or not targetRole then
    return
  end
  local triggerValue = (eventData.realDamage or 0) + (eventData.blockLose or 0)
  local triggerData = {
    associator = {castRole},
    associator2 = {targetRole},
    triggerValue = triggerValue,
    triggerValue2 = eventData.convertDamageVal
  }
  self:Trigger(triggerData)
end

function BSTPreventActiveDamage:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoPreventedActiveDamage, self.OnPreventActiveDamage, self)
end

return BSTPreventActiveDamage
