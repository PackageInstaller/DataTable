local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTBeforeRoleDie, _ = System.NewClass("BSTBeforeRoleDie", BattleStateTriggerServer)

function BSTBeforeRoleDie:OnRoleBeforeDeath(eventData)
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

function BSTBeforeRoleDie:RegisterCallbacks()
  self.battleEngine:RegisterEventToHead(BattleLogicEvent.RoleBeforeDeath, self.OnRoleBeforeDeath, self)
end

return BSTBeforeRoleDie
