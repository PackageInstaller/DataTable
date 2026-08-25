local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTRoleBeforeRebirth, Super = System.NewClass("BSTRoleBeforeRebirth", BattleStateTriggerServer)

function BSTRoleBeforeRebirth:OnRoleBeforeRebirth(eventData)
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
    },
    ignoreDead = true
  }
  print("BSTRoleBeforeRebirth ", triggerData.ignoreDead)
  self:Trigger(triggerData)
end

function BSTRoleBeforeRebirth:RegisterCallbacks()
  self.battleEngine:RegisterEventToHead(BattleLogicEvent.RoleBeforeRebirth, self.OnRoleBeforeRebirth, self)
end

return BSTRoleBeforeRebirth
