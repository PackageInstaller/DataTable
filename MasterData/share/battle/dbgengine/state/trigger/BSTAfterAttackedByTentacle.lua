local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterAttackedByTentacle, Super = System.NewClass("BSTAfterAttackedByTentacle", BattleStateTriggerServer)

function BSTAfterAttackedByTentacle:OnAttackedByTentacle(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local triggerData = {
    triggerValue = eventData.castDamage,
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterAttackedByTentacle:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AttackedByTentacle, self.OnAttackedByTentacle, self)
end

return BSTAfterAttackedByTentacle
