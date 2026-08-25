local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTRoleAfterRebirth, Super = System.NewClass("BSTRoleAfterRebirth", BattleStateTriggerServer)

function BSTRoleAfterRebirth:OnRoleAfterRebirth(eventData)
  local target = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = target:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if eventData.targetRoleUid ~= self.state.owner.uid then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTRoleAfterRebirth:RegisterCallbacks()
  self.battleEngine:RegisterEventToHead(BattleLogicEvent.RoleAfterRebirth, self.OnRoleAfterRebirth, self)
end

return BSTRoleAfterRebirth
