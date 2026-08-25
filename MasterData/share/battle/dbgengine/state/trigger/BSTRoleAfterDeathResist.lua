local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTRoleAfterDeathResist, Super = System.NewClass("BSTRoleAfterDeathResist", BattleStateTriggerServer)

function BSTRoleAfterDeathResist:OnRoleAfterDeathResist(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTRoleAfterDeathResist:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeathResist, self.OnRoleAfterDeathResist, self)
end

return BSTRoleAfterDeathResist
