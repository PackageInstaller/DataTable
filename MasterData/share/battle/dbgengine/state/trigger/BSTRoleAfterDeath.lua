local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTRoleAfterDeath, Super = System.NewClass("BSTRoleAfterDeath", BattleStateTriggerServer)

function BSTRoleAfterDeath:OnRoleAfterDeath(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if targetRole:GetProperty(bc.RoleProperty.hp) > 0 then
    return
  end
  if self.state.owner.uid ~= eventData.targetRoleUid then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTRoleAfterDeath:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeath, self.OnRoleAfterDeath, self)
end

return BSTRoleAfterDeath
