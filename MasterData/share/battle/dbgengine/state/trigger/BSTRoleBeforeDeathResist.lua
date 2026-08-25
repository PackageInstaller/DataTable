local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTRoleBeforeDeathResist, Super = System.NewClass("BSTRoleBeforeDeathResist", BattleStateTriggerServer)

function BSTRoleBeforeDeathResist:OnRoleBeforeDeathResist(eventData)
  local target = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = target:GetCamp()
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

function BSTRoleBeforeDeathResist:RegisterCallbacks()
  self.battleEngine:RegisterEventToHead(BattleLogicEvent.RoleBeforeDeathResist, self.OnRoleBeforeDeathResist, self)
end

return BSTRoleBeforeDeathResist
