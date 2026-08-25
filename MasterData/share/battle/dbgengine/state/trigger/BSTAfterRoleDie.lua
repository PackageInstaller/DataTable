local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterRoleDie, _ = System.NewClass("BSTAfterRoleDie", BattleStateTriggerServer)

function BSTAfterRoleDie:OnRoleAfterDeath(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  if targetRole:GetProperty(bc.RoleProperty.hp) > 0 then
    return
  end
  local triggerData = {
    triggerValue = eventData.castDamage,
    triggerValue2 = eventData.overflowDamage,
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    associator2 = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterRoleDie:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeath, self.OnRoleAfterDeath, self)
end

return BSTAfterRoleDie
